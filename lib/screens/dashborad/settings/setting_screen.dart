import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kisan_facility/cache/storage_shared_pref.dart';
import 'package:kisan_facility/components/dashboard_header.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/profile_header.dart';
import 'package:kisan_facility/core/constants/api_constant.dart';
import 'package:kisan_facility/screens/onboardiing/controller/onboarding_controller.dart';
import 'package:kisan_facility/screens/onboardiing/login_screen.dart';
import 'package:kisan_facility/service/network/network_client.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool forAndroid = true;
  final NetworkClient _networkClient = NetworkClient();

  @override
  Widget build(BuildContext context) {
    return Layout(
        showAsset: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DashboardHeader(
              centerText: 'Setting',
            ),
            SizedBox(
              height: 20.h,
            ),
            const ProfileHeader(),
            divider(),
            Row(
              children: [
                Text(
                  "Push Notification",
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
                ),
                const Spacer(),
                Switch(
                  activeColor: Colors.amber,
                  activeTrackColor: Colors.cyan,
                  inactiveThumbColor: Colors.blueGrey.shade600,
                  inactiveTrackColor: Colors.grey.shade400,
                  splashRadius: 50.0.r,
                  // boolean variable value
                  value: forAndroid,
                  // changes the state of the switch
                  onChanged: (value) => setState(() => forAndroid = value),
                ),
              ],
            ),
            divider(),
            InkWell(
              onTap: () {},
              child: Text(
                "Rate App",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
              ),
            ),
            divider(),
            Text(
              "Privacy Policy",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
            ),
            divider(),
            Text(
              "Refund Policy",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
            ),
            divider(),
            Consumer(
              builder: (context, ref, child) {
                return InkWell(
                  onTap: () {
                    ref
                        .read(onBoardingControllerProvider.notifier)
                        .userLogOut(context);
                    GoogleSignIn googleSignIn = GoogleSignIn();
                    googleSignIn.signOut();
                    StorageHelper.remove(StorageKeys.userData);
                    StorageHelper.remove(StorageKeys.token);
                    AppNavigation.removeAllScreen(context, AppLoginScreen());
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/logout.png",
                        height: 25.h,
                        width: 25.w,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      const Text("Logout")
                    ],
                  ),
                );
              },
            ),
            divider(),
          ],
        ));
  }

  Widget divider() => Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0.h),
        child: const Divider(
          color: Colors.black,
        ),
      );
}
