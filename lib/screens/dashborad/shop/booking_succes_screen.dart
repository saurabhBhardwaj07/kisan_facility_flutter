import 'package:flutter/material.dart';
import 'package:kisan_facility/components/custom_rounded_button.dart';
import 'package:kisan_facility/components/layout.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      showAsset: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/success.gif"),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Congratulation!",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Your Order Succesfully Placed",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomRoundedButton(
              centerText: "Go Back In Dashboard",
              onPressed: () => Navigator.pop(context))
        ],
      ),
    );
  }
}
