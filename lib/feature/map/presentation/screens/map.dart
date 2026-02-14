import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:ta9sela/core/routes/go_router.dart';
import 'package:ta9sela/core/routes/navigations.dart';
import 'package:ta9sela/feature/home/data/cubits/driverCubit/driverCubit.dart';
import 'package:ta9sela/feature/home/data/cubits/driverCubit/driverState.dart';
import 'package:ta9sela/feature/home/data/models/driverModel.dart';


// ignore: must_be_immutable
class HistoryScreen extends StatefulWidget {
  HistoryScreen({super.key, required this.user});
  var user;
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  LatLng? currentLocation;
  final MapController mapController = MapController();
  List<DriverModel>? selectedDrivers;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint('Location permissions are permanently denied.');
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController.move(currentLocation!, 15);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_getCurrentLocation());
    return BlocListener<DriverCubit, DriverState>(
      listener: (context, state) {
        if (state is DriverDone) {
          selectedDrivers = state.drivers;
          for (var driver in selectedDrivers!) {
            debugPrint('Selected Driver: ${driver.name}');
            
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading : false,
          title:  Center(child: Text('موقعي الحالي')), ),
        body: currentLocation == null
            ? const Center(child: CircularProgressIndicator())
            : FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: currentLocation!,
                  initialZoom: 15,
                  onTap: (tapPosition, point) {
                    context.read<DriverCubit>().getDriversByGovernorate(
                      widget.user.governorate,
                    );

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (sheetContext) {
                        return BlocProvider.value(
                          value: context.read<DriverCubit>(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    ' السائقين المتاحين في محافظتك',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: BlocBuilder<DriverCubit, DriverState>(
                                    builder: (context, state) {
                                      if (state is DriverDone) {
                                        return ListView.builder(
                                          itemCount: state.drivers!.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: (){
                                                final driverDtail = state.drivers![index];

                                                Navigations.push(context, AppRouter.driverDetails,extra: {'driver': driverDtail, 'user': widget.user});
                                              },
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8,
                                                    ),
                                                padding: const EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset: const Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                              
                                                 child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage: NetworkImage(
                                                        state.drivers![index]
                                                            .profileImage,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 16),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            state.drivers![index].name,
                                                            style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 4),
                                                          Text(
                                                            'رقم الهاتف: ${state.drivers![index].phone}',
                                                          ),
                                                          const SizedBox(height: 4),
                                                          Text(
                                                            'المحافظه: ${state.drivers![index].governorate}',
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  
                                                  ],
                                                 )
                                                // Column(
                                                //   crossAxisAlignment:
                                                //       CrossAxisAlignment.start,
                                                //   children: [
                                                //     Text(
                                                //       state.drivers![index].name,
                                                //       style: const TextStyle(
                                                //         fontSize: 16,
                                                //         fontWeight:
                                                //             FontWeight.bold,
                                                //       ),
                                                //     ),
                                                //     const SizedBox(height: 4),
                                                //     Text(
                                                //       'رقم الهاتف: ${state.drivers![index].phone}',
                                                //     ),
                                                //     const SizedBox(height: 4),
                                                //     Text(
                                                //       'المحافظه: ${state.drivers![index].governorate}',
                                                //     ),
                                                //     IconButton(
                                                //       icon: Icon(Icons.phone),
                                                //       onPressed: () async {
                                                //         final url = Uri.parse(
                                                //           'tel:${state.drivers![index].phone}',
                                                //         );
                                                //         await launchUrl(url);
                                                //       },
                                                //     ),
                                                //   ],
                                                // ),
                                              ),
                                            );
                                            //  ListTile(
                                            //   title: Text(state.drivers![index].name),
                                            // );
                                          },
                                        );
                                      }
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.ta9sela',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: currentLocation!,
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
