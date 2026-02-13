// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:ta9sela/feature/home/data/cubits/tripCubit/tripCubit.dart';
// // import 'package:ta9sela/feature/home/data/cubits/tripCubit/tripState.dart';
// // import 'package:ta9sela/feature/home/data/models/TripModel.dart';

// // class History extends StatefulWidget {
// //   History({super.key, required this.user, required this.usertype});
// //   var user;
// //   String? usertype;

// //   @override
// //   State<History> createState() => _HistoryState();
// // }

// // class _HistoryState extends State<History> {
// //   List<TripModel> trips = [];
// //   @override
// //   @override
// //   Widget build(BuildContext context) {
// //     var tripCubit = context.read<TripCubit>();
// //     tripCubit.getUserTrips(widget.user.id!);

// //     return BlocListener<TripCubit, TripState>(
// //       listener: (context, state) {
// //         if (state is TripLoading) {
// //           CircularProgressIndicator();
// //         } else if (state is TripsLoaded) {
// //           for (var trip in state.trips) {
// //             print('STATUS => ${trip.status}');
// //           }
// //           trips = state.trips
// //               .where((trip) => trip.status == 'pending')
// //               .toList();
// //         } else if (state is TripError) {
// //           ScaffoldMessenger.of(
// //             context,
// //           ).showSnackBar(SnackBar(content: Text('حدث خطأ: ${state.message}')));
// //         }
// //       },
// //       child: Scaffold(
// //         appBar: AppBar(
// //           automaticallyImplyLeading: false,
// //           title: Center(
// //             child: Text(
// //               'سجل الرحلات',
// //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //             ),
// //           ),
// //         ),
// //         body: SingleChildScrollView(
// //           child: Padding(
// //             padding: const EdgeInsets.all(10.0),
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 border: Border.all(color: Colors.grey.shade300),
// //                 borderRadius: BorderRadius.circular(20),
// //               ),
// //               child: Column(
// //                 children: [
// //                   Container(
// //                     child: Column(
// //                       children: [
// //                         SizedBox(height: 20),

// //                         Text(
// //                           'الرحلات التي تم الموافقة عليها',
// //                           style: TextStyle(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.w400,
// //                           ),
// //                         ),
// //                         Divider(color: Colors.grey.shade300),
// //                         SizedBox(height: 10),
// //                         BlocBuilder<TripCubit, TripState>(
// //                           builder: (context, state) {
// //                             if (state is TripsLoaded) {
// //                               final pendingTrips = state.trips
// //                                   .where((trip) => trip.status == 'accepted')
// //                                   .toList();
// //                               return ListView.builder(
// //                                 shrinkWrap: true,
// //                                 physics: NeverScrollableScrollPhysics(),
// //                                 itemCount: pendingTrips.length,
// //                                 itemBuilder: (context, index) {
// //                                   final trip = pendingTrips[index];
// //                                   return Dismissible(
// //                                     key: Key(trip.id),
// //                                     background: Container(
                                     
// //                                       alignment: Alignment.centerRight,
// //                                       padding: EdgeInsets.symmetric(horizontal: 20),
// //                                       child: Icon(Icons.delete, color: Colors.red),
// //                                     ),
// //                                     onDismissed: (direction) {

// //                                       tripCubit.deleteTrip(trip.id);
// //                                       ScaffoldMessenger.of(context).showSnackBar(
// //                                         SnackBar(content: Text('تم حذف الرحلة')),
// //                                       );
// //                                     },
// //                                     child: Container(
// //                                       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
// //                                       decoration: BoxDecoration(
// //                                         border: Border.all(color: Colors.grey.shade300),
// //                                         borderRadius: BorderRadius.circular(10),
// //                                       ),
// //                                       child: ListTile(
// //                                         leading: CircleAvatar(
// //                                           backgroundImage: NetworkImage(
// //                                             trip.imageUrl ?? 'https://cdn.pixabay.com/photo/2023/06/22/14/45/car-8081593_1280.png',
// //                                           ),
// //                                         ),
// //                                         title: Text('رحلة إلى ${trip.goto??trip.governorate}'),
// //                                         subtitle: Text(
// //                                           '  ${trip.createdAt.toString().substring(0, 10)}',
// //                                        ),
                                       
