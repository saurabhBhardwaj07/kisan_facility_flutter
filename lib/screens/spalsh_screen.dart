// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisan_facility/cache/storage_shared_pref.dart';
import 'package:kisan_facility/components/app_logo_widget.dart';
import 'package:kisan_facility/screens/dashborad/dashborad.dart';
import 'package:kisan_facility/screens/intro_screen/app_intro_screen.dart';
import 'package:kisan_facility/screens/onboardiing/login_screen.dart';
import 'package:kisan_facility/state_provider/logged_user_stateprovider.dart';
import 'package:kisan_facility/utils/clipper/wave_clipper.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';
import 'package:kisan_facility/model/user_model.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  int count = 5;

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      navigateToNextScreen();
    });
    super.initState();
  }

  void navigateToNextScreen() async {
    if (await StorageHelper.getBoolIn(StorageKeys.introShowed)) {
      try {
        UserModel? user = await StorageHelper().getLoggedUser();
        ref.read(userProvider.notifier).update((state) => user);
        if (user?.user?.email != null) {
          AppNavigation.newScreen(context, DashBoardScreen());
        } else {
          AppNavigation.newScreen(context, AppLoginScreen());
        }
      } catch (err) {
        AppNavigation.newScreen(context, AppLoginScreen());
      }
    } else {
      AppNavigation.newScreen(context, const AppIntroScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF1E6FF),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
              statusBarColor: Color(0xFF6F35A5),
              statusBarIconBrightness: Brightness.dark),
          child: SafeArea(
            child: Column(
              children: [
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                      height: 160,
                      width: double.infinity,
                      color: const Color(0xFF6F35A5)),
                ),
                const Spacer(),
                const AppLogoWidget(),
                const Spacer(),
                Text("Kisan Facility",
                    style: GoogleFonts.lobster(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 45.sp,
                          color: Colors.black),
                    )),
                Padding(
                  padding: EdgeInsets.only(right: 40.0.w),
                  child: Row(
                      children: Iterable<int>.generate(4).toList().map((e) {
                    return Lottie.asset("assets/lottie/splash_wheat.json",
                        fit: BoxFit.cover, width: 80.w, height: 160.h);
                  }).toList()),
                ),
              ],
            ),
          ),
        ));
  }
}
