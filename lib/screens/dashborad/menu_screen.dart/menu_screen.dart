// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/profile_header.dart';

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
        id: 6, assetsPath: "assets/images/logout.png", text: "Logout"));
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
                    return Padding(
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
