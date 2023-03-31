import 'package:flutter_application_3/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.max,
);
Future<void> initNofitication() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings("@mipmap/ic_launcher");

  InitializationSettings initializationSettings = const InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

Future<void> showNotification() async {
  flutterLocalNotificationsPlugin.show(
      0,
      "notification.title",
      "notification.body",
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // other properties...
        ),
      ));
}

// Future<void> tokenSetup() async {
//   Future<void> saveTokenToFirebase(String token) async {

//     await FirebaseFirestore.instance.collection('users').doc('userId').set({
//       'tokens': FieldValue.arrayUnion([token]),
//     });
//   }

//   String? token = await firebaseMessaging.getToken();
//   await saveTokenToFirebase(token!);
//   firebaseMessaging.onTokenRefresh.listen(saveTokenToFirebase);
// }