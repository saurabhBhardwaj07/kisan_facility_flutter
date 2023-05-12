import 'package:flutter/material.dart';
import 'package:kisan_facility/components/dashboard_header.dart';
import 'package:kisan_facility/components/layout.dart';

class KisanCalendar extends StatelessWidget {
  const KisanCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
        showAsset: false,
        child: Column(
          children: const [
            DashboardHeader(
              centerText: 'Kisan Calendar',
            )
          ],
        ));
  }
}
