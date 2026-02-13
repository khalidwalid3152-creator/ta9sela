// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:ta9sela/core/constants/app_images.dart';
// import 'package:ta9sela/core/routes/go_router.dart';
// import 'package:ta9sela/core/routes/navigations.dart';
// import 'package:ta9sela/core/utils/app_colors.dart';
// import 'package:ta9sela/feature/auth/data/UserType.dart';
// import 'package:ta9sela/feature/auth/data/validator.dart';
// import 'package:ta9sela/feature/auth/presentation/widgets/P_image.dart';
// import 'package:ta9sela/feature/auth/presentation/widgets/TextField.dart';
// import 'package:ta9sela/feature/auth/presentation/widgets/text_button.dart';
// import 'package:ta9sela/feature/home/data/cubits/DriverCubit/driverCubit.dart';
// import 'package:ta9sela/feature/home/data/cubits/driverCubit/driverState.dart';
// import 'package:ta9sela/feature/home/data/cubits/userCubit/usersCubit.dart';
// import 'package:ta9sela/feature/home/data/cubits/userCubit/userState.dart';
// import 'package:ta9sela/feature/home/data/models/driverModel.dart';
// import 'package:ta9sela/feature/home/data/models/userModel.dart';

// class Createuser extends StatefulWidget {
//   const Createuser({super.key, required this.usertype});
//   final Usertype usertype;

//   @override
//   State<Createuser> createState() => _CreateuserState();
// }

// class _CreateuserState extends State<Createuser> {
//   late TextEditingController emailController;
//   late TextEditingController nameController;
//   late TextEditingController phoneController;
//   late TextEditingController governorateController;
//   late TextEditingController passwordController;

//     String uploaded_image = '';

//   @override
//   void initState() {
//     super.initState();

//     emailController = TextEditingController();
//     nameController = TextEditingController();
//     phoneController = TextEditingController();
//     governorateController = TextEditingController();
//     passwordController = TextEditingController();
//   }

//   var formkey = GlobalKey<FormState>();
//   File? image;
//   String _getArabicUserType(Usertype usertype) {
//     switch (usertype) {
//       case Usertype.driver:
//         return 'سائق';
//       case Usertype.user:
//         return 'مستخدم';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     String typeUser = widget.usertype.name;
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<UserCubit, UserState>(
//           listener: (context, state) {
//             if (state is UserError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("حدث خطأ ما، يرجى المحاولة مرة أخرى")),
//               );
//             } else if (state is UserDone) {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text("تم إنشاء الحساب بنجاح")));
//               Navigations.push(context, AppRouter.layout);
//             }
//           },
//         ),

//         BlocListener<DriverCubit, DriverState>(
//           listener: (context, state) {
//             if (state is DriverError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("حدث خطأ ما، يرجى المحاولة مرة أخرى")),
//               );
//             } else if (state is DriverDone) {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text("تم إنشاء الحساب بنجاح")));
//               Navigations.push(context, AppRouter.layout);
//             }
//           },
//         ),
//       ],

//       child: Scaffold(
//         body: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Form(
//               key: formkey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "إنشاء حساب جديد  ${_getArabicUserType(widget.usertype)} ",
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 24),
//                   CustomTextField(
//                     controller: emailController,
//                     height: 50,
//                     prefixIcon: SvgPicture.asset(
//                       AppImages.email,
//                       color: AppColors.primaryColor1,
//                       height: 20,
//                     ),
//                     hintText: 'الإيميل',
//                     validator: Validators.validateEmail,
//                   ),
//                   SizedBox(height: 16),
//                   CustomTextField(
//                     controller: nameController,
//                     height: 50,
//                     prefixIcon: SvgPicture.asset(
//                       AppImages.person,
//                       color: AppColors.primaryColor1,
//                       height: 20,
//                     ),
//                     hintText: 'الاسم',
//                     validator: Validators.validateName,
//                   ),
//                   SizedBox(height: 16),
//                   CustomTextField(
//                     controller: phoneController,
//                     keyboardType: TextInputType.number,

