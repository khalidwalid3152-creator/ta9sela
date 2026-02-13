import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ta9sela/feature/home/data/cubits/tripCubit/tripCubit.dart';
import 'package:ta9sela/feature/home/data/cubits/tripCubit/tripState.dart';
import 'package:ta9sela/feature/home/data/models/TripModel.dart';

class Histirydriver extends StatefulWidget {
  Histirydriver({super.key, required this.user, required this.usertype});
  var user;
  String? usertype;

  @override
  State<Histirydriver> createState() => _HistoryState();
}

class _HistoryState extends State<Histirydriver> {
  List<TripModel> trips = [];
  @override
  @override
  Widget build(BuildContext context) {
    var tripCubit = context.read<TripCubit>();
    tripCubit.getDriverTrips(widget.user.id!);

    return BlocListener<TripCubit, TripState>(
      listener: (context, state) {
        if (state is TripLoading) {
          CircularProgressIndicator();
        } else if (state is TripsLoaded) {
         
          trips = state.trips
              .where((trip) => trip.status == 'pending')
              .toList();
        } else if (state is TripError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('حدث خطأ: ${state.message}')));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'سجل الرحلات',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 20),

                        Text(
                          'الرحلات التي في انتظار الموافقة',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Divider(color: Colors.grey.shade300),
                        SizedBox(height: 10),
                        BlocBuilder<TripCubit, TripState>(
                          builder: (context, state) {
                            if (state is TripsLoaded) {
                              final pendingTrips = state.trips
                                  .where((trip) => trip.status == 'pending')
                                  .toList();
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: pendingTrips.length,
                                itemBuilder: (context, index) {
                                  final trip = pendingTrips[index];
                                  return Dismissible(
                                      key: Key(trip.id),
                                    background: Container(
                                     
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Icon(Icons.delete, color: Colors.red),
                                    ),
                                    onDismissed: (direction) {

                                      tripCubit.deleteTrip(trip.id);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('تم حذف الرحلة')),
                                      );},
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(trip.imageUrl ??
                                            'https://cdn.pixabay.com/photo/2023/06/22/14/45/car-8081593_1280.png',
                                          ),
                                        ),
                                        title: Text('رحلة إلى : ${trip.goto??trip.governorate} \n ${trip.createdAt.toString().substring(0, 10)}'),
                                       
                                       
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (state is TripError) {
                              return Center(
                                child: Text('حدث خطأ: ${state.message}'),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Divider(color: Colors.grey.shade300),

                        Text(
                          'الرحلات التي تم الموافقة عليها',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Divider(color: Colors.grey.shade300),
                        SizedBox(height: 10),
                        BlocBuilder<TripCubit, TripState>(
                          builder: (context, state) {
                            if (state is TripsLoaded) {
                              final Trips = state.trips
                                  .where((trip) => trip.status == 'accepted')
                                  .toList();
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: Trips.length,
                                itemBuilder: (context, index) {
                                  final trip =Trips[index];
                                  return Dismissible(
                                    key: Key(trip.id),
                                    background: Container(

                                     
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Icon(Icons.delete, color: Colors.red),
                                    ),
                                    onDismissed: (direction) {

                                      tripCubit.deleteTrip(trip.id);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('تم حذف الرحلة')),
                                      );},
                                      
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(trip.imageUrl??
                                            'https://cdn.pixabay.com/photo/2023/06/22/14/45/car-8081593_1280.png',
                                          ),
                                        ),
                                        title: Text('رحلة إلى ${trip.goto??trip.governorate}'),
                                        subtitle: Text(
                                          ' ${trip.createdAt.toString().substring(0, 10)}',
                                        ),
                                        
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (state is TripError) {
                              return Center(
                                child: Text('حدث خطأ: ${state.message}'),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Divider(color: Colors.grey.shade300),

                        Text(
                          'الرحلات السابقة',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Divider(color: Colors.grey.shade300),
                        SizedBox(height: 10),
                        BlocBuilder<TripCubit, TripState>(
                          builder: (context, state) {
                            if (state is TripsLoaded) {
                              final Trips = state.trips
                                  .where((trip) => trip.status == 'finished')
                                  .toList();
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: Trips.length,
                                itemBuilder: (context, index) {
                                  final trip =Trips[index];
                                  return Dismissible(
                                    key: Key(trip.id),
                                    background: Container(
                                     
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Icon(Icons.delete, color: Colors.red),
                                    ),
                                    onDismissed: (direction) {

                                      tripCubit.deleteTrip(trip.id);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('تم حذف الرحلة')),
                                      );},
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage( trip.imageUrl??
                                            'https://cdn.pixabay.com/photo/2023/06/22/14/45/car-8081593_1280.png',
                                          ),
                                        ),
                                        title: Text('رحلة إلى ${trip.goto??trip.governorate}'),
                                        subtitle: Text(
                                          ' ${trip.createdAt.toString().substring(0, 10)}',
                                        ),
                                       
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (state is TripError) {
                              return Center(
                                child: Text('حدث خطأ: ${state.message}'),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
