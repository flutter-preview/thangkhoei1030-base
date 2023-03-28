

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';

import '../../../theme/colors.dart';

class TimeWidgetUtils {
  static Future<DateTime?> buildDateTimePicker({
    required DateTime dateTimeInit,
    DateTime? minTime,
    DateTime? maxTime,
  }) async {
    DateTime? newDateTime = await showRoundedDatePicker(
      context: Get.context!,
      height: 310,
      locale: const Locale('vi', 'VN'),
      initialDate: dateTimeInit,
      firstDate: minTime ?? DateTime.utc(DateTime.now().year - 10),
      lastDate: maxTime,
      // barrierDismissible: true,
      theme: ThemeData(
        primaryColor: AppColors.appBarColor(),
        dialogBackgroundColor: AppColors.dateTimeColor(),
        primarySwatch: Colors.deepOrange,
        disabledColor: AppColors.hintTextColor(),
        textTheme: TextTheme(
          caption: Get.textTheme.bodyText1!
              .copyWith(color: AppColors.hintTextColor()),
          bodyText2: Get.textTheme.bodyText1,
        ),
      ),
      styleDatePicker: MaterialRoundedDatePickerStyle(
        paddingMonthHeader: const EdgeInsets.all(15),
        textStyleMonthYearHeader: Get.textTheme.bodyText1,
        colorArrowNext: AppColors.hintTextColor(),
        colorArrowPrevious: AppColors.hintTextColor(),
        textStyleButtonNegative:
            Get.textTheme.bodyText1!.copyWith(color: AppColors.hintTextColor()),
        textStyleButtonPositive:
            Get.textTheme.bodyText1!.copyWith(color: AppColors.linkText()),
      ),
    );
    return newDateTime;
  }

  static Future<DateTime?> showDateTimePicker() async {
    DateTime? newDateTime = await DatePicker.showDateTimePicker(
      Get.context!,
      locale: LocaleType.vi,
      minTime: DateTime.now(),
    );
    return newDateTime;
  }
}
