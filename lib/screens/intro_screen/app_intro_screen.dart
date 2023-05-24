import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kisan_facility/cache/storage_shared_pref.dart';
import 'package:kisan_facility/components/custom_rounded_button.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/screens/intro_screen/intro_screen_one.dart';
import 'package:kisan_facility/screens/intro_screen/intro_screen_three.dart';
import 'package:kisan_facility/screens/intro_screen/intro_screen_two.dart';
import 'package:kisan_facility/screens/onboardiing/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppIntroScreen extends StatefulWidget {
  const AppIntroScreen({super.key});

  @override
  State<AppIntroScreen> createState() => _AppIntroScreenState();
}

class _AppIntroScreenState extends State<AppIntroScreen> {
  PageController pageController = PageController();

  int index = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      showAsset: false,
      child: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (i) {
              setState(() {
                index = i;
              });
            },
            children: const [
              IntroScreenOne(),
              IntroScreenTwo(),
              IntroScreenThree()
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: TextButton(
                onPressed: () {
                  StorageHelper.setBoolIn(StorageKeys.introShowed, true);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppLoginScreen()));
                },
                child: Text(
                  "Skip >",
                  style: TextStyle(color: Colors.black45, fontSize: 20.sp),
                )),
          ),
          Container(
              alignment: const Alignment(0, 0.85),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: CustomRoundedButton(
                        centerText: index == 2 ? "Go In" : "Next",
                        onPressed: () {
                          if (index == 2) {
                            StorageHelper.setBoolIn(
                                StorageKeys.introShowed, true);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AppLoginScreen()));
                          } else {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          }
                        }),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    effect: const ExpandingDotsEffect(
                        dotColor: Colors.black, activeDotColor: Colors.orange),
                    count: 3,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