//                     height: 50,
//                     prefixIcon: SvgPicture.asset(
//                       AppImages.phone,
//                       color: AppColors.primaryColor1,
//                       height: 20,
//                     ),
//                     hintText: 'رقم الهاتف',
//                     validator: Validators.validatePhone,
//                   ),
//                   SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ReusableImagePicker(

//                         onImageSelected: (file) => image = file,
//                         width: width * 0.4,
//                         height: 50,
//                         onImageUploaded: (uploaded) =>
//                             uploaded_image = uploaded,
//                       ),

//                       SizedBox(width: 16),
//                       CustomTextField(
//                         controller: governorateController,
//                         width: width * 0.4,
//                         height: 50,
//                         prefixIcon: SvgPicture.asset(
//                           AppImages.location,
//                           color: AppColors.primaryColor1,
//                           height: 20,
//                         ),
//                         hintText: 'المحافظه',
//                         validator: Validators.validateName,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   CustomTextField(
//                     controller: passwordController,
//                     height: 50,
//                     isPasswordField: true,
//                     prefixIcon: SvgPicture.asset(
//                       AppImages.lock,
//                       color: AppColors.primaryColor1,
//                       height: 20,
//                     ),
//                     hintText: 'كلمة مرور',
//                     validator: Validators.validatePassword,
//                   ),
//                   SizedBox(height: 30),
//                   TextButtonCustomer(
//                     text: 'إنشاء حساب',
//                     onPressed: () {
//                       var UCubit = context.read<UserCubit>();
//                       var DCubit = context.read<DriverCubit>();
//                       if (formkey.currentState!.validate()) {
//                         if (typeUser == 'user') {
//                           UCubit.createUser(
//                             UserModel(
//                               id: DateTime.now().millisecondsSinceEpoch
//                                   .toString(),
//                               name: nameController.text,
//                               email: emailController.text,
//                               phone: phoneController.text,
//                               userType: typeUser,
//                               governorate: governorateController.text,
//                               imageUrl: uploaded_image,
//                               password: passwordController.text

//                               // إضافة المزيد من الحقول حسب الحاجة
//                             ),
//                           );
//                         } else if (typeUser == 'driver') {
//                           DCubit.createDriver(
//                             DriverModel(
//                               id: DateTime.now().millisecondsSinceEpoch
//                                   .toString(),
//                               name: nameController.text,
//                               email: emailController.text,
//                               phone: phoneController.text,
//                               governorate: governorateController.text,
//                               profileImage: uploaded_image,
//                               carImage: '',
//                               rating: 0.0,
//                               totalTrips: 0,
//                               isOnline:false,
//                               lat: 0.0,
//                               lng: 0.0,
//                               password: passwordController.text,
//                             ),
//                           );
//                         }
//                       }
//                     },

//                     width: 120,
//                     height: 50,
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ta9sela/core/constants/app_images.dart';
import 'package:ta9sela/core/routes/go_router.dart';
import 'package:ta9sela/core/routes/navigations.dart';
import 'package:ta9sela/core/utils/app_colors.dart';
import 'package:ta9sela/feature/auth/data/validator.dart';
import 'package:ta9sela/feature/auth/presentation/widgets/P_image.dart';
import 'package:ta9sela/feature/auth/presentation/widgets/TextField.dart';
import 'package:ta9sela/feature/auth/presentation/widgets/text_button.dart';
import 'package:ta9sela/feature/home/data/cubits/driverCubit/driverCubit.dart';
import 'package:ta9sela/feature/home/data/cubits/driverCubit/driverState.dart';
import 'package:ta9sela/feature/home/data/cubits/userCubit/usersCubit.dart';
import 'package:ta9sela/feature/home/data/cubits/userCubit/userState.dart';
import 'package:ta9sela/feature/home/data/models/driverModel.dart';
import 'package:ta9sela/feature/home/data/models/userModel.dart';

class Createuser extends StatefulWidget {
  const Createuser({super.key, required this.usertype});
  final String usertype;

  @override
  State<Createuser> createState() => _CreateuserState();
}

class _CreateuserState extends State<Createuser> {
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController governorateController;
  late TextEditingController passwordController;

