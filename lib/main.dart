import 'dart:async';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisan_facility/screens/spalsh_screen.dart';
import 'package:kisan_facility/service/notification/awesome_notification_service.dart';
import 'package:kisan_facility/utils/app_colors.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Message from push Notification ${message.data}");
}

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));

    //--------- fireBase Binding------
    await Firebase.initializeApp();

    // --- awesome notification ----------
    await AwesomeNotificationService.initializedNotification();

    //--- background messaging
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    // LocalNotificationService.initialize();
    runApp(const ProviderScope(child: MyApp()));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }, (error, stack) {
    print(error);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      splitScreenMode: false,
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Kisan Facility',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: const Color(0xFF6F35A5),
            dialogBackgroundColor: AppColors.accentColor,
            scaffoldBackgroundColor: Colors.white,
            textTheme: GoogleFonts.soraTextTheme(Theme.of(context).textTheme),
          ),
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
