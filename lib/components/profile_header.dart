import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kisan_facility/screens/onboardiing/create_account.dart';
import 'package:kisan_facility/state_provider/logged_user_stateprovider.dart';
import 'package:kisan_facility/utils/app_colors.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedUser = ref.watch(userProvider);
    return Row(
      children: [
        // loggedUser?.user. != null
        //     ?
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(50),
        //   child: Image.network(loggedUser?.profilePic ?? ""),
        // ),
        // :
        Image.asset(
          "assets/images/user.png",
          height: 90.h,
          width: 90.w,
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              loggedUser?.user?.name == null ? "N/A" : loggedUser!.user!.name!,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(loggedUser?.user?.email == null
                ? "N/A"
                : loggedUser!.user!.email!),
            SizedBox(
              height: 5.h,
            ),
            Text(loggedUser?.user?.phone == null
                ? "N/A"
                : loggedUser!.user!.phone!),
            SizedBox(
              height: 5.h,
            ),
            InkWell(
              onTap: () => AppNavigation.goScreen(
                  context,
                  const CreateAccountScreen(
                    onBoarding: false,
                  )),
              child: Container(
                height: 20.h,
                width: 80.w,
                padding: EdgeInsets.only(left: 10.w),
                decoration: BoxDecoration(
                    color: AppColors.aqua,
                    borderRadius: BorderRadius.circular(20.h)),
                child: const Center(child: Text("Update Profile")),
              ),
            )
          ],
        ),
        const Spacer()
      ],
    );
  }
}
