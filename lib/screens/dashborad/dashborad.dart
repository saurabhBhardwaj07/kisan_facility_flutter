import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisan_facility/screens/dashborad/home/home_screen.dart';
import 'package:kisan_facility/screens/dashborad/message/message_screen.dart';
import 'package:kisan_facility/screens/dashborad/settings/setting_screen.dart';
import 'package:kisan_facility/screens/dashborad/shop/controller/cart_controlller.dart';
import 'package:kisan_facility/screens/dashborad/shop/shop_screen.dart';
import 'package:kisan_facility/service/notification/handle_show_notification.dart';
import 'package:kisan_facility/state_provider/user_location_provider.dart';
import 'package:kisan_facility/utils/app_colors.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  Widget child;
  int bottomNavIndex;

  DashBoardScreen(
      {super.key, this.child = const HomeScreen(), this.bottomNavIndex = -1});

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  List<IconData> iconList = [
    Icons.check,
    Icons.shopping_cart,
    Icons.message,
    Icons.settings
  ];

  @override
  void initState() {
    ShowNotification().listenFCM();
    Future.delayed(const Duration(milliseconds: 800)).then((value) =>
        ref.read(cartControllerProvider.notifier).getCartList(context));

    super.initState();
  }

  @override
  void didChangeDependencies() {
    ref.read(userLocationProvider.notifier).fetchUserLocation(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        child: widget.child,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.bottomNavIndex = -1;
            widget.child = const HomeScreen();
          });
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.home,
          color: widget.bottomNavIndex == -1
              ? AppColors.secondaryColor
              : Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: AppColors.mistyRose,
        inactiveColor: Colors.black,
        activeColor: AppColors.secondaryColor,
        icons: iconList,
        activeIndex: widget.bottomNavIndex,
        gapLocation: GapLocation.values.first,
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: (index) {
          widget.bottomNavIndex = index;
          switch (index) {
            case 1:
              widget.child = const ShoppingScreen();
              break;
            case 2:
              widget.child = const MessageScreen();
              break;
            case 3:
              widget.child = const SettingScreen();
              break;
          }
          setState(() {});
        },
        //other params
      ),
    );
  }
}
