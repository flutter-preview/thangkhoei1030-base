import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/utils/widget/utils_widget.dart';
import 'package:flutter_application_3/test_controller.dart';
import 'package:get/get.dart';
import 'base/widget/base_widget.dart';

class TestScreen extends BaseGetWidget<TestController> {
  const TestScreen({super.key});
  @override
  TestController get controller => Get.put(TestController());
  @override
  Widget buildWidgets() {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(),
      body: Center(
        child: UtilWidget.buildDropdown<int>(
          mapData: {1: "1", 2: '2', 3: '3'},
          currentIndex: 1.obs,
          // backGroundColorDropDown: Colors.black,
          // backgroundColorItem: Colors.red,
          itemWidget: (value) => Text(value),
        ),
        // child: UtilWidget.buildInput(
        //   controller.textEditingController,
        //   typeInput: TypeInput.passwo1rd,
        //   hintText: 'label',
        //   minLengthInputForm: 12,
        // ),
      ),
    );
  }
}
