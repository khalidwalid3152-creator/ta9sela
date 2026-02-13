import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:ta9sela/feature/home/data/cubits/tripCubit/tripCubit.dart';
import 'package:ta9sela/feature/home/data/cubits/tripCubit/tripState.dart';
import 'package:ta9sela/feature/home/data/models/TripModel.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Driverdetails extends StatefulWidget {
  Driverdetails({super.key, required this.driver, required this.user});
  var driver;
  var user;
  @override
  State<Driverdetails> createState() => _DriverdetailsState();
}

class _DriverdetailsState extends State<Driverdetails> {
  @override
  Widget build(BuildContext context) {
    var gotoController = TextEditingController();
    return BlocListener<TripCubit, TripState>(
      listener: (context, state) {
        if (state is TripLoading) {
          CircularProgressIndicator();
        } else if (state is TripCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(' تم طلب الرحلة بنجاح في انتظار موافقة السائق'),
            ),
          );
          context.pop();
          context.pop();
          context.pop();
        } else if (state is TripError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('حدث خطأ: ${state.message}')));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text('تفاصيل السائق')),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2023/06/22/14/45/car-8081593_1280.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        right: 16,
                        left: 16,
                        bottom: -50,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              widget.driver.profileImage.toString() ??
                                  'https://png.pngtree.com/png-clipart/20191027/ourlarge/pngtree-outline-person-icon-png-image_1869918.jpg',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 70),
                Center(
                  child: Text(
                    ' ${widget.driver.name}:الاسم ',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    ' ${widget.driver.phone}:الهاتف',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    ' ${widget.driver.governorate} :المحافظه',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    textAlign: TextAlign.right, 
                    controller: gotoController,
                    decoration: InputDecoration(
                      hintText: 'إلى أين تريد الذهاب؟',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        final pos = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high,
                        );
                
                        final userPoint = GeoPoint(pos.latitude, pos.longitude);
                        var tripCubit = context.read<TripCubit>();
                        tripCubit.createTrip(
                          TripModel(
                            id: '',
                            userId: widget.user.id,
                            driverId: widget.driver.id,
                            governorate: widget.user.governorate,
                            status: 'pending',
                            username: widget.user.name,
                            drivername: widget.driver.name,
                            createdAt: DateTime.now(),
                            userlocation: userPoint,
                            imageUrl: widget.user.imageUrl,
                            goto: gotoController.text,
                          ),
                          
                        );
                      },
                      icon: Icon(
                        Icons.arrow_circle_left_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                      label: Text(
                        'طلب رحله ',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4CAF50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.phone, color: Colors.white),
                        onPressed: () async {
                          final url = Uri.parse('tel:${widget.driver.phone}');
                          await launchUrl(url);
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Text('الاتصال بالسائق', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