// //                                       ),
// //                                     ),
// //                                   );
// //                                 },
// //                               );
// //                             } else if (state is TripError) {
// //                               return Center(
// //                                 child: Text('حدث خطأ: ${state.message}'),
// //                               );
// //                             } else {
// //                               return Center(child: CircularProgressIndicator());
// //                             }
// //                           },
// //                         ),
// //                         BlocBuilder<TripCubit, TripState>(
// //                           builder: (context, state) {
// //                             if (state is TripsLoaded) {
// //                               final pendingTrips = state.trips
// //                                   .where((trip) => trip.status == 'pending')
// //                                   .toList();
// //                               return ListView.builder(
// //                                 shrinkWrap: true,
// //                                 physics: NeverScrollableScrollPhysics(),
// //                                 itemCount: pendingTrips.length,
// //                                 itemBuilder: (context, index) {
// //                                   final trip = pendingTrips[index];
// //                                   return Dismissible(
// //                                     key: Key(trip.id),
// //                                     background: Container(
                                     
// //                                       alignment: Alignment.centerRight,
// //                                       padding: EdgeInsets.symmetric(horizontal: 20),
// //                                       child: Icon(Icons.delete, color: Colors.red),
// //                                     ),
// //                                     onDismissed: (direction) {

// //                                       tripCubit.deleteTrip(trip.id);
// //                                       ScaffoldMessenger.of(context).showSnackBar(
// //                                         SnackBar(content: Text('تم حذف الرحلة')),
// //                                       );
// //                                     },
// //                                     child: Container(
// //                                       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
// //                                       decoration: BoxDecoration(
// //                                         border: Border.all(color: Colors.grey.shade300),
// //                                         borderRadius: BorderRadius.circular(10),
// //                                       ),
// //                                       child: ListTile(
// //                                         leading: CircleAvatar(
// //                                           backgroundImage: NetworkImage(
// //                                             trip.imageUrl ?? 'https://cdn.pixabay.com/photo/2023/06/22/14/45/car-8081593_1280.png',
// //                                           ),
// //                                         ),
// //                                         title: Text('رحلة إلى ${trip.goto??trip.governorate}'),
// //                                         subtitle: Text(
// //                                           '  ${trip.createdAt.toString().substring(0, 10)}',
// //                                        ),
                                       
// //                                       ),
// //                                     ),
// //                                   );
// //                                 },
// //                               );
// //                             } else if (state is TripError) {
// //                               return Center(
// //                                 child: Text('حدث خطأ: ${state.message}'),
// //                               );
// //                             } else {
// //                               return Center(child: CircularProgressIndicator());
// //                             }
// //                           },
// //                         ),
// //                       ],
// //                     ),
// //                   ),

// //                   Container(
// //                     child: Column(
// //                       children: [
// //                         SizedBox(height: 20),
// //                         Divider(color: Colors.grey.shade300),

// //                         Text(
// //                           'الرحلات السابقة',
// //                           style: TextStyle(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.w400,
// //                           ),
// //                         ),
// //                         Divider(color: Colors.grey.shade300),
// //                         SizedBox(height: 10),
// //                         BlocBuilder<TripCubit, TripState>(
// //                           builder: (context, state) {
// //                             if (state is TripsLoaded) {
// //                               final Trips = state.trips
// //                                   .where((trip) => trip.status == 'finished')
// //                                   .toList();
// //                               return ListView.builder(
// //                                 shrinkWrap: true,
// //                                 physics: NeverScrollableScrollPhysics(),
// //                                 itemCount: Trips.length,
// //                                 itemBuilder: (context, index) {
// //                                   final trip =Trips[index];
// //                                   return Dismissible(
// //                                     key: Key(trip.id),
// //                                     background: Container(
                                     
// //                                       alignment: Alignment.centerRight,
// //                                       padding: EdgeInsets.symmetric(horizontal: 20),
// //                                       child: Icon(Icons.delete, color: Colors.red),
// //                                     ),
// //                                     onDismissed: (direction) {

