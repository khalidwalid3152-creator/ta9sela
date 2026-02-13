import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:ta9sela/core/routes/go_router.dart';
import 'package:ta9sela/core/routes/navigations.dart';
import 'package:ta9sela/feature/home/data/cubits/tripCubit/tripCubit.dart';
import 'package:ta9sela/feature/home/data/cubits/tripCubit/tripState.dart';

class DriverHome extends StatefulWidget {
  DriverHome({super.key, required this.user, required this.usertype});

  dynamic user;
  String? usertype;

  @override
  State<DriverHome> createState() => _DriverHomeState();
}
class _DriverHomeState extends State<DriverHome> {
  @override
  void initState() {
    super.initState();
    context.read<TripCubit>().getUserTrips(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    final tripCubit = context.read<TripCubit>();

    return BlocListener<TripCubit, TripState>(
      listener: (context, state) {
        if (state is TripError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('حدث خطأ: ${state.message}')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header ... (زي ما هو)

                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    'الطلبات',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),

                Expanded(
                  child: BlocBuilder<TripCubit, TripState>(
                    builder: (context, state) {
                      if (state is TripLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is TripsLoaded) {
                        final pendingTrips = state.trips
                            .where((t) => t.status == 'pending')
                            .toList();

                        if (pendingTrips.isEmpty) {
                          return const Center(child: Text('لا توجد طلبات حالياً'));
                        }

                        return ListView.builder(
                          itemCount: pendingTrips.length,
                          itemBuilder: (context, index) {
                            final trip = pendingTrips[index];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    trip.imageUrl ??
                                        'https://cdn.pixabay.com/photo/2023/06/22/14/45/car-8081593_1280.png',
                                  ),
                                ),
                                title: Text(trip.username.toString()),
                                subtitle: Text(
                                  '${trip.createdAt.toString().substring(0, 10)}\nالي: ${trip.goto ?? trip.governorate}',
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _actionButton(
                                      icon: Icons.check,
                                      color: Colors.green,
                                      onTap: () async {
                                        final pos = await Geolocator.getCurrentPosition(
                                          desiredAccuracy: LocationAccuracy.high,
                                        );

                                        final userPoint = GeoPoint(pos.latitude, pos.longitude);

                                        await tripCubit.updateTripStatus(
                                          trip.id,
                                          'accepted',
                                          userPoint, // ✅ ابعتها مباشرة
                                        );

                                        Navigations.push(
                                          context,
                                          AppRouter.live,
                                          extra: trip.id,
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 20),
                                    _actionButton(
                                      icon: Icons.close,
                                      color: Colors.red,
                                      onTap: () async {
                                        await tripCubit.updateTripStatus(
                                          trip.id,
                                          'rejected',
                                          const GeoPoint(0, 0),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }

                      return const Center(child: Text('لا توجد طلبات حالياً'));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}
