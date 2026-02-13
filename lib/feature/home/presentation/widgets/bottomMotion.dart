// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:ta9sela/core/constants/app_images.dart';
// import 'package:ta9sela/core/utils/app_colors.dart';

// class bottombar extends StatefulWidget {
//   const bottombar({
//     super.key,
//   });

//   @override
//   State<bottombar> createState() => _bottombarState();
// }
//  int currentIndex = 0;
// class _bottombarState extends State<bottombar> {
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedNotchBottomBar(
//       kBottomRadius: 24,
//       kIconSize: 24,
//       onTap: (index) {
//   setState(() {
//     currentIndex = index;
//   });
// },
//       notchBottomBarController: NotchBottomBarController(),
//       bottomBarItems: [
       
//         ///svg item
//         BottomBarItem(
         
//           inActiveItem: SvgPicture.asset(
//             AppImages.home,
//             color: AppColors.black,
//           ),
//           activeItem: SvgPicture.asset(
//             AppImages.home,
//             color: AppColors.primaryColor1,
//           ),
         
//         ),
//         BottomBarItem(
         
//           inActiveItem: SvgPicture.asset(
//             AppImages.history,
//             color: AppColors.black,
//           ),
//           activeItem: SvgPicture.asset(
//             AppImages.history,
//             color: AppColors.primaryColor1,
//           ),
          
//         ),
//         BottomBarItem(
         
//           inActiveItem: SvgPicture.asset(
//             AppImages.message,
//             color: AppColors.black,
//           ),
//           activeItem: SvgPicture.asset(
//             AppImages.message,
//             color: AppColors.primaryColor1,
//           ),
         
//         ),
//         BottomBarItem(
          
//           inActiveItem: SvgPicture.asset(
//             AppImages.person,
//             color: AppColors.black,
//           ),
//           activeItem: SvgPicture.asset(
//             AppImages.person,
//             color: AppColors.primaryColor1,
//           ),
         
//         ),
//       ],
//     );
//   }
// }
