import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroScreenOne extends StatelessWidget {
  const IntroScreenOne({super.key});

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
              child: Image.asset("assets/images/8104759.jpg")),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "As a farmer, one of the most important aspects of your business is having access to the right products at the right time. That's why we've created a farmer app that makes it easy to browse and purchase the agricultural products you need. Whether you're looking for seeds, fertilizers, or tools, our app has everything you need to grow healthy, profitable crops.",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const Spacer()
        ],
      ),
    );
  }
}
