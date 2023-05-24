import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroScreenTwo extends StatelessWidget {
  const IntroScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/images/8104781.jpg")),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Keeping up with the latest news and weather is crucial for any farmer who wants to make informed decisions about their crops. With our farmer app, you'll have access to the latest news and weather updates from trusted sources, right at your fingertips. Stay up to date on weather patterns, crop prices, and other important news that can affect your bottom line.",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const Spacer()
        ],
      ),
    );
  }
}
