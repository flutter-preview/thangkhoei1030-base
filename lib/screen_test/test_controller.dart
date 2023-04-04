import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/base/controller/base_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_3/main.dart';
import 'package:flutter_application_3/screen_test/test_screen.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:image_picker/image_picker.dart';

class TestController extends BaseGetxController
    with GetTickerProviderStateMixin {
  //Login
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController searchCtr = TextEditingController();
  TextEditingController adult = TextEditingController();
  TextEditingController kids = TextEditingController();
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
  // Rx<DateTime?> selectedDay = DateTime.now().obs;
  DateTime? focusedDay;
  DateTime? startDay;
  DateTime? endDay;
  DateTime? selectedDay = DateTime.now();
  bool isRangeDateSelect = false;
  RxInt indexSelect = 0.obs;
  RxInt currentPageScroll = 0.obs;

  int get numberOfNight {
    if (endDay != null) {
      return (startDay?.difference(endDay!).inDays ?? 0).abs() - 1;
    }
    return 0;
  }

  CarouselController carouselController = CarouselController();
  void onDaySelected(DateTime selected, DateTime focused) {
    if (!isSameDay(selectedDay, selected)) {
      focusedDay = focused;
      selectedDay = selected;
      startDay = null;
      endDay = null;
      isRangeDateSelect = false;
      update();
    }
  }

  void onRangeDaySelect(DateTime? start, DateTime? end, DateTime? focus) {
    focusedDay = focus;
    startDay = start;
    endDay = end;
    selectedDay = start;
    isRangeDateSelect = true;
    update();
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

  final List<types.Message> messages = [];
  final user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  final user2 = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3acbbbb');

  void addMessage(types.Message message) {
    messages.insert(0, message);
    searchCtr.clear();
    update();
  }

  void handleSendPressed(String messageText) {
    final textMessage = types.TextMessage(
      //message of user
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: messageText,
    );

    addMessage(textMessage);
  }

  void sendImage() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        //message of user
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: randomString(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      addMessage(message);
    }
  }

  void handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    messages[index] = updatedMessage;
    update();
  }
}
