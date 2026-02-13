import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class DriverLiveTracker {
  StreamSubscription<Position>? _sub;
  DateTime? _lastSent;
  GeoPoint? _lastPoint;

  Future<void> startTracking({
    required String tripId,
    int minSeconds = 3,      // أقل زمن بين كل update
    double minMeters = 10,   // أقل مسافة يتحركها قبل update
  }) async {
    await stopTracking();

    _sub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5, // الجهاز يبعت تحديثات كتير (هنفلتر احنا)
      ),
    ).listen((pos) async {
      final now = DateTime.now();
      final current = GeoPoint(pos.latitude, pos.longitude);

      // 1) فلترة بالوقت
      if (_lastSent != null && now.difference(_lastSent!).inSeconds < minSeconds) {
        return;
      }

      // 2) فلترة بالمسافة
      if (_lastPoint != null) {
        final meters = Geolocator.distanceBetween(
          _lastPoint!.latitude, _lastPoint!.longitude,
          current.latitude, current.longitude,
        );
        if (meters < minMeters) return;
      }

      _lastSent = now;
      _lastPoint = current;

      // 3) ابعت على Firestore (shared داخل الرحلة)
      await FirebaseFirestore.instance.collection('trips').doc(tripId).update({
        "driverLiveLocation": current,
        "driverLastUpdate": FieldValue.serverTimestamp(),
      });
    });
  }

  Future<void> stopTracking() async {
    await _sub?.cancel();
    _sub = null;
  }
}
