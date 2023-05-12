import 'package:flutter/material.dart';

class AppNavigation {
  static Future<dynamic> newScreen(BuildContext context, Widget child) {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => child));
  }

  static Future<dynamic> goScreen(BuildContext context, Widget child) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => child));
  }

  static Future<dynamic> removeAllScreen(BuildContext context, Widget child) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => child),
        (route) => route.isFirst);
  }
}