// //                                       tripCubit.deleteTrip(trip.id);
// //                                       ScaffoldMessenger.of(context).showSnackBar(
// //                                         SnackBar(content: Text('تم حذف الرحلة')),
// //                                       );},
// //                                     child: ListTile(
// //                                       leading: CircleAvatar(
// //                                         backgroundImage: NetworkImage(
// //                                           'https://cdn.pixabay.com/photo/2023/06/22/14/45/car-8081593_1280.png',
// //                                         ),
// //                                       ),
// //                                       title: Text('رحلة إلى ${trip.governorate}'),
// //                                       subtitle: Text(
// //                                         '  ${trip.createdAt.toString().substring(0, 10)}',
// //                                       ),
                                      
// //                                     ),
// //                                   );
// //                                 },
// //                               );
// //                             } else if (state is TripError) {
// //                               return Center(
// //                                 child: Text('حدث خطأ: ${state.message}'),
// //                               );
// //                             } else {
// //                               return Center(child: CircularProgressIndicator());
// //                             }
// //                           },
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ta9sela/feature/home/data/cubits/tripCubit/tripCubit.dart';
// import 'package:ta9sela/feature/home/data/cubits/tripCubit/tripState.dart';
// import 'package:ta9sela/feature/home/data/models/TripModel.dart';

// class Histiry extends StatefulWidget {
//   Histiry({super.key, required this.user, required this.usertype});
//   var user;
//   String? usertype;

//   @override
//   State<Histiry> createState() => _HistoryState();
// }

// class _HistoryState extends State<Histiry> {
//   List<TripModel> trips = [];
//   @override
//   @override
//   Widget build(BuildContext context) {
//     var tripCubit = context.read<TripCubit>();
//     tripCubit.getDriverTrips(widget.user.id!);

//     return BlocListener<TripCubit, TripState>(
//       listener: (context, state) {
//         if (state is TripLoading) {
//           CircularProgressIndicator();
//         } else if (state is TripsLoaded) {
       
