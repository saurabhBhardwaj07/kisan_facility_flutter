import 'package:flutter/material.dart';
import 'package:kisan_facility/utils/app_colors.dart';

class OptionHeadingWithViewAll extends StatelessWidget {
  final String heading;

  const OptionHeadingWithViewAll({
    super.key,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          heading,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        const Spacer(),
        const Text(
          "View All",
          style: TextStyle(
              decoration: TextDecoration.underline, color: AppColors.black),
        )
      ],
    );
  }
}
