import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kisan_facility/components/app_logo_widget.dart';
import 'package:kisan_facility/components/custom_rounded_button.dart';
import 'package:kisan_facility/components/custom_textfrom_field.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/login_signup_bottom_text.dart';
import 'package:kisan_facility/screens/onboardiing/controller/onboarding_controller.dart';
import 'package:kisan_facility/screens/onboardiing/create_account.dart';
import 'package:kisan_facility/utils/app_colors.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';

class AppLoginScreen extends ConsumerWidget {
  AppLoginScreen({super.key});

  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void loginInApp(
    WidgetRef ref,
    BuildContext context,
  ) {
    ref
        .read(onBoardingControllerProvider.notifier)
        .userLogin(context, email: phoneCtrl.text, password: passwordCtrl.text);
  }

  void loginBySignUp(
    WidgetRef ref,
    BuildContext context,
  ) {
    ref.read(onBoardingControllerProvider.notifier).googleLogin(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final loading = ref.watch(apiLoadingProvider);
    final onBoarding = ref.watch(onBoardingControllerProvider);
    return Layout(
        child: ListView(
      children: [
        SizedBox(
          height: 20.h,
        ),
        const AppLogoWidget(),
        // Align(
        //   alignment: AlignmentDirectional.center,
        //   child: Text("WELCOME TO Kisan Facility",
        //       style: GoogleFonts.lobster(
        //         textStyle: TextStyle(
        //             fontWeight: FontWeight.w500,
        //             fontSize: 28.sp,
        //             color: Colors.black),
        //       )),
        // ),
        SizedBox(
          height: 20.h,
        ),
        const Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            "Login",
            style: TextStyle(fontSize: 20, color: AppColors.secondaryColor),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextronField(
                  inputController: phoneCtrl,
                  labelText: "email",
                  hintText: "@kisanFacility",
                  // prefix: const Text("+91 "),
                  keyboardType: TextInputType.emailAddress,
                  // inputFormatters: [MaskedInputFormatter('(000) 000-0000')],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextronField(
                  inputController: passwordCtrl,
                  hintText: "************",
                  labelText: 'Password',
                ),
              ],
            )),
        SizedBox(
          height: 20.h,
        ),
        Column(
          children: [
            CustomRoundedButton(
                centerText: "Login In",
                loading: onBoarding,
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  loginInApp(ref, context);
                }),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0.h),
              child: const Text(
                "Or",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
            InkWell(
              onTap: () async {
                loginBySignUp(ref, context);
                // ref.read(apiLoadingProvider.notifier).changeState(true);
                // await await googleSignUp(context).whenComplete(() async {
                //   LoggedUser user = await StorageHelper().getLoggedUser();
                //   ref.read(loggedUserState.notifier).updateUser(user);
                // });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login With",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    'assets/images/google.png',
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        LoginSignupBottomText(
            press: () =>
                AppNavigation.newScreen(context, const CreateAccountScreen()))
      ],
    ));
  }
}
