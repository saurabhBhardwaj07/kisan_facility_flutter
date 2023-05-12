import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kisan_facility/cache/storage_shared_pref.dart';
import 'package:kisan_facility/components/custom_rounded_button.dart';
import 'package:kisan_facility/components/dashboard_header.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/profile_header.dart';
import 'package:kisan_facility/screens/onboardiing/login_screen.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool forAndroid = true;

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
            const SizedBox(
              height: 20,
            ),
            const ProfileHeader(),
            divider(),
            Row(
              children: [
                const Text(
                  "Push Notification",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
                const Spacer(),
                Switch(
                  activeColor: Colors.amber,
                  activeTrackColor: Colors.cyan,
                  inactiveThumbColor: Colors.blueGrey.shade600,
                  inactiveTrackColor: Colors.grey.shade400,
                  splashRadius: 50.0,
                  // boolean variable value
                  value: forAndroid,
                  // changes the state of the switch
                  onChanged: (value) => setState(() => forAndroid = value),
                ),
              ],
            ),
            divider(),
            const Text(
              "Rate App",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            divider(),
            const Text(
              "Privacy Policy",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            divider(),
            const Text(
              "Refund Policy",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            divider(),
            InkWell(
              onTap: () {
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
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Logout")
                ],
              ),
            ),
            divider(),
          ],
        ));
  }

  Widget divider() => const Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Divider(
          color: Colors.black,
        ),
      );
}
