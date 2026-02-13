import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ta9sela/core/constants/app_images.dart';
import 'package:ta9sela/core/utils/app_colors.dart';
import 'package:ta9sela/feature/history/presentation/screen/histiryDriver.dart';
import 'package:ta9sela/feature/history/presentation/screen/history.dart';
import 'package:ta9sela/feature/home/presentation/widgets/driverHome.dart';

import 'package:ta9sela/feature/home/presentation/widgets/home_screen.dart';
import 'package:ta9sela/feature/profile/presentation/screens/profile.dart';

class MainLayout extends StatefulWidget {
  MainLayout({super.key, required this.usertype, required this.user});
  String? usertype;
  var user;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  final NotchBottomBarController _controller = NotchBottomBarController(
    index: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.whitecolor,

        /// 👇 الصفحات
        body: widget.usertype == 'user'
            ? IndexedStack(
                index: currentIndex,
                children: [
                  HomeScreen(user: widget.user, usertype: widget.usertype),
                   History(user: widget.user, usertype: widget.usertype),
                 // Histirydriver(user: widget.user, usertype: widget.usertype),

                  ProfileScreen(user: widget.user, usertype: widget.usertype),
                ],
              )
            : IndexedStack(
                index: currentIndex,
                children: [
                  DriverHome(user: widget.user, usertype: widget.usertype),
                  Histirydriver(user: widget.user, usertype: widget.usertype),

                  ProfileScreen(user: widget.user, usertype: widget.usertype),
                ],
              ),

        /// 👇 البوتوم بار
        bottomNavigationBar: AnimatedNotchBottomBar(
          notchBottomBarController: _controller,
          kBottomRadius: 24,
          kIconSize: 24,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          bottomBarItems: [
            BottomBarItem(
              inActiveItem: SvgPicture.asset(
                AppImages.home,
                color: AppColors.black,
              ),
              activeItem: SvgPicture.asset(
                AppImages.home,
                color: AppColors.primaryColor1,
              ),
            ),
            BottomBarItem(
              inActiveItem: SvgPicture.asset(
                AppImages.history,
                color: AppColors.black,
              ),
              activeItem: SvgPicture.asset(
                AppImages.history,
                color: AppColors.primaryColor1,
              ),
            ),
            
            BottomBarItem(
              inActiveItem: SvgPicture.asset(
                AppImages.person,
                color: AppColors.black,
              ),
              activeItem: SvgPicture.asset(
                AppImages.person,
                color: AppColors.primaryColor1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
