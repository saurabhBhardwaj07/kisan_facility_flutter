import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Layout extends StatelessWidget {
  final Widget child;
  final bool showAsset;
  final bool extendBody;
  const Layout(
      {Key? key,
      required this.child,
      this.topImage = "assets/images/main_top.png",
      this.bottomImage = "assets/images/login_bottom.png",
      this.showAsset = true,
      this.extendBody = false})
      : super(key: key);

  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double horizontalPadding = size.width * 0.05;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBody,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            showAsset == false
                ? const SizedBox()
                : Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      topImage,
                      width: 120,
                    ),
                  ),
            showAsset == false
                ? const SizedBox()
                : Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(bottomImage, width: 120),
                  ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: SafeArea(child: child)),
            ),
          ],
        ),
      ),
    );
  }
}