//           trips = state.trips
//               .where((trip) => trip.status == 'pending')
//               .toList();
//         } else if (state is TripError) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text('حدث خطأ: ${state.message}')));
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: Center(
//             child: Text(
//               'سجل الرحلات',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     child: Column(
//                       children: [
//                         SizedBox(height: 20),

//                         Text(
//                           'الرحلات التي في انتظار الموافقة',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         Divider(color: Colors.grey.shade300),
//                         SizedBox(height: 10),
//                         BlocBuilder<TripCubit, TripState>(
//                           builder: (context, state) {
//                             if (state is TripsLoaded) {
//                               final pendingTrips = state.trips
//                                   .where((trip) => trip.status == 'pending')
//                                   .toList();
//                               return ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: NeverScrollableScrollPhysics(),
//                                 itemCount: pendingTrips.length,
//                                 itemBuilder: (context, index) {
//                                   final trip = pendingTrips[index];
//                                   return Dismissible(
//                                       key: Key(trip.id),
//                                     background: Container(
                                     
//                                       alignment: Alignment.centerRight,
//                                       padding: EdgeInsets.symmetric(horizontal: 20),
//                                       child: Icon(Icons.delete, color: Colors.red),
//                                     ),
//                                     onDismissed: (direction) {

//                                       tripCubit.deleteTrip(trip.id);
//                                       ScaffoldMessenger.of(context).showSnackBar(
//                                         SnackBar(content: Text('تم حذف الرحلة')),
//                                       );},
//                                     child: Container(
//                                       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: Colors.grey.shade300),
//                                           borderRadius: BorderRadius.circular(10),
//                                         ),
//                                       child: ListTile(
//                                         leading: CircleAvatar(
//                                           backgroundImage: NetworkImage(trip.imageUrl ??
//                                             'https://cdn.pixabay.com/photo/2023/06/22/14/45/car-8081593_1280.png',
//                                           ),
//                                         ),
//                                         title: Text('رحلة إلى : ${trip.goto??trip.governorate} \n ${trip.createdAt.toString().substring(0, 10)}'),
                                       
                                       
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             } else if (state is TripError) {
//                               return Center(
//                                 child: Text('حدث خطأ: ${state.message}'),
//                               );
//                             } else {
//                               return Center(child: CircularProgressIndicator());
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     child: Column(
//                       children: [
//                         SizedBox(height: 20),
//                         Divider(color: Colors.grey.shade300),

//                         Text(
//                           'الرحلات التي تم الموافقة عليها',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         Divider(color: Colors.grey.shade300),
//                         SizedBox(height: 10),
//                         BlocBuilder<TripCubit, TripState>(
//                           builder: (context, state) {
//                             if (state is TripsLoaded) {
//                               final Trips = state.trips
//                                   .where((trip) => trip.status == 'accepted')
//                                   .toList();
//                               return ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: NeverScrollableScrollPhysics(),
//                                 itemCount: Trips.length,
//                                 itemBuilder: (context, index) {
//                                   final trip =Trips[index];
//                                   return Dismissible(
//                                     key: Key(trip.id),
//                                     background: Container(

                                     
//                                       alignment: Alignment.centerRight,
//                                       padding: EdgeInsets.symmetric(horizontal: 20),
//                                       child: Icon(Icons.delete, color: Colors.red),
//                                     ),
//                                     onDismissed: (direction) {

//                                       tripCubit.deleteTrip(trip.id);
//                                       ScaffoldMessenger.of(context).showSnackBar(
//                                         SnackBar(content: Text('تم حذف الرحلة')),
//                                       );},
                                      
//                                     child: Container(
//                                       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: Colors.grey.shade300),
//                                           borderRadius: BorderRadius.circular(10),
//                                         ),
//                                       child: ListTile(
//                                         leading: CircleAvatar(
//                                           backgroundImage: NetworkImage(
//                                             'https://cdn.pixabay.com/photo/2023/06/22/14/45/car-8081593_1280.png',
//                                           ),
//                                         ),
//                                         title: Text('رحلة إلى ${trip.goto??trip.governorate}'),
//                                         subtitle: Text(
//                                           ' ${trip.createdAt.toString().substring(0, 10)}',
//                                         ),
                                        
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             } else if (state is TripError) {
//                               return Center(
//                                 child: Text('حدث خطأ: ${state.message}'),
//                               );
//                             } else {
//                               return Center(child: CircularProgressIndicator());
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     child: Column(
//                       children: [
//                         SizedBox(height: 20),
//                         Divider(color: Colors.grey.shade300),

//                         Text(
//                           'الرحلات السابقة',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         Divider(color: Colors.grey.shade300),
//                         SizedBox(height: 10),
//                         BlocBuilder<TripCubit, TripState>(
//                           builder: (context, state) {
//                             if (state is TripsLoaded) {
//                               final Trips = state.trips
//                                   .where((trip) => trip.status == 'finished')
//                                   .toList();
//                               return ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: NeverScrollableScrollPhysics(),
//                                 itemCount: Trips.length,
//                                 itemBuilder: (context, index) {
//                                   final trip =Trips[index];
//                                   return Dismissible(
//                                     key: Key(trip.id),
//                                     background: Container(
                                     
//                                       alignment: Alignment.centerRight,
//                                       padding: EdgeInsets.symmetric(horizontal: 20),
//                                       child: Icon(Icons.delete, color: Colors.red),
//                                     ),
//                                     onDismissed: (direction) {

//                                       tripCubit.deleteTrip(trip.id);
//                                       ScaffoldMessenger.of(context).showSnackBar(
//                                         SnackBar(content: Text('تم حذف الرحلة')),
//                                       );},
//                                     child: Container(
//                                       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: Colors.grey.shade300),
//                                           borderRadius: BorderRadius.circular(10),
//                                         ),
//                                       child: ListTile(
//                                         leading: CircleAvatar(
//                                           backgroundImage: NetworkImage(
//                                             'https://cdn.pixabay.com/photo/2023/06/22/14/45/car-8081593_1280.png',
//                                           ),
//                                         ),
//                                         title: Text('رحلة إلى ${trip.goto??trip.governorate}'),
//                                         subtitle: Text(
//                                           ' ${trip.createdAt.toString().substring(0, 10)}',
//                                         ),
                                       
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             } else if (state is TripError) {
//                               return Center(
//                                 child: Text('حدث خطأ: ${state.message}'),
//                               );
//                             } else {
//                               return Center(child: CircularProgressIndicator());
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
                  
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ta9sela/feature/home/data/cubits/tripCubit/tripCubit.dart';
import 'package:ta9sela/feature/home/data/cubits/tripCubit/tripState.dart';
import 'package:ta9sela/feature/home/data/models/TripModel.dart';

class History extends StatefulWidget {
  const History({super.key, required this.user, required this.usertype});

  final dynamic user;
  final String? usertype;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
    // ✅ مرة واحدة بس
    context.read<TripCubit>().getUserTrips(widget.user.id!);
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('حذف الرحلة؟'),
            content: const Text('متأكد إنك عايز تحذف الرحلة؟'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('حذف', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ) ??
        false;
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'سجل الرحلات',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20),
            ),
            child: BlocBuilder<TripCubit, TripState>(
              builder: (context, state) {
                if (state is TripLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is TripError) {
                  return Center(child: Text('حدث خطأ: ${state.message}'));
                }

                if (state is TripsLoaded) {
                  final pending = state.trips.where((t) => t.status == 'pending').toList();
                  final accepted = state.trips.where((t) => t.status == 'accepted').toList();
                  final finished = state.trips.where((t) => t.status == 'finished').toList();

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 14),

                        _Section(
                          title: 'الرحلات التي في انتظار الموافقة',
                          trips: pending,
                          onDelete: (trip) async {
                            final ok = await _confirmDelete(context);
                            if (!ok) return;
                            await tripCubit.deleteTrip(trip.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم حذف الرحلة')),
                            );
                          },
                        ),

                        _Divider(),

                        _Section(
                          title: 'الرحلات التي تم الموافقة عليها',
                          trips: accepted,
                          onDelete: (trip) async {
                            final ok = await _confirmDelete(context);
                            if (!ok) return;
                            await tripCubit.deleteTrip(trip.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم حذف الرحلة')),
                            );
                          },
                        ),

                        _Divider(),

                        _Section(
                          title: 'الرحلات السابقة',
                          trips: finished,
                          onDelete: (trip) async {
                            final ok = await _confirmDelete(context);
                            if (!ok) return;
                            await tripCubit.deleteTrip(trip.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم حذف الرحلة')),
                            );
                          },
                        ),

                        const SizedBox(height: 14),
                      ],
                    ),
                  );
                }

                return const Center(child: Text('لا توجد بيانات'));
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 6),
        Divider(color: Colors.grey.shade300),
        const SizedBox(height: 6),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.trips,
    required this.onDelete,
  });

  final String title;
  final List<TripModel> trips;
  final Future<void> Function(TripModel trip) onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
        Divider(color: Colors.grey.shade300),
        const SizedBox(height: 10),

        if (trips.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Text('لا توجد رحلات'),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];

              return Dismissible(
                key: ValueKey(trip.id),
                direction: DismissDirection.endToStart,
                confirmDismiss: (_) => _confirmDismiss(context),
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.red.withOpacity(.08),
                  child: const Icon(Icons.delete, color: Colors.red),
                ),
                onDismissed: (_) => onDelete(trip),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        trip.imageUrl ??
                            'https://cdn.pixabay.com/photo/2023/06/22/14/45/car-8081593_1280.png',
                      ),
                    ),
                    title: Text('رحلة إلى: ${trip.goto ?? trip.governorate}'),
                    subtitle: Text('${trip.createdAt.toString().substring(0, 10)}'),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  Future<bool> _confirmDismiss(BuildContext context) async {
    // منع السحب بدون تأكيد (confirmDismiss لازم)
    return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('حذف الرحلة؟'),
            content: const Text('متأكد إنك عايز تحذف الرحلة؟'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('إلغاء')),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('حذف', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ) ??
        false;
  }
}
