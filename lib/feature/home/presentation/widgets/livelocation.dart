import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class LiveTrackScreen extends StatefulWidget {
  const LiveTrackScreen({super.key, required this.tripId});
  final String tripId;

  @override
  State<LiveTrackScreen> createState() => _LiveTrackScreenState();
}

class _LiveTrackScreenState extends State<LiveTrackScreen> {
  final MapController _map = MapController();

  List<LatLng> _routePoints = [];
  LatLng? _lastRoutedDriver; // آخر نقطة عملنا لها route

  Future<List<LatLng>> _fetchRouteOSRM(LatLng from, LatLng to) async {
    // OSRM expects lon,lat
    final url = Uri.parse(
      "https://router.project-osrm.org/route/v1/driving/"
      "${from.longitude},${from.latitude};${to.longitude},${to.latitude}"
      "?overview=full&geometries=geojson",
    );

    final res = await http.get(url);
    if (res.statusCode != 200) return [];

    final data = jsonDecode(res.body);
    final coords = data['routes'][0]['geometry']['coordinates'] as List;

    // coords: [[lon,lat], ...]
    return coords.map<LatLng>((c) => LatLng(c[1], c[0])).toList();
  }

  Future<void> _updateRouteIfNeeded(LatLng user, LatLng driver) async {
    // اعمل route أول مرة، وبعدها لما السائق يتحرك > 100 متر مثلاً
    final need =
        _lastRoutedDriver == null ||
        const Distance().as(LengthUnit.Meter, _lastRoutedDriver!, driver) > 100;

    if (!need) return;

    _lastRoutedDriver = driver;
    final pts = await _fetchRouteOSRM(driver, user); // من السائق للمستخدم
    if (!mounted) return;
    setState(() => _routePoints = pts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () async {
            await FirebaseFirestore.instance
                .collection('trips')
                .doc(widget.tripId)
                .update({"status": "finished"});
           context.pop();
          },

          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text("انهاء الرحلة",
            style: TextStyle(color: Colors.white,fontSize: 12),))),
        title: const Text("Live Track (Road Route)")),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('trips')
            .doc(widget.tripId)
            .snapshots(),
        builder: (context, snap) {
          if (!snap.hasData)
            return const Center(child: CircularProgressIndicator());
          final data = snap.data!.data();
          if (data == null) return const Center(child: Text("Trip not found"));

          final userGP = data['userlocation'] as GeoPoint?;
          final driverGP = data['driverlocation'] as GeoPoint?;

          if (userGP == null)
            return const Center(child: Text("No user location"));
          if (driverGP == null)
            return const Center(child: Text("Waiting driver live location..."));

          final user = LatLng(userGP.latitude, userGP.longitude);
          final driver = LatLng(driverGP.latitude, driverGP.longitude);

          // تابع السائق + حدّث route بمعدل معقول
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _map.move(
              driver,
              _map.camera.zoom,
            ); // خلي الكاميرا تتبع السائق (اختياري)
            _updateRouteIfNeeded(user, driver);
          });

          return FlutterMap(
            mapController: _map,
            options: MapOptions(initialCenter: driver, initialZoom: 15),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.ta9sela.app',
              ),

              // ✅ Route على الشوارع
              PolylineLayer(
                polylines: [
                  if (_routePoints.isNotEmpty)
                    Polyline(
                      points: _routePoints,
                      strokeWidth: 6,
                      color: Colors.green,
                    ),
                ],
              ),

              MarkerLayer(
                markers: [
                  Marker(
                    point: user,
                    width: 44,
                    height: 44,
                    child: const Icon(Icons.person_pin_circle, size: 44),
                  ),
                  Marker(
                    point: driver,
                    width: 44,
                    height: 44,
                    child: const Icon(Icons.local_taxi, size: 44),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
