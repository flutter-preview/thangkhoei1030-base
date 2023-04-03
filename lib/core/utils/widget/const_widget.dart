import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/utils/widget/utils_button.dart';
import 'package:get/get.dart';

import '../../values/dimens.dart';

class WidgetConst {
  //SizedBox
  static const Widget sizedBox5 = SizedBox(height: 5);
  static const Widget sizedBox10 = SizedBox(height: 10);
  static const Widget sizedBoxWidth10 = SizedBox(width: 10);
  static const Widget sizedBoxWidth5 = SizedBox(width: 5);
  static const Widget sizedBoxPaddingHuge =
      SizedBox(height: AppDimens.paddingHuge);
  static const Widget sizedBoxPaddingSmall = SizedBox(height: 12);
  static const Widget sizedBoxPadding =
      SizedBox(height: AppDimens.defaultPadding);
  static const Widget sizedBox18 = SizedBox(height: 18);
  static const Widget sizedBoxWidth30 = SizedBox(width: 30);
  static const Widget sizedBoxWidthPadding = SizedBox(width: 20);
  static const Widget sizedBox40 = SizedBox(height: 40,);
  static const Widget sizedBox25 = SizedBox(height: 25,);
  //Loading
  static const Widget buildLoading = CupertinoActivityIndicator();

  //divider
  static Widget buildDivider({
    double height = 10.0,
    double thickness = 1.0,
    double indent = 0.0,
  }) {
    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: 1,
    );
  }

  static Widget sizedBox({double? height, double? width}) => SizedBox(
        height: height,
        width: width,
      );
  static Widget buildVerticalDivider() => const VerticalDivider(width: 1);
}
