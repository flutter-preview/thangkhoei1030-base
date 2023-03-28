import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/utils/widget/utils_widget.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';
import '../../values/dimens.dart';
import '../../values/strings.dart';
import '../models/button_model.dart';
import 'show_popup.dart';

class UtilButton {
  static DateTime? _dateTime;
  static int _oldFunc = 0;
  static Widget baseBackButton({
    required String content,
    required Widget child,
    String? title,
    String? exitTitle,
    Function? notCheck,
    bool result = false,
    Function? function,
  }) {
    return WillPopScope(
      onWillPop: () {
        if (notCheck?.call() ?? false) {
          return Future.value(true);
        }
        !result
            ? ShowPopup.showDialogConfirm(
                content,
                confirm: () => Get.back(),
                actionTitle: AppStr.confirm.tr,
                title: title ?? AppStr.notification,
                exitTitle: exitTitle ?? AppStr.cancel.tr,
              )
            : function?.call();

        return Future.value(true);
      },
      child: child,
    );
  }

  static Widget buildButtonIcon({
    required IconData icons,
    required Function func,
    required Color colors,
    required String title,
    double sizeIcon = 20,
    double radius = 30,
    double padding = 8.0,
    Color? textColor,
    Color? iconColor = AppColors.hintTextSolidColor,
    String? imgAsset,
    Widget? child,
    TextStyle? style,
  }) =>
      baseOnAction(
        onTap: func,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(
                color: colors,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: child ??
                  (imgAsset != null
                      ? Image.asset(
                          imgAsset,
                          fit: BoxFit.cover,
                          height: sizeIcon,
                          width: sizeIcon,
                        )
                      : Icon(
                          icons,
                          color: iconColor,
                          size: sizeIcon,
                        )),
            ),
            if (title.isNotEmpty) ...[
              const SizedBox(height: 4),
              Expanded(
                child: AutoSizeText(
                  title.tr,
                  style: style ??
                      Get.theme.textTheme.subtitle2!.copyWith(
                        color: textColor ?? AppColors.textColor(),
                        fontSize: 12,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ]
          ],
        ),
      );

  /// Sử dụng để tránh trường hợp click liên tiếp khi thực hiện function
  static Widget baseOnAction({
    required Function onTap,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: () {
        DateTime now = DateTime.now();
        if (_dateTime == null ||
            now.difference(_dateTime ?? DateTime.now()) > 2.seconds ||
            onTap.hashCode != _oldFunc) {
          _dateTime = now;
          _oldFunc = onTap.hashCode;
          onTap();
        }
      },
      child: child,
    );
  }

  static Widget buildButton(ButtonModel buttonModel) {
    return Container(
      width: buttonModel.width ?? Get.width * AppDimens.resolutionWidgetButton,
      height: buttonModel.height ?? AppDimens.btnMedium,
      decoration: BoxDecoration(
        color: buttonModel.backGroundColors ??
            AppColors.backGroundColorButtonDefault,
        gradient: buttonModel.gradientColors,
        borderRadius: buttonModel.borderRadius ??
            BorderRadius.circular(AppDimens.paddingVerySmall),
      ),
      child: baseOnAction(
        onTap:
            !buttonModel.isLoading ? (buttonModel.funcHandle ?? () {}) : () {},
        child: Stack(
            children: [
              Align(
                alignment: buttonModel.alignment ?? Alignment.center,
                child: Text(
                  buttonModel.btnTitle.tr,
                  style: TextStyle(
                    fontSize: buttonModel.fontSize ?? AppDimens.fontMedium(),
                    color: buttonModel.textColor ?? Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            Align(
              alignment: Alignment.centerRight,
              child: Visibility(
                visible: buttonModel.isLoading && buttonModel.isShowLoading,
                child: const SizedBox(
                  height: AppDimens.btnSmall,
                  width: AppDimens.btnSmall,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.colorError,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget buildButtonWithIcon({
    Function()? function,
    String? title,
    required IconData icon,
    String? urlIcon,
    Color? buttonColor,
    Color? titleColor,
    Color? iconColor,
    bool visibilityBorder = false,
    double? sizeIcon,
    Color? colorBorder,
  }) {
    return UtilButton.baseOnAction(
      onTap: () => function?.call(),
      child: urlIcon != null
          ? UtilWidget.buildImageWidget(urlIcon)
          : Container(
              decoration: BoxDecoration(
                color: buttonColor,
                border: Border.all(
                  color: colorBorder ?? Colors.white,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    AppDimens.paddingVerySmall,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: iconColor,
                    size: sizeIcon,
                  ).paddingSymmetric(
                    horizontal: AppDimens.paddingVerySmall,
                  ),
                  if (title != null)
                    Text(title, style: Get.textTheme.bodyText1!)
                ],
              ),
            ).paddingAll(
              AppDimens.paddingVerySmall,
            ),
    );
  }

  static Widget buildTextButton({
    Function()? func,
    required String title,
    Color? colorText,
    bool isUnderLineText = false,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return baseOnAction(
      onTap: func ?? () {},
      child: Text(
        title,
        style: Get.textTheme.bodyText1!.copyWith(
            overflow: overflow,
            color: colorText,
            decoration: isUnderLineText ? TextDecoration.underline : null),
        maxLines: maxLines,
      ),
    );
  }
}
