// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloudinary_public/cloudinary_public.dart';
// import 'package:ta9sela/feature/auth/data/UserType.dart';
// import 'package:ta9sela/feature/home/data/cubits/driverCubit/driverCubit.dart';
// import 'package:ta9sela/feature/home/data/cubits/driverCubit/driverState.dart';
// import 'package:ta9sela/feature/home/data/cubits/userCubit/userState.dart';
// import 'package:ta9sela/feature/home/data/cubits/userCubit/usersCubit.dart';
// import 'package:ta9sela/feature/home/data/models/driverModel.dart';
// import 'package:ta9sela/feature/home/data/models/userModel.dart';
// import 'package:ta9sela/feature/profile/presentation/screens/update_profile.dart';
// import 'package:ta9sela/feature/profile/presentation/widgets/build_info_item.dart';

// class ProfileScreen extends StatefulWidget {
//   ProfileScreen({super.key, required this.user, required this.usertype});
//   String? usertype;
//   var user;

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   dynamic userdata() {
//     if (widget.usertype == Usertype.driver.name.toString()) {
//       return widget.user as DriverModel;
//     } else if (widget.usertype == Usertype.user.name.toString()) {
//       return widget.user as UserModel;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var userp = userdata();
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<UserCubit, UserState>(
//           listener: (context, state) {
//             if (state is UserDone) {
//               setState(() {
//                 widget.user = state.user;
//               });
//             }
//             // ممكن تضيف هنا لوجيك لو حبيت تتعامل مع حالات معينة بعد التحديث
//           },
//         ),
//         BlocListener<DriverCubit, DriverState>(
//           listener: (context, state) {
//             if (state is DriverDone) {
//               setState(() {
//                 widget.user = state.driver;
//               });
//             }
//             // ممكن تضيف هنا لوجيك لو حبيت تتعامل مع حالات معينة بعد التحديث
//           },
//         ),
//       ],
//       child: Scaffold(
//         backgroundColor: Colors.grey[200],
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 20),

//                   /// العنوان
//                   const Text(
//                     'الحساب الشخصي',
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),

//                   const SizedBox(height: 30),

//                   /// صورة البروفايل
//                   Stack(
//                     alignment: Alignment.bottomRight,
//                     children: [
//                       CircleAvatar(
//                         radius: 70,
//                         backgroundColor: Colors.black12,
//                         backgroundImage: NetworkImage(
//                           widget.usertype == 'driver'
//                               ? userdata().profileImage!.toString()
//                               : widget.usertype == 'user'
//                               ? userdata().imageUrl!.toString()
//                               : 'https://as1.ftcdn.net/v2/jpg/02/10/13/14/1000_F_210131451_583TTW0JqiSuEb8eWIjCYrzv8sy2VJBQ.jpg',
//                         ),
//                       ),

//                       // Container(
//                       //   padding: const EdgeInsets.all(6),
//                       //   decoration: const BoxDecoration(
//                       //     color: Colors.green,
//                       //     shape: BoxShape.circle,
//                       //   ),
//                       //   child: CameraEditButton(
//                       //     onUploaded: (imageUrl) {
//                       //       setState(() {
//                       //         _imageUrl = imageUrl;
//                       //         print(imageUrl);
//                       //         print(imageUrl);
//                       //       });
//                       //       // تعامل مع URL الصورة المرفوعة
//                       //     },
//                       //   ),
//                       // ),
//                     ],
//                   ),

//                   SizedBox(height: 30),

//                   /// البيانات
//                   buildInfoItem(title: 'الايميل', value: '${userp.email}'),
//                   buildInfoItem(title: 'الاسم', value: '${userp.name}'),
//                   buildInfoItem(title: 'رقم الهاتف', value: '${userp.phone}'),
//                   buildInfoItem(
//                     title: 'المحافظة',
//                     value: '${userp.governorate}',
//                   ),

//                   SizedBox(height: 30),

