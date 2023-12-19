import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisan_facility/components/top_widget.dart';
import 'package:badges/badges.dart' as badges;
import 'package:kisan_facility/screens/dashborad/menu_screen.dart/menu_screen.dart';
import 'package:kisan_facility/screens/dashborad/shop/controller/cart_controlller.dart';
import 'package:kisan_facility/screens/dashborad/shop/cart/cart_screen.dart';
import 'package:kisan_facility/utils/app_colors.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';

class DashboardHeader extends ConsumerWidget {
  final String centerText;

  const DashboardHeader({super.key, required this.centerText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TopWidget(
        leading: InkWell(
          onTap: () => AppNavigation.goScreen(context, const MenuScreen()),
          child: const Icon(
            Icons.menu,
            size: 35,
          ),
        ),
        centerText: centerText,
        trailing: Row(
          children: [
            // Icon(
            //   Icons.search,
            //   size: 30,
            // ),
            const SizedBox(
              width: 5,
            ),
            InkWell(
                onTap: () =>
                    AppNavigation.goScreen(context, const CartScreen()),
                child: const AppCartIcon()),
            const SizedBox(
              width: 5,
            ),
            // const Icon(
            //   Icons.favorite_outline_outlined,
            //   size: 30,
            // )
          ],
        ),
      ),
    );
  }
}

class AppCartIcon extends StatelessWidget {
  const AppCartIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: Consumer(builder: (context, ref, child) {
        final cartCount = ref.watch(cartControllerProvider);
        return badges.Badge(
          badgeContent: Text(
            "$cartCount",
            style: const TextStyle(color: AppColors.accentColor),
          ),
          badgeStyle: const badges.BadgeStyle(
            elevation: 0,
            badgeColor: AppColors.kPrimaryColor,
          ),
          child: const Icon(
            Icons.shopping_cart_outlined,
            size: 30,
          ),
        );
      }),
    );
  }
}
