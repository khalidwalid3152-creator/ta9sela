import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ta9sela/core/constants/app_images.dart';
import 'package:ta9sela/core/routes/go_router.dart';
import 'package:ta9sela/core/routes/navigations.dart';
import 'package:ta9sela/core/utils/app_colors.dart';
import 'package:ta9sela/core/utils/textstyles.dart';
import 'package:ta9sela/feature/auth/presentation/widgets/authButton.dart';

class LoginOptionsScreen extends StatelessWidget {
  const LoginOptionsScreen({super.key, required this.usertype});
  final String usertype;

  @override
  Widget build(BuildContext context) {
    print(" ${usertype}");
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                'سجّل باستخدام',
                style: TextStyles.t28.copyWith(color: AppColors.black),
              ),

              const SizedBox(height: 25),

              // Email Button
              AuthButton(
                text: 'الإيميل',
                color: AppColors.primaryColor1,
                leading: SvgPicture.asset(AppImages.email, width: 35),
                onTap: () {
                  Navigations.push(context, AppRouter.page2, extra: usertype);
                },
              ),

              const SizedBox(height: 20),

              Text(
                'أو',
                style: TextStyles.t20.copyWith(color: AppColors.black),
              ),

              const SizedBox(height: 20),

              // Google Button
              AuthButton(
                text: 'جوجل',
                color: AppColors.primaryColor,
                leading: SvgPicture.asset(AppImages.google, width: 35),
                onTap: () {},
              ),

              const SizedBox(height: 12),

              // Apple Button
              AuthButton(
                text: 'أبل',
                color: AppColors.primaryColor,
                leading: SvgPicture.asset(AppImages.apple, width: 35),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