//                   /// زر التحديث
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.5,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       onPressed: () async {
//                         if (widget.user.userType == 'user') {
//                           final updatedUser = await Navigator.push<UserModel>(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => EditProfileScreen(user: userp),
//                             ),
//                           );

//                           if (updatedUser != null) {
//                             setState(() {
//                               widget.user =
//                                   updatedUser; // أو خليه متغير في الـ state بدل widget.user
//                             });
//                           }
//                         } else if (widget.user.userType == 'driver') {
//                           final updatedDriver = await Navigator.push<DriverModel>(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => EditProfileScreen(user: userp),
//                             ),
//                           );

//                           if (updatedDriver != null) {
//                             setState(() {
//                               widget.user =
//                                   updatedDriver;
//                               widget.user = updatedDriver; // أو خليه متغير في الـ state بدل widget.user
//                             });
//                             setState(() {
//                               widget.user = updatedUser; // أو خليه متغير في الـ state بدل widget.user
//                             });
//                           }
//                         }
//                       },
//                       child: const Text(
//                         'تعديل البيانات',
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CameraEditButton extends StatefulWidget {
//   final Function(String imageUrl) onUploaded;

//   const CameraEditButton({super.key, required this.onUploaded});

//   @override
//   State<CameraEditButton> createState() => _CameraEditButtonState();
// }

// class _CameraEditButtonState extends State<CameraEditButton> {
//   bool _isUploading = false;

//   final CloudinaryPublic _cloudinary = CloudinaryPublic(
//     'dfplculyh',
//     'kimage',
//     cache: false,
//   );

//   Future<void> _pickAndUpload(ImageSource source) async {
//     final picked = await ImagePicker().pickImage(
//       source: source,
//       imageQuality: 80,
//       maxWidth: 800,
//     );

//     if (picked == null) return;

//     setState(() => _isUploading = true);

//     try {
//       final response = await _cloudinary.uploadFile(
//         CloudinaryFile.fromFile(
//           File(picked.path).path,
//           resourceType: CloudinaryResourceType.Image,
//         ),
//       );

//       widget.onUploaded(response.secureUrl);
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('فشل رفع الصورة')));
//     }

//     setState(() => _isUploading = false);
//   }

