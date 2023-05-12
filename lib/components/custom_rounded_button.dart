import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kisan_facility/utils/app_colors.dart';
import 'package:kisan_facility/utils/indicator/rotating_circle_indicator.dart';

class CustomRoundedButton extends StatelessWidget {
  final String centerText;
  final Color? bgColor;
  final void Function()? onPressed;
  final bool loading;

  const CustomRoundedButton(
      {super.key,
      required this.centerText,
      required this.onPressed,
      this.loading = false,
      this.bgColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        maximumSize: Size(double.infinity, 50.h),
        minimumSize: Size(double.infinity, 50.h),
      ),
      onPressed: loading ? null : onPressed,
      child: loading
          ? const RotatingCircleIndicator(
              color: AppColors.whiteSmoke,
            )
          : Text(
              centerText,
            ),
    );
  }
}
