import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ta9sela/core/constants/app_images.dart';
import 'package:ta9sela/core/routes/go_router.dart';
import 'package:ta9sela/core/routes/navigations.dart';
import 'package:ta9sela/core/utils/app_colors.dart';
import 'package:ta9sela/feature/auth/data/UserType.dart';
import 'package:ta9sela/feature/auth/data/validator.dart';
import 'package:ta9sela/feature/auth/presentation/widgets/TextField.dart';
import 'package:ta9sela/feature/auth/presentation/widgets/text_button.dart';
import 'package:ta9sela/feature/home/data/cubits/driverCubit/driverState.dart';
import 'package:ta9sela/feature/home/data/cubits/driverCubit/driverCubit.dart';
import 'package:ta9sela/feature/home/data/cubits/userCubit/userState.dart';
import 'package:ta9sela/feature/home/data/cubits/userCubit/usersCubit.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key, required this.usertype});
  final String usertype;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formkey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  
  }
  var userPage2;
  @override
  Widget build(BuildContext context) {
    // String typeUser = usertype.name;

    return MultiBlocListener(
      listeners: [
        BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserDone) {
              setState(() {
               userPage2=state.user;

              });
              // إخفاء مؤشر التحميل
              // التنقل إلى الشاشة الرئيسية أو أي شاشة أخرى
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("تم تسجيل الدخول بنجاح")));
              Navigations.push(context, AppRouter.layout, extra: {
                'usertype':widget.usertype,
                'user':userPage2,
              });
            } else if (state is UserError) {
              // إخفاء مؤشر التحميل
              Navigator.of(context).pop();
              // إظهار رسالة الخطأ
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
        BlocListener<DriverCubit, DriverState>(
          listener: (context, state) {
            if (state is DriverDone) {
              setState(() {
                userPage2=state.driver;
                
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم تسجيل الدخول بنجاح")),
                );
                Navigations.push(context, AppRouter.layout, extra: {
                  'usertype':widget.usertype.toString(),
                  'user':userPage2,
                });
              });
            } else if (state is DriverError) {
              // إخفاء مؤشر التحميل
              Navigator.of(context).pop();
              // إظهار رسالة الخطأ
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("حدث خطأ أثناء تسجيل الدخول")),
              );
            }
            // يمكنك إضافة مستمع آخر إذا لزم الأمر
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // العنوان
                  const Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 50),

                  // حقل الإيميل
                  CustomTextField(
                    controller: emailController,
                    validator: Validators.validateEmail,
                    height: 50,
                    prefixIcon: SvgPicture.asset(
                      AppImages.email,
                      color: AppColors.primaryColor1,
                      height: 20,
                    ),
                    hintText: 'الإيميل',
                  ),

                  const SizedBox(height: 16),

                  // حقل كلمة المرور
                  CustomTextField(
                    controller: passwordController,
                    validator: Validators.validatePassword,
                    height: 50,
                    isPasswordField: true,
                    prefixIcon: SvgPicture.asset(
                      AppImages.lock,
                      color: AppColors.primaryColor1,
                      height: 20,
                    ),
                    hintText: 'كلمة المرور',
                  ),

                  const SizedBox(height: 12),

                  // نسيت كلمة المرور
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: اذهب لصفحة استعادة كلمة المرور
                      },
                      child: Text(
                        'نسيت كلمة المرور',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  TextButtonCustomer(
                    text: 'تسجيل الدخول',
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        var UCubit = context.read<UserCubit>();
                        var DCubit = context.read<DriverCubit>();
                        if (widget.usertype == Usertype.user.name) {
                          UCubit.signInUser(
                            emailController.text,
                            passwordController.text,
                          );
                        } else if (widget.usertype == Usertype.driver.name) {
                          DCubit.signInDriver(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      }
                    },
                  ),

                  const SizedBox(height: 32),

                  // سؤال إنشاء حساب
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigations.push(
                            context,
                            AppRouter.createuser,
                            extra: widget.usertype,
                          );
                        },
                        child: Text(
                          'إنشاء حساب',
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'ليس لدي حساب؟ ',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
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
