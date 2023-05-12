import 'package:flutter/material.dart';
import 'package:kisan_facility/components/top_widget.dart';
import 'package:kisan_facility/screens/dashborad/menu_screen.dart/menu_screen.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';

class DashboardHeader extends StatelessWidget {
  final String centerText;

  const DashboardHeader({super.key, required this.centerText});

  @override
  Widget build(BuildContext context) {
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
          children: const [
            Icon(
              Icons.search,
              size: 30,
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.shopping_cart_outlined,
              size: 30,
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.favorite_outline_outlined,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}