  String uploaded_image = '';

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    governorateController = TextEditingController();
    passwordController = TextEditingController();
  }

  var formkey = GlobalKey<FormState>();
  File? image;
  String _getArabicUserType(String usertype) {
    switch (usertype) {
      case "driver":
        return 'سائق';
      case "user":
        return 'مستخدم';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String typeUser = widget.usertype;
    return MultiBlocListener(
      listeners: [
        BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("حدث خطأ ما، يرجى المحاولة مرة أخرى")),
              );
            } else if (state is UserDone) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("تم إنشاء الحساب بنجاح")));
              Navigations.push(
                context,
                AppRouter.layout,
                extra: {'usertype': widget.usertype, 'user': state.user},
              );
            }
          },
        ),

        BlocListener<DriverCubit, DriverState>(
          listener: (context, state) {
            if (state is DriverError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("حدث خطأ ما، يرجى المحاولة مرة أخرى")),
              );
            } else if (state is DriverDone) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("تم إنشاء الحساب بنجاح")));
              Navigations.push(
                context,
                AppRouter.layout,
                extra: {'usertype': widget.usertype, 'user': state.driver},
              );
            }
          },
        ),
      ],

      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "إنشاء حساب جديد  ${_getArabicUserType(widget.usertype)} ",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24),
                  CustomTextField(
                    controller: emailController,
                    height: 50,
                    prefixIcon: SvgPicture.asset(
                      AppImages.email,
                      color: AppColors.primaryColor1,
                      height: 20,
                    ),
                    hintText: 'الإيميل',
                    validator: Validators.validateEmail,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: nameController,
                    height: 50,
                    prefixIcon: SvgPicture.asset(
                      AppImages.person,
                      color: AppColors.primaryColor1,
                      height: 20,
                    ),
                    hintText: 'الاسم',
                    validator: Validators.validateName,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,

                    height: 50,
                    prefixIcon: SvgPicture.asset(
                      AppImages.phone,
                      color: AppColors.primaryColor1,
                      height: 20,
                    ),
                    hintText: 'رقم الهاتف',
                    validator: Validators.validatePhone,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableImagePicker(
                        onImageSelected: (file) => image = file,
                        width: width * 0.4,
                        height: 50,
                        onImageUploaded: (uploaded) =>
                            uploaded_image = uploaded,
                      ),

                      SizedBox(width: 16),
                      CustomTextField(
                        controller: governorateController,
                        width: width * 0.4,
                        height: 50,
                        prefixIcon: SvgPicture.asset(
                          AppImages.location,
                          color: AppColors.primaryColor1,
                          height: 20,
                        ),
                        hintText: 'المحافظه',
                        validator: Validators.validateName,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: passwordController,
                    height: 50,
                    isPasswordField: true,
                    prefixIcon: SvgPicture.asset(
                      AppImages.lock,
                      color: AppColors.primaryColor1,
                      height: 20,
                    ),
                    hintText: 'كلمة مرور',
                    validator: Validators.validatePassword,
                  ),
                  SizedBox(height: 30),
                  TextButtonCustomer(
                    text: 'إنشاء حساب',
                    onPressed: () {
                      var UCubit = context.read<UserCubit>();
                      var DCubit = context.read<DriverCubit>();
                      if (formkey.currentState!.validate()) {
                        if (typeUser == 'user') {
                          UCubit.createUser(
                            UserModel(
                              id: DateTime.now().millisecondsSinceEpoch
                                  .toString(),
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              userType: typeUser,
                              governorate: governorateController.text,
                              imageUrl: uploaded_image,
                              password: passwordController.text,

                              // إضافة المزيد من الحقول حسب الحاجة
                            ),
                          );
                        } else if (typeUser == 'driver') {
                          DCubit.createDriver(
                            DriverModel(
                              id: DateTime.now().millisecondsSinceEpoch
                                  .toString(),
                              name: nameController.text,
                              userType: widget.usertype,
                              email: emailController.text,
                              phone: phoneController.text,
                              governorate: governorateController.text,
                              profileImage: uploaded_image,
                              carImage: '',
                              rating: 0.0,
                              totalTrips: 0,
                              isOnline: false,
                              lat: 0.0,
                              lng: 0.0,
                              password: passwordController.text,
                            ),
                          );
                        }
                      }
                    },

                    width: 120,
                    height: 50,
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
