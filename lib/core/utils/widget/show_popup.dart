import 'package:app_settings/app_settings.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/utils/widget/const_widget.dart';
import 'package:flutter_application_3/core/utils/widget/utils_button.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../theme/colors.dart';
import '../../values/dimens.dart';
import '../../values/strings.dart';
import 'utils_widget.dart';

class ShowPopup {
  static int _numDialog = 0;

  static Future<bool> onBackPress(bool isActiveBack) {
    return Future.value(isActiveBack);
  }

  static void dismissDialog() {
    if (_numDialog > 0) {
      Get.back();
    }
  }

  static void _showDialog(Widget dialog,
      {bool isActiveBack = true, bool barrierDismissible = false}) {
    _numDialog++;
    Get.dialog(
      WillPopScope(
        onWillPop: () => onBackPress(isActiveBack),
        child: dialog,
      ),
      barrierDismissible: barrierDismissible,
    ).whenComplete(() => _numDialog--);
  }

  /// Hiển thị loading
  ///
  /// `isActiveBack` có cho phép back từ bàn phím Android khi loading hay không, default = true
  void showLoadingWave({bool isActiveBack = true}) {
    _showDialog(getLoadingWidget(), isActiveBack: isActiveBack);
  }

  static Widget getLoadingWidget() {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }

