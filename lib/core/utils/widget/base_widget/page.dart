import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../theme/colors.dart';
import '../../../values/dimens.dart';
import '../const_widget.dart';

class PageUtils {
  static Widget backButton() => IconButton(
      onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back));
  static buildAppBarTitle(String title,
      {bool? textAlignCenter, TextStyle? style}) {
    textAlignCenter = textAlignCenter ?? GetPlatform.isAndroid;
    return AutoSizeText(
      title.tr,
      textAlign: textAlignCenter ? TextAlign.center : TextAlign.left,
      style: style,
      maxLines: 2,
    );
  }

  static PreferredSizeWidget buildAppBar(
    String title, {
    TextStyle? textStyle,
    Color? actionsIconColor,
    Color? backbuttonColor,
    Color? backgroundColor,
    bool isLeading = true,
    double? paddingButtonAction,
    double height = kToolbarHeight,
    Function()? func,
    List<Widget>? actions,
  }) {
    return AppBar(
      toolbarHeight: height,
      actionsIconTheme:
          IconThemeData(color: actionsIconColor ?? AppColors.textColorWhite),
      systemOverlayStyle: const SystemUiOverlayStyle(),
      title: buildAppBarTitle(title, style: textStyle),
      leading: isLeading
          ? BackButton(
              color: backbuttonColor ?? AppColors.textColorWhite,
              onPressed: func,
            )
          : null,
      elevation: 0,
      actions: actions
          ?.map((e) => e.paddingSymmetric(
              horizontal: paddingButtonAction ?? AppDimens.paddingVerySmall))
          .toList(),
      backgroundColor: backgroundColor,
    );
  }

  static Widget buildPageStackAppBar({
    required Widget appBar,
    required Widget body,
    Widget? background,
    double? positionTop,
  }) {
    return Scaffold(
      body: Stack(
        children: [
          background ??
              Opacity(
                opacity: 0.2,
                child: Container(
                  color: Colors.black,
                ),
              ),
          Positioned(
              child: SizedBox(
                  width: Get.width,
                  child: body.paddingOnly(top: positionTop ?? kToolbarHeight))),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: appBar,
          ),
        ],
      ),    );
  }

  static Widget buildAppBarCustom(
      {double? height,
      Widget? leading,
      Alignment alignTitle = Alignment.center,
      Color? backGroundColors,
      Widget title = const SizedBox(),
      List<Widget> actions = const []}) {
    return Container(
      height: height ?? kToolbarHeight,
      width: Get.width,
      color: backGroundColors,
      child: Row(
        children: [
          SizedBox(height: double.infinity, child: leading),
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: Align(alignment: alignTitle, child: title),
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: Row(
              children: actions,
            ),
          )
        ],
      ),
    );
  }

  static Widget buildShimmerLoading() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.defaultPadding,
          vertical: AppDimens.defaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: ListView.separated(
                  itemBuilder: (context, index) => Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 24.0,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          WidgetConst.sizedBox10,
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 16.0,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 16.0,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          WidgetConst.sizedBox10,
                        ],
                      ),
                  separatorBuilder: (context, index) => const Divider(
                        height: 15,
                      ),
                  itemCount: 10),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildSafeArea(Widget childWidget,
      {double miniumBottom = 12, Color? color}) {
    return Container(
      color: color ?? AppColors.appBarColor(),
      child: SafeArea(
        bottom: true,
        maintainBottomViewPadding: true,
        minimum: EdgeInsets.only(bottom: miniumBottom),
        child: childWidget,
      ),
    );
  }

  static Widget buildPageImageBackground({
    required Widget child,
    required String imageUrl,
  }) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.fill,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }


}