//   void _showOptions() {
//     showModalBottomSheet(
//       context: context,
//       builder: (_) => Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             title: const Text('المعرض', textAlign: TextAlign.center),
//             onTap: () {
//               Navigator.pop(context);
//               _pickAndUpload(ImageSource.gallery);
//             },
//           ),
//           ListTile(
//             title: const Text('الكاميرا', textAlign: TextAlign.center),
//             onTap: () {
//               Navigator.pop(context);
//               _pickAndUpload(ImageSource.camera);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _showOptions,
//       child: CircleAvatar(
//         radius: 18,
//         backgroundColor: Colors.green,
//         child: _isUploading
//             ? const SizedBox(
//                 width: 15,
//                 height: 15,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   color: Colors.white,
//                 ),
//               )
//             : const Icon(Icons.camera_alt, size: 18, color: Colors.white),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ta9sela/feature/auth/data/UserType.dart';
import 'package:ta9sela/feature/home/data/cubits/driverCubit/driverCubit.dart';
import 'package:ta9sela/feature/home/data/cubits/driverCubit/driverState.dart';
import 'package:ta9sela/feature/home/data/cubits/userCubit/userState.dart';
import 'package:ta9sela/feature/home/data/cubits/userCubit/usersCubit.dart';
import 'package:ta9sela/feature/home/data/models/driverModel.dart';
import 'package:ta9sela/feature/home/data/models/userModel.dart';
import 'package:ta9sela/feature/profile/presentation/screens/update_profile.dart';
import 'package:ta9sela/feature/profile/presentation/widgets/build_info_item.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, required this.user, required this.usertype});

  String? usertype;
  var user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  /// ✅ النسخة اللي الصفحة هتعرضها دايمًا
  dynamic currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = widget.user; // ✅ خزّن أول قيمة جاية من برا
  }

  bool get isDriver => widget.usertype == Usertype.driver.name;

  dynamic userdata() {
    if (isDriver) {
      return currentUser as DriverModel;
    } else {
      return currentUser as UserModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userp = userdata();

    const fallbackImage =
        'https://as1.ftcdn.net/v2/jpg/02/10/13/14/1000_F_210131451_583TTW0JqiSuEb8eWIjCYrzv8sy2VJBQ.jpg';

    final String img = isDriver
        ? ((userp.profileImage ?? '').toString())
        : ((userp.imageUrl ?? '').toString());

    return MultiBlocListener(
      listeners: [
        BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserDone) {
              setState(() {
                currentUser = state.user; // ✅ تحديث المستخدم
              });
            }
          },
        ),
        BlocListener<DriverCubit, DriverState>(
          listener: (context, state) {
            if (state is DriverDone) {
              setState(() {
                currentUser = state.driver; // ✅ تحديث السواق
              });
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  const Text(
                    'الحساب الشخصي',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 30),

                  /// صورة البروفايل
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.black12,
                        backgroundImage: NetworkImage(
                          img.isNotEmpty ? img : fallbackImage,
                        ),
                      ),

                      // لو هترجع تفعّل زر تعديل الصورة على البروفايل:
                      // Positioned(
                      //   bottom: 0,
                      //   right: 0,
                      //   child: CameraEditButton(
                      //     onUploaded: (imageUrl) {
                      //       setState(() {
                      //         if (isDriver) {
                      //           // لو عايز تحدث الصورة محليًا
                      //           final d = currentUser as DriverModel;
                      //           currentUser = d.copyWith(profileImage: imageUrl);
                      //         } else {
                      //           final u = currentUser as UserModel;
                      //           currentUser = u.copyWith(imageUrl: imageUrl);
                      //         }
                      //       });
                      //     },
                      //   ),
                      // ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// البيانات
                  buildInfoItem(title: 'الايميل', value: '${userp.email}'),
                  buildInfoItem(title: 'الاسم', value: '${userp.name}'),
                  buildInfoItem(title: 'رقم الهاتف', value: '${userp.phone}'),
                  buildInfoItem(title: 'المحافظة', value: '${userp.governorate}'),

                  const SizedBox(height: 30),

                  /// زر التحديث
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () async {
                        if (!isDriver) {
                          final updatedUser = await Navigator.push<UserModel>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditProfileScreen(user: userp),
                            ),
                          );

                          if (updatedUser != null) {
                            setState(() {
                              currentUser = updatedUser; // ✅
                            });
                          }
                        } else {
                          final updatedDriver = await Navigator.push<DriverModel>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditProfileScreen(user: userp),
                            ),
                          );

                          if (updatedDriver != null) {
                            setState(() {
                              currentUser = updatedDriver; // ✅
                            });
                          }
                        }
                      },
                      child: const Text(
                        'تعديل البيانات',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CameraEditButton extends StatefulWidget {
  final Function(String imageUrl) onUploaded;

  const CameraEditButton({super.key, required this.onUploaded});

  @override
  State<CameraEditButton> createState() => _CameraEditButtonState();
}

class _CameraEditButtonState extends State<CameraEditButton> {
  bool _isUploading = false;

  final CloudinaryPublic _cloudinary = CloudinaryPublic(
    'dfplculyh',
    'kimage',
    cache: false,
  );

  Future<void> _pickAndUpload(ImageSource source) async {
    final picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 800,
    );

    if (picked == null) return;

    setState(() => _isUploading = true);

    try {
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          File(picked.path).path,
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      widget.onUploaded(response.secureUrl);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل رفع الصورة')),
      );
    }

    setState(() => _isUploading = false);
  }

  void _showOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('المعرض', textAlign: TextAlign.center),
            onTap: () {
              Navigator.pop(context);
              _pickAndUpload(ImageSource.gallery);
            },
          ),
          ListTile(
            title: const Text('الكاميرا', textAlign: TextAlign.center),
            onTap: () {
              Navigator.pop(context);
              _pickAndUpload(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showOptions,
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.green,
        child: _isUploading
            ? const SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.camera_alt, size: 18, color: Colors.white),
      ),
    );
  }
}
