// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kisan_facility/cache/storage_shared_pref.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/profile_header.dart';
import 'package:kisan_facility/screens/dashborad/address/add_address_screen.dart';
import 'package:kisan_facility/screens/dashborad/address/address_screen.dart';
import 'package:kisan_facility/screens/dashborad/menu_screen.dart/contact_us.dart';
import 'package:kisan_facility/screens/onboardiing/login_screen.dart';
import 'package:kisan_facility/service/notification/awesome_notification_service.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<ProfileMenuOption> menuOption = [];

  void voidMenuOption() {
    menuOption.clear();
    menuOption.add(ProfileMenuOption(
        id: 0, assetsPath: "assets/images/home.png", text: "Home"));
    menuOption.add(ProfileMenuOption(
        id: 1,
        assetsPath: "assets/images/shopping-bag.png",
        text: "My Orders"));
    menuOption.add(ProfileMenuOption(
        id: 2, assetsPath: "assets/images/location.png", text: "My Addresses"));
    menuOption.add(ProfileMenuOption(
        id: 3,
        assetsPath: "assets/images/save-instagram.png",
        text: "Saved For Later"));
    menuOption.add(ProfileMenuOption(
        id: 4, assetsPath: "assets/images/contact.png", text: "Contact Us"));
    menuOption.add(ProfileMenuOption(
        id: 5, assetsPath: "assets/images/about.png", text: "About"));
    menuOption.add(ProfileMenuOption(
        id: 6, assetsPath: "assets/images/rating.png", text: "Rate App"));
    menuOption.add(ProfileMenuOption(
        id: 7, assetsPath: "assets/images/logout.png", text: "Logout"));
  }

  @override
  void initState() {
    voidMenuOption();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        showAsset: false,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close,
                  size: 35,
                ),
              ),
            ),
            const ProfileHeader(),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    var element = menuOption[index];
                    return InkWell(
                      onTap: () {
                        if (element.id == 7) {
                          GoogleSignIn googleSignIn = GoogleSignIn();
                          googleSignIn.signOut();
                          StorageHelper.remove(StorageKeys.userData);
                          StorageHelper.remove(StorageKeys.token);
                          AppNavigation.removeAllScreen(
                              context, AppLoginScreen());
                        }

                        if (element.id == 2) {
                          AppNavigation.goScreen(context, AddressScreen());
                        }

                        if (element.id == 4) {
                          AppNavigation.goScreen(context, ContactUsScreen());
                        }

                        if (element.id == 1) {
                          createAppNotification(
                            title: "Kisan Facility",
                            body:
                                "Your Enquiry has submitted, we will connect with you soon",
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Image.asset(
                              element.assetsPath,
                              height: 25,
                              width: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(element.text)
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, postion) {
                    return const Divider();
                  },
                  itemCount: menuOption.length),
            )
          ],
        ));
  }
}

class ProfileMenuOption {
  int id;
  String assetsPath;
  String text;
  ProfileMenuOption({
    required this.id,
    required this.assetsPath,
    required this.text,
  });
}
