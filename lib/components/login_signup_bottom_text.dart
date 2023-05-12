import 'package:flutter/material.dart';
import 'package:kisan_facility/utils/app_colors.dart';

class LoginSignupBottomText extends StatelessWidget {
  final bool login;
  final Function? press;
  const LoginSignupBottomText({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "New Member ? " : "Already have an Account ? ",
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: const TextStyle(
              color: AppColors.kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
