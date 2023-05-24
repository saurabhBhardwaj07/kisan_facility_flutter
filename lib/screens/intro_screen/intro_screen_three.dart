import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroScreenThree extends StatelessWidget {
  const IntroScreenThree({super.key});

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
            child: Image.asset("assets/images/8104816.jpg"),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "As a farmer, you may be eligible for a range of government schemes that can help you save money, increase your productivity, and grow your business. Our farmer app makes it easy to explore these schemes and find the ones that are right for you. From subsidies on fertilizers and pesticides to loans for buying new equipment, our app will help you make the most of the resources available to you.",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const Spacer()
        ],
      ),
    );
  }
}
