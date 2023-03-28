import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/base/controller/base_controller.dart';
import 'package:flutter_application_3/base/repository/base_request.dart';
import 'package:flutter_application_3/screen_test/test_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/theme/colors.dart';
import 'notifications.dart';

late FirebaseMessaging firebaseMessaging;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(BaseRequest(), permanent: true);
  Get.put(BaseGetxController(), permanent: true);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);

  await initFirebase();
  runApp(const MyApp());
}

Future<void> initFirebase() async {
  await Firebase.initializeApp();
  firebaseMessaging = FirebaseMessaging.instance;
  //Enabling foreground notifications
  await firebaseMessaging.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child ?? Container(),
        );
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(color: Colors.white),
        chipTheme: ChipThemeData(
          selectedColor: AppColors.backGroundColorButtonDefault,
          backgroundColor: Colors.white,
        ),
        
      ),
      home: const TestScreen(),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
