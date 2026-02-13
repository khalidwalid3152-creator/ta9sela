import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ta9sela/core/constants/app_images.dart';
import 'package:ta9sela/core/routes/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // بعد 3 ثواني ينتقل للشاشة الثانية
    Future.delayed(Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      context.pushReplacement(AppRouter.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppImages.logo),
      ),
    );
  }
}
