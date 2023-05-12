import 'package:flutter/material.dart';
import 'package:kisan_facility/utils/text_style.dart';

class TopWidget extends StatelessWidget {
  final Widget leading;
  final String centerText;
  final Widget trailing;
  const TopWidget(
      {super.key,
      required this.centerText,
      required this.trailing,
      required this.leading});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        leading,
        const SizedBox(
          width: 5,
        ),
        Text(
          centerText,
          style: AppTextStyle.boldHeading(),
        ),
        const SizedBox(
          width: 5,
        ),
        const Spacer(),
        trailing
      ],
    );
  }
}
