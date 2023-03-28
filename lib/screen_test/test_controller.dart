import 'package:flutter/cupertino.dart';
import 'package:flutter_application_3/base/controller/base_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_3/main.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
class TestController extends BaseGetxController {
  //Login
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  //Category
  List<String> categoryListString = [
    "Ha Noi",
    "TP.HCM",
    "Ha long",
    "Da Nang",
    "Lang son",
    "Ninh Binh",
    "Thai Nguyen"
  ];
  RxInt indexSelect = 0.obs;
  RxInt currentPageScroll = 0.obs;
  CarouselController carouselController  = CarouselController();
  @override
  void onInit() async {
    // showLoading();
    // final fcmToken = await firebaseMessaging.getToken();
    // print(fcmToken);
    // if (await requestPermission()) {
    //   // await tokenSetup();
    //   await initNofitication();

    //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //     RemoteNotification? notification = message.notification;
    //     AndroidNotification? android = notification?.android;

    //     // If `onMessage` is triggered with a notification, construct our own
    //     // local notification to show to users using the created channel.
    //     if (notification != null && android != null) {
    //       showNotification();
    //     }
    //   });
    //   // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   //   print('Got a message whilst in the foreground!');
    //   //   print('Message data: ${message.data}');
    //   //   if (message.notification != null) {
    //   //     print(
    //   //         'Message also contained a notification: ${message.notification}');
    //   //   }
    //   // });
    // }

    // hideLoading();
    super.onInit();
  }

  Future<bool> requestPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  // // It is assumed that all messages contain a data field with the key 'type'
  // Future<void> setupInteractedMessage() async {
  //   // Get any messages which caused the application to open from
  //   // a terminated state.
  //   RemoteMessage? initialMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();

  //   // If the message also contains a data property with a "type" of "chat",
  //   // navigate to a chat screen
  //   if (initialMessage != null) {
  //     _handleMessage(initialMessage);
  //   }

  //   // Also handle any interaction when the app is in the background via a
  //   // Stream listener
  //   FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  // }

  // void _handleMessage(RemoteMessage message) {
  //   if (message.data['type'] == 'chat') {
  //     Navigator.pushNamed(
  //       Get.context!,
  //       '/chat',
  //       arguments: ChatArguments(message),
  //     );
  //   }
  // }
}