  static Widget _baseButton(
    Function? function,
    String text, {
    Color? colorText,
  }) {
    return UtilButton.baseOnAction(
        onTap: () {
          dismissDialog();
          function?.call();
        },
        child: TextButton(
          onPressed: null,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: AppDimens.fontBig(),
              color: colorText ?? AppColors.textColor(),
            ),
            textScaleFactor: 1,
            maxLines: 1,
          ),
        ));
  }

  /// Hiển thị dialog thông báo với nội dung cần hiển thị
  ///
  /// `funtion` hành động khi bấm đóng
  ///
  /// `isActiveBack` có cho phép back từ bàn phím Android hay không, default = true
  ///
  /// `isChangeContext` default true: khi gọi func không close dialog hiện tại (khi chuyển sang màn mới thì dialog hiện tại sẽ tự đóng)
  static void showDialogNotification(
    String content, {
    bool isActiveBack = true,
    Function? function,
    String nameAction = AppStr.close,
  }) {
    _showDialog(
        Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: Icon(
                    _buildIconDialog(content),
                    size: AppDimens.sizeDialogNotiIcon,
                    color: Colors.blueAccent,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    child: Text(
                      content,
                      style: TextStyle(fontSize: AppDimens.fontMedium()),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      textScaleFactor: 1,
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                SizedBox(
                  width: double.infinity,
                  child: _baseButton(
                    function,
                    nameAction.tr,
                    colorText: AppColors.colorBlueAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
        isActiveBack: isActiveBack);
  }

  static void showErrorMessage(String error) {
    if (_numDialog < 1) {
      showDialogNotification(error, isActiveBack: false);
    }
  }

  static IconData _buildIconDialog(String errorStr) {
    IconData iconData;
    switch (errorStr) {
      case AppStr.errorConnectTimeOut:
        iconData = Icons.alarm_off;
        break;
      case AppStr.error400:
      case AppStr.error401:
      case AppStr.error404:
      case AppStr.error502:
      case AppStr.error503:
      case AppStr.errorInternalServer:
        iconData = Icons.warning;
        break;
      case AppStr.errorConnectFailedStr:
        iconData = Icons.signal_wifi_off;
        break;
      default:
        iconData = Icons.notifications_none;
    }
    return iconData;
  }

  static void showDialogConfirm(
    String content, {
    required Function confirm,
    required String actionTitle,
    bool isActiveBack = true,
    String title = AppStr.notification,
    String exitTitle = AppStr.cancel,
    Function? cancelFunc,
    bool isAutoCloseDialog = false,
  }) {
    _showDialog(
        Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: AutoSizeText(
                    title.tr,
                    textScaleFactor: 1,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: AppDimens.fontBiggest(),
                        color: AppColors.textColor()),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    child: Text(
                      content.tr,
                      style: Get.textTheme.bodyText1
                          ?.copyWith(color: AppColors.textColor()),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      textScaleFactor: 1,
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                SizedBox(
                  width: double.infinity,
                  height: AppDimens.btnMedium,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: _baseButton(cancelFunc, exitTitle.tr,
                            colorText: AppColors.hintTextColor()),
                      ),
                      VerticalDivider(
                        width: 1,
                        color: AppColors.dividerColor(),
                      ),
                      Expanded(
                        child: _baseButton(
                          confirm,
                          actionTitle.tr,
                          colorText: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        isActiveBack: isActiveBack);
  }

  static void openAppSetting() {
    showDialogConfirm(
      AppStr.permissionHelper,
      confirm: () {
        Get.back();
        AppSettings.openAppSettings();
      },
      actionTitle: AppStr.openSettings,
    );
  }

  static void showDialogCustom(
    Widget body, {
    required Function confirm,
    required String actionTitle,
    bool isActiveBack = true,
    String title = AppStr.notification,
    String exitTitle = AppStr.cancel,
    Function? cancelFunc,
    bool isAutoCloseDialog = false,
  }) {
    _showDialog(
        Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: AutoSizeText(
                    title.tr,
                    textScaleFactor: 1,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: AppDimens.fontBiggest(),
                        color: AppColors.textColor()),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    child: body,
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                SizedBox(
                  width: double.infinity,
                  height: AppDimens.btnMedium,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: _baseButton(cancelFunc, exitTitle.tr,
                            colorText: AppColors.hintTextColor()),
                      ),
                      VerticalDivider(
                        width: 1,
                        color: AppColors.dividerColor(),
                      ),
                      Expanded(
                        child: _baseButton(
                          confirm,
                          actionTitle.tr,
                          colorText: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        isActiveBack: isActiveBack);
  }

  // static void showDialogNoInternet() {
  //   _showDialog(
  //     Dialog(
  //       elevation: 0,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       child: SingleChildScrollView(child: NoInternet.buildDialogNoInternet()),
  //     ),
  //   );
  // }

  static void showDialogSupport(
    String content, {
    bool isActiveBack = true,
    Function? function,
    String nameAction = AppStr.close,
  }) {
    _showDialog(
        Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: AutoSizeText(content.tr,
                      textScaleFactor: 1,
                      maxLines: 1,
                      style: Get.textTheme.headline6),
                ),
                // UtilWidget.sizedBox10,
                // ItemUtils.itemLine(
                //   // iconColors: [AppColors.colorBlueB1FF,AppColors.colorBlueB1FF],
                //   title: AppStr.labelZalo,
                //   imgAsset: AppStr.iconZalo,
                //   func: () async {

                //         AppConst.zalo;
                //     if (await canLaunchUrlString(_zalo)) {
                //       await launchUrlString(_zalo);

                //     }
                //   },
                // ),
                // BaseWidget.sizedBox10,
                // ItemUtils.itemLine(
                //   // iconColors: [AppColors.colorBlueB1FF,AppColors.colorBlueB1FF],
                //   title: AppStr.loginFacebookSupport,
                //   imgAsset: AppStr.iconFacebook,
                //   func: () async {
                //     await launch(AppConst.facebook,
                //         forceSafariVC: true,
                //         forceWebView: false,
                //         enableJavaScript: true,
                //         statusBarBrightness: Brightness.light);
                //   },
                // ),
                WidgetConst.sizedBox10,
                // ItemUtils.itemLine(
                //   title: AppStr.phoneNumber,
                //   imgAsset: ImageAsset.icUser,
                //   func: () async {
                //     if (await canLaunchUrlString(AppStr.telSupportNumber)) {
                //       await launchUrlString(AppStr.telSupportNumber);
                //     }
                //   },
                // ),
                SizedBox(
                  width: double.infinity,
                  child: _baseButton(
                    function,
                    nameAction.tr,
                    colorText: AppColors.colorBlueAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
        isActiveBack: isActiveBack);
  }
}
