import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogoWidget extends StatelessWidget {
  final double height;
  const AppLogoWidget({super.key, this.height = 240});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(400),
      child: Image.asset(
        "assets/images/kishan_app_logo.png",
        height: height.h,
      ),
    );
  }
}
