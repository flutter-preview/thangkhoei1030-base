import 'package:flutter/material.dart';
import 'package:flutter_application_3/base/controller/base_controller.dart';
import 'package:flutter_application_3/base/repository/base_request.dart';
import 'package:flutter_application_3/test_screen.dart';
import 'package:get/get.dart';

void main() {
  Get.put(BaseRequest(), permanent: true);
  Get.put(BaseGetxController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TestScreen(),
    );
  }
}
