import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle boldHeading() => const TextStyle(
      fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black);
}

class AppText extends Text {
  final Color? color;
  final FontWeight? fontWeight;
  final double? height;
  final double fontSize;
  final double? letterSpacing;
  final int? maxLine;
  final TextDecoration? textDecoration;
  @override
  final TextAlign? textAlign;
  @override
  final TextDirection? textDirection;

  AppText.large(String data,
      {super.key,
      this.color = Colors.black,
      this.fontWeight = FontWeight.bold,
      this.height,
      this.fontSize = 24,
      this.letterSpacing,
      this.textAlign,
      this.maxLine,
      this.textDirection,
      this.textDecoration})
      : super(
          data,
          style: TextStyle(
              fontSize: fontSize,
              color: color,
              height: height,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              decoration: textDecoration),
          maxLines: maxLine,
          textAlign: textAlign,
          textDirection: textDirection,
        );

  AppText.medium(String data,
      {super.key,
      this.color = Colors.black,
      this.fontWeight = FontWeight.w500,
      this.height,
      this.fontSize = 18,
      this.maxLine,
      this.letterSpacing,
      this.textAlign,
      this.textDirection,
      this.textDecoration})
      : super(data,
            style: TextStyle(
                fontSize: fontSize,
                color: color,
                height: height,
                letterSpacing: letterSpacing,
                fontWeight: fontWeight,
                decoration: textDecoration),
            maxLines: maxLine,
            textDirection: textDirection);

  AppText.small(String data,
      {super.key,
      this.color = Colors.black,
      this.fontWeight = FontWeight.normal,
      this.height,
      this.fontSize = 12,
      this.letterSpacing,
      this.maxLine,
      this.textAlign,
      this.textDirection,
      this.textDecoration})
      : super(data,
            style: TextStyle(
                fontSize: fontSize,
                color: color,
                height: height,
                letterSpacing: letterSpacing,
                fontWeight: fontWeight,
                decoration: textDecoration),
            maxLines: maxLine,
            textDirection: textDirection);
}
