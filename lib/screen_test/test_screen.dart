import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_3/core/enums/input_formatter_enum.dart';
import 'package:flutter_application_3/core/theme/colors.dart';
import 'package:flutter_application_3/core/utils/models/button_model.dart';
import 'package:flutter_application_3/core/utils/widget/base_widget/card_items.dart';
import 'package:flutter_application_3/core/utils/widget/const_widget.dart';
import 'package:flutter_application_3/core/utils/widget/utils_button.dart';
import 'package:flutter_application_3/core/utils/widget/utils_widget.dart';
import 'package:flutter_application_3/screen_test/test_controller.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../base/widget/base_widget.dart';
import '../core/theme/boxShadows.dart';
import '../core/utils/widget/base_widget/page.dart';
import '../core/values/dimens.dart';

part 'login.dart';
part 'category.dart';
part 'destination_detail.dart';
part 'hotels.dart';
part 'booking.dart';
part 'favourite.dart';
part 'messages.dart';

class TestScreen extends BaseGetWidget<TestController> {
  const TestScreen({super.key});
  @override
  TestController get controller => Get.put(TestController());
  @override
  Widget buildWidgets() {
    return GestureDetector(
        // behavior: HitTestBehavior.translucent,
        onTap: FocusManager.instance.primaryFocus?.unfocus,
        child: _buildMessagesPage(controller));
    // return _buildFavourite(controller);
    // return _buildHotelsPage(controller);
    // return _buildBooking(controller);
    // return _buildPageCategory(controller);
    // return _buildPageDestinationDetail(controller);
    // return _buildLogin(controller).paddingOnly(bottom: Get.mediaQuery.viewInsets.bottom);
    // return Scaffold(
    //   backgroundColor: Colors.yellow,
    //   appBar: AppBar(),
    //   body: Center(
    //     child: UtilWidget.buildDropdown<int>(
    //       mapData: {1: "1", 2: '2', 3: '3'},
    //       currentIndex: null.obs,
    //       defaultText: "platinmod",
    //       // backGroundColorDropDown: Colors.black,
    //       // backgroundColorItem: Colors.red,
    //       itemWidget: (value) => Text(value),
    //     ),
    //     // child: UtilWidget.buildInput(
    //     //   controller.textEditingController,
    //     //   typeInput: TypeInput.passwo1rd,
    //     //   hintText: 'label',
    //     //   minLengthInputForm: 12,
    //     // ),
    //   ),
    // );
  }
}
