import 'package:flutter/material.dart';
import 'package:ta9sela/core/constants/app_images.dart';
import 'package:ta9sela/core/routes/go_router.dart';
import 'package:ta9sela/core/routes/navigations.dart';
import 'package:ta9sela/core/utils/app_colors.dart';
import 'package:ta9sela/core/utils/textstyles.dart';
import 'package:ta9sela/feature/auth/data/UserType.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  final PageController _controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (val) {
          setState(() => currentPage = val);
        },
        children: [
          buildPage(
            image: AppImages.car1,
            title: "متشلش هم الموصلات تاني",
            subtitle: "خدماتي تقدر توصلك لأي وجهة في أي وقت وبأسهل طريقة",
            nextAction: () => _controller.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            ),
          ),

          buildPage(
            image: AppImages.car2,
            title: "عندك عربية؟ خليها تشتغل معاك",
            subtitle: "انضم كسائق واربح وزود دخلك كل يوم بسهولة وأمان",
            nextAction: () => _controller.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            ),
          ),

          buildPageLast(image: AppImages.car3, title: "سجّل الآن"),
        ],
      ),
    );
  }

  Widget buildPage({
    required String image,
    required String title,
    required String subtitle,
    required Function nextAction,
  }) {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset(image, fit: BoxFit.cover)),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 260,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            padding: EdgeInsets.all(20),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? Colors.green
                            : Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Text(title, textAlign: TextAlign.center, style: TextStyles.t24),

                SizedBox(height: 10),

                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyles.t16.copyWith(
                    color: AppColors.textdescription,
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: Size(120, 45),
                      ),
                      onPressed: () => nextAction(),
                      child: Text(
                        "التالي",
                        style: TextStyles.t16.copyWith(
                          color: AppColors.whitecolor,
                        ),
                      ),
                    ),

                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: Size(120, 45),
                      ),
                      onPressed: () => setState(() {
                        _controller.jumpToPage(2);
                      }),
                      child: Text(
                        "تخطي",
                        style: TextStyles.t16.copyWith(color: AppColors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPageLast({required String image, required String title}) {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset(image, fit: BoxFit.cover)),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 260,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            padding: EdgeInsets.all(20),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? Colors.green
                            : Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 25),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(200, 50),
                  ),
                  onPressed: () {
                    Navigations.push(context, AppRouter.page1,extra: Usertype.user.name.toString());
                  },
                  child: Text(
                    "مستخدم للخدمة",
                    style: TextStyles.t20.copyWith(
                      color: AppColors.whitecolor,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),

                SizedBox(height: 15),

                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(200, 50),
                  ),
                  onPressed: () {
                    Navigations.push(context, AppRouter.page1,extra: Usertype.driver.name.toString());
                  },
                  child: Text(
                    "سائق مع سيارة",
                    style: TextStyles.t20.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
