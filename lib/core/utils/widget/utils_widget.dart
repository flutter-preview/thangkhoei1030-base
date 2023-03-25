import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/core/enums/enum_type_input.dart';
import 'package:flutter_application_3/core/enums/input_formatter_enum.dart';
import 'package:flutter_application_3/core/extension/validate.dart';
import 'package:flutter_application_3/core/utils/widget/const_widget.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/colors.dart';
import '../../values/dimens.dart';
import '../models/input_text_form_field_model.dart';
import 'dropdown_border.dart';
import 'input_text_form.dart';
import 'input_text_form_with_label.dart';

class UtilWidget {
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

  static Widget buildLogo(String imgLogo, double height) {
    return SizedBox(
      height: height,
      child: Image.asset(imgLogo),
    );
  }

  static Widget buildSmartRefresher({
    required RefreshController refreshController,
    required Widget child,
    ScrollController? scrollController,
    Function()? onRefresh,
    Function()? onLoadMore,
    bool enablePullUp = false,
    Widget? customLoadingFooter,
  }) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(Get.context!).copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      }),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: enablePullUp,
        scrollController: scrollController,
        header: const MaterialClassicHeader(),
        controller: refreshController,
        onRefresh: onRefresh,
        onLoading: onLoadMore,
        footer:
            buildSmartRefresherCustomFooter(loadingWidget: customLoadingFooter),
        child: child,
      ),
    );
  }

  static Widget buildSmartRefresherCustomFooter({Widget? loadingWidget}) {
    return CustomFooter(
      builder: (context, mode) {
        if (mode == LoadStatus.loading) {
          return loadingWidget ?? const CupertinoActivityIndicator();
        } else {
          return const Opacity(
            opacity: 0.0,
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }

  static PreferredSizeWidget buildAppBar(
    String title, {
    Color? textColor,
    Color? actionsIconColor,
    Color? backbuttonColor,
    Color? backgroundColor,
    Function()? func,
    List<Widget>? actions,
  }) {
    return AppBar(
      actionsIconTheme:
          IconThemeData(color: actionsIconColor ?? AppColors.textColorWhite),
      systemOverlayStyle: const SystemUiOverlayStyle(),
      title: UtilWidget.buildAppBarTitle(
        title,
        textColor: textColor ?? AppColors.textColorWhite,
      ),
      leading: BackButton(
        color: backbuttonColor ?? AppColors.textColorWhite,
        onPressed: func,
      ),
      actions: actions,
      backgroundColor: backgroundColor ?? AppColors.orange,
    );
  }

  static PreferredSizeWidget buildBaseBackgroundAppBar({
    required Widget title,
    List<Widget>? actions,
    Widget? leading,
    bool backButton = true,
  }) {
    Widget? leadingAppBar;
    if (backButton) {
      leadingAppBar =
          leading ?? const BackButton(color: AppColors.textColorWhite);
    }
    return AppBar(
      leading: leadingAppBar,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      title: title,
      automaticallyImplyLeading: backButton,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            //TODO: Box decoration
            // image: DecorationImage(
            //   image: AssetImage(ImageAsset.imgAppBarShort),
            //   fit: BoxFit.fitWidth,
            // ),
            ),
      ),
      centerTitle: true,
      actions: actions,
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

  static Widget buildText(
    String text, {
    FontWeight? fontWeight,
    TextAlign? textAlign,
    Color? textColor,
    int? maxline,
    double? foniSize,
  }) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: Get.textTheme.bodyText2!.copyWith(
        color: textColor ?? AppColors.textColor(),
        fontWeight: fontWeight,
        overflow: TextOverflow.ellipsis,
        fontSize: foniSize ?? AppDimens.fontSmall(),
      ),
      maxLines: maxline ?? 1,
    );
  }

  static Widget buildContainerWithBorder({
    required Widget child,
    double? width,
    double? height,
    double? radius,
    Color? color,
    Color? borderColor,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? Get.width,
        height: height ?? Get.height,
        decoration: BoxDecoration(
          color: color ?? AppColors.inputText(),
          border: Border.all(
            color: borderColor ?? Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              radius ?? AppDimens.paddingVerySmall,
            ),
          ),
        ),
        child: child,
      ),
    );
  }

  static Widget buildVerticalDivider() {
    return const VerticalDivider(
      width: 1,
    );
  }

  static Widget buildButtonWithIcon({
    Function()? function,
    required String title,
    required IconData icon,
    Color? buttonColor,
    Color? titleColor,
    Color? iconColor,
    bool visibilityBorder = false,
  }) {
    return GestureDetector(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor ?? AppColors.lightPrimaryColor,
          border: Border.all(
            color: visibilityBorder
                ? AppColors.lightPrimaryColor
                : AppColors.textColorWhite,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              AppDimens.paddingVerySmall,
            ),
          ),
        ),
        width: Get.width,
        height: AppDimens.btnMedium,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor ?? AppColors.textColorWhite,
            ).paddingSymmetric(
              horizontal: AppDimens.paddingVerySmall,
            ),
            Text(title,
                style: Get.textTheme.bodyText1!.copyWith(
                  color: titleColor ?? AppColors.textColorWhite,
                ))
          ],
        ),
      ).paddingAll(
        AppDimens.paddingVerySmall,
      ),
    );
  }

  static Widget baseBottomSheet({
    required String title,
    required Widget body,
    Widget? iconTitle,
    bool isSecondDisplay = false,
    bool isMiniSize = false,
    Function()? onPressed,
    Widget? actionArrowBack,
    double? padding,
    bool noAppBar = false,
    Color? backgroundColor,
    TextAlign? textAlign,
  }) {
    return SafeArea(
      bottom: false,
      minimum: EdgeInsets.only(
          top: Get.mediaQuery.padding.top + (isSecondDisplay ? 100 : 20)),
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.bottomSheet(),
            borderRadius: !GetPlatform.isAndroid
                ? const BorderRadius.vertical(top: Radius.circular(20))
                : null),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetConst.sizedBox5,
            noAppBar
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(title.tr,
                            textAlign: textAlign ?? TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.headline6!.copyWith(
                              color: AppColors.lightPrimaryColor,
                            )).paddingOnly(left: AppDimens.paddingHuge),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: actionArrowBack ??
                            const CloseButton(
                              color: AppColors.lightPrimaryColor,
                            ),
                      ),
                      iconTitle ?? const SizedBox(),
                    ],
                  ).paddingSymmetric(vertical: AppDimens.paddingSmall),
            isMiniSize ? body : Expanded(child: body),
          ],
        ).paddingSymmetric(horizontal: padding ?? AppDimens.defaultPadding),
      ),
    );
  }

  static Widget buildItemShowBottomSheet({
    required IconData icon,
    required String title,
    required Function function,
    required Color backgroundIcons,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundIcons,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
      ).marginOnly(left: 5),
      contentPadding: const EdgeInsets.all(8),
      title: Text(title.tr,
          style:
              Get.textTheme.subtitle1!.copyWith(color: AppColors.textColor())),
      onTap: () {
        Get.back();
        function();
      },
    );
  }

  static Widget buildDropdown<T>({
    required Map<T, String> mapData,
    required Rx<T> currentIndex,
    required Widget Function(String) itemWidget,
    double? height,
    double? width,
    Color? backGroundColors,
    double? borderRadius,
    double? heightItem,
    Color? backgroundColorItem,
    Color? backGroundColorDropDown,
  }) {
    return Container(
      alignment: Alignment.center,
      height: height ?? Get.height * AppDimens.resolutionWidgetDropdownHeight,
      width: width ?? Get.width * AppDimens.resolutionWidgetDropdown,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              borderRadius ?? AppDimens.radiusButtonDefault),
          color: backGroundColors ?? Colors.green),
      child: DropdownButtonCustom<T>(
        dropdownColor: backGroundColorDropDown,
        onChanged: (value) => {},
        items: mapData
            .map(
              (key, value) => MapEntry(
                key,
                DropdownMenuItemCustom<T>(
                  child: Container(
                    width: double.infinity,
                    height: heightItem,
                    color: backgroundColorItem,
                    child: itemWidget.call(value),
                  ),
                ),
              ),
            )
            .values
            .toList(),
        selectedItemBuilder: (context) => [
          Align(
            alignment: Alignment.center,
            child: AutoSizeText(
              mapData[currentIndex.value] ?? '',
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  // static Widget buildDropdown(
  //   Map<int, String> mapData, {
  //   required Rx<int?> item,
  //   double height = 50,
  //   Color fillColor = AppColors.darkPrimaryColor,
  //   Function(int?)? onChanged,
  // }) {
  //   return Obx(
  //     () => Container(
  //       decoration: BoxDecoration(
  //         color: fillColor,
  //         borderRadius: const BorderRadius.all(Radius.circular(10.0)),
  //       ),
  //       child: DropdownButtonHideUnderlineCustom(
  //         child: DropdownButtonCustom<int>(
  //           dropdownColor: fillColor,
  //           isExpanded: true,
  //           items:
  // mapData
  //               .map((key, value) {
  //                 return MapEntry(
  //                     key,
  //                     DropdownMenuItemCustom<int>(
  //                       value: key,
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Text(
  //                           mapData[key] ?? "",
  //                           style: Get.textTheme.subtitle1,
  //                         ),
  //                       ),
  //                     ));
  //               })
  //               .values
  //               .toList(),
  //           value: item.value,
  //           onChanged: onChanged,
  //         ),
  //       ).paddingOnly(left: AppDimens.paddingSmall),
  //     ).paddingOnly(
  //       bottom: AppDimens.paddingTitleAndTextForm,
  //     ),
  //   );
  // }

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

  static Widget buildCardBase(
    Widget child, {
    Color? colorBorder,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    bool getShadow = true,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.cardBackgroundColor(),
          borderRadius: borderRadius ??
              const BorderRadius.all(Radius.circular(AppDimens.radius8)),
          border: Border.all(
            color: colorBorder ?? Colors.white,
          ),
          boxShadow: getShadow
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    blurRadius: 3,
                  ),
                ]
              : [],
        ),
        child: child,
      );

  static List<TextSpan> textImportantStrings({
    required String source,
    required String textImportants,
  }) {
    int start = source.indexOf(textImportants);
    int end = start + textImportants.length;

    return [
      TextSpan(text: source.substring(0, start)),
      TextSpan(
        text: source.substring(start, end),
        style: Get.textTheme.bodyText1!.copyWith(color: AppColors.chipColor),
      ),
      TextSpan(text: source.substring(end)),
    ];
  }

  static buildAppBarTitle(String title,
      {bool? textAlignCenter, Color? textColor}) {
    textAlignCenter = textAlignCenter ?? GetPlatform.isAndroid;
    return AutoSizeText(
      title.tr,
      textAlign: textAlignCenter ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        color: textColor ?? AppColors.textColor(),
      ),
      maxLines: 2,
    );
  }

  static buildRadioButton({
    required String title,
    required bool isCheck,
    required var onTap,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: onTap,
      child: Row(
        children: [
          Icon(
            !isCheck ? Icons.radio_button_off : Icons.radio_button_checked,
            color: isCheck ? AppColors.orange : Colors.grey,
          ),
          buildText(
            title,
          ).paddingOnly(
            left: AppDimens.paddingVerySmall,
          )
        ],
      ).paddingSymmetric(
        horizontal: AppDimens.paddingSmall,
      ),
    );
  }

  static Widget buildListAndBtn({required Widget child, Widget? buildBtn}) {
    return Column(
      children: [
        Expanded(
          child: child,
        ),
        Visibility(visible: buildBtn != null, child: buildBtn ?? Container())
      ],
    );
  }

  static Widget buildTextInput({
    var height,
    Color? textColor,
    String? hintText,
    Color? hintColor,
    Color? fillColor,
    TextEditingController? controller,
    Function(String)? onChanged,
    Function()? onTap,
    Widget? prefixIcon,
    Widget? suffixIcon,
    FocusNode? focusNode,
    Color? borderColor,
    bool? autofocus,
    BorderRadius? borderRadius,
  }) {
    return SizedBox(
      height: height,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        focusNode: focusNode,
        autofocus: autofocus ?? true,
        style: Get.textTheme.bodyText1,
        decoration: InputDecoration(
            hoverColor: Colors.white,
            prefixIcon: prefixIcon,
            fillColor: fillColor,
            filled: true,
            suffixIcon: suffixIcon,
            hintText: hintText ?? "",
            hintStyle: TextStyle(
              color: hintColor ?? Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? Colors.grey),
              borderRadius:
                  borderRadius ?? const BorderRadius.all(Radius.circular(5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? Colors.grey),
              borderRadius:
                  borderRadius ?? const BorderRadius.all(Radius.circular(5)),
            ),
            contentPadding: const EdgeInsets.all(10)),
        onChanged: onChanged,
        onTap: onTap,
        controller: controller,
      ),
    );
  }
  //TODO: build search
  // static Widget buildSearch(
  //     {required TextEditingController textEditingController,
  //     String hintSearch = AppStr.hintSearch,
  //     required Function function,
  //     required RxBool isClear,
  //     Color? hintColor,
  //     Color? borderColor,
  //     bool? autofocus,
  //     Color? backgroundColor}) {
  //   return UtilWidget.buildTextInput(
  //     height: 40.0,
  //     controller: textEditingController,
  //     hintText: hintSearch,
  //     textColor: AppColors.textColor(),
  //     hintColor: hintColor ?? AppColors.hintTextColor(),
  //     borderColor: borderColor ?? AppColors.textColorWhite,
  //     autofocus: autofocus,
  //     fillColor: backgroundColor ?? AppColors.textColorWhite,
  //     borderRadius: const BorderRadius.all(Radius.circular(25)),
  //     onChanged: (v) {
  //       onTextChange(() {
  //         function();
  //         isClear.value = textEditingController.text.isNotEmpty;
  //       });
  //     },
  //     prefixIcon: const Icon(
  //       Icons.search,
  //       color: AppColors.lightPrimaryColor,
  //       size: 20,
  //     ),
  //     suffixIcon: Obx(() => Visibility(
  //           visible: isClear.value,
  //           child: IconButton(
  //             onPressed: () {
  //               textEditingController.clear();
  //               isClear.value = false;
  //               function();
  //             },
  //             icon: Icon(
  //               Icons.clear,
  //               color: AppColors.hintTextColor(),
  //             ),
  //           ).paddingOnly(bottom: AppDimens.paddingSmall),
  //         )),
  //   ).paddingSymmetric(vertical: AppDimens.paddingSmall);
  // }

  //TODO: Build Input
  static Widget buildInput(
    TextEditingController textEditingController, {
    String label = '',
    FocusNode? focusNode,
    FocusNode? nextNode,
    bool enable = true,
    TextInputType textInputType = TextInputType.multiline,
    Widget? icon,
    Function(String)? onChanged,
    Function()? onTap,
    Function(String)? onNext,
    Function(String)? submitFunc,
    bool isRequired = false,
    InputFormatter inputFormatters = InputFormatter.none,
    TextInputAction iconNextTextInputAction = TextInputAction.next,
    Color fillColor = Colors.white,
    Color textColor = Colors.black,
    String? hintText,
    int? minLengthInputForm,
    int? maxLengthInputForm,
    required TypeInput typeInput,
    bool showCounter = false,
    bool isReadOnly = false,
    IconData? iconLeading,
    double borderRadius = 20,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return SizedBox(
      width: Get.width * AppDimens.resolutionWidgetTextEditing,
      child: Column(
        children: [
          BuildInputTextWithLabel(
            label: label,
            labelRequired: isRequired ? " *" : "",
            padding: label.isEmpty ? 0 : AppDimens.paddingSmall,
            paddingText: label.isEmpty
                ? EdgeInsets.zero
                : const EdgeInsets.only(top: AppDimens.paddingSmall),
            buildInputText: BuildInputText(
              InputTextModel(
                  borderRadius: borderRadius,
                  enable: enable,
                  textColor: textColor,
                  errorTextColor: AppColors.colorRed444,
                  fillColor: fillColor,
                  controller: textEditingController,
                  currentNode: focusNode,
                  contentPadding: contentPadding,
                  nextNode: nextNode,
                  inputFormatter: inputFormatters,
                  suffixIcon: icon,
                  onChanged: onChanged,
                  maxLengthInputForm: maxLengthInputForm,
                  onTap: onTap,
                  hintText: hintText,
                  onNext: onNext,
                  iconLeading: iconLeading,
                  isReadOnly: isReadOnly,
                  isShowCounterText: showCounter,
                  submitFunc: submitFunc,
                  iconNextTextInputAction: iconNextTextInputAction,
                  textInputType: textInputType,
                  hintTextSize: AppDimens.textSizeInput,
                  textSize: AppDimens.textSizeInput,
                  obscureText: typeInput == TypeInput.password,
                  validator: (val) {
                    if (isRequired) {
                      if (val!.isStringEmpty) {
                        //return AppStr.productDetailNotEmpty.tr;
                        return "label + AppStr.errorEmpty";
                      }
                    }
                    return val.validator(typeInput,
                        minLength: minLengthInputForm);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildContainerBase(
    String title,
    String description,
    IconData? icon, {
    Color? color,
    Color? textColor,
    Function()? onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(top: 5),
          width: Get.width / 2.5,
          height: Get.width / 3.2,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 45,
                    color: textColor,
                  ).paddingOnly(left: AppDimens.paddingVerySmall),
                  Text(
                    title,
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    textAlign: TextAlign.start,
                  ).paddingOnly(left: AppDimens.paddingSmall),
                ],
              ),
              Text(
                description,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                ),
              ).paddingSymmetric(horizontal: 8),
            ],
          ),
        ),
      );

  static Widget buildProfileItem(
      {required String title,
      required Widget leading,
      Widget trailingWidget =
          const Icon(Icons.arrow_forward_ios_outlined, size: 15),
      Function()? onClick,
      RxInt? count}) {
    Widget listTitle = ListTile(
      title: Text(title, style: TextStyle(color: AppColors.textColor())),
      leading: leading,
      horizontalTitleGap: 0,
      trailing: trailingWidget,
      onTap: onClick,
    );
    return count != null ? Obx(() => listTitle) : listTitle;
  }

  static void setPointerAfterText(
    TextEditingController textEditingController,
  ) {
    textEditingController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: textEditingController.text.length,
      ),
    );
  }

  static Widget buildBaseBackgroundScaffold({required Widget child}) {
    return Container(
      decoration: const BoxDecoration(
          //TODO: background
          // image: DecorationImage(
          //   image: AssetImage(ImageAsset.imgLoginBg),
          //   fit: BoxFit.fitWidth,
          // ),
          ),
      child: child,
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
                image: AssetImage(imageUrl),
                fit: BoxFit.fill,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }

  static BorderRadius borderRadiusBottom({double radius = AppDimens.radius8}) {
    return BorderRadius.only(
      bottomLeft: Radius.circular(radius),
      bottomRight: Radius.circular(radius),
    );
  }

  static BorderRadius borderRadiusTop({double radius = AppDimens.radius8}) {
    return BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );
  }
}
