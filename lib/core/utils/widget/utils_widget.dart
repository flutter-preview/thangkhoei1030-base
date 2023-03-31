import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/base/controller/base_controller.dart';
import 'package:flutter_application_3/core/enums/enum_type_input.dart';
import 'package:flutter_application_3/core/enums/input_formatter_enum.dart';
import 'package:flutter_application_3/core/extension/validate.dart';
import 'package:flutter_application_3/core/utils/widget/const_widget.dart';
import 'package:flutter_application_3/core/utils/widget/utils_button.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../theme/colors.dart';
import '../../values/dimens.dart';
import '../models/input_text_form_field_model.dart';
import 'base_widget/card_items.dart';
import 'dropdown_border.dart';
import 'base_widget/input_text_form.dart';

class UtilWidget {
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

  static Widget buildSlideTransition<T extends BaseGetxController>({
    required Widget Function(int, T) child,
    required int itemsCount,
    required Rx<int> currentIndexPosition,
    CarouselController? carouselController,
    bool enableInfiniteScroll = true,
    bool enlargeCenterPage = true,
    bool disableCenter = true,
    double enlargeFactor = 0.5,
    bool autoPlay = true,
    double viewportFraction = 0.9,
    double aspectRatio = 4 / 3,
    Function(int, CarouselPageChangedReason)? onPageChanged,
    Function(double)? onTapIndicator,
    bool isUsingDotIndicator = true,
    double? heightScroll,
  }) {
    return GetBuilder<T>(
      builder: (controller) => Column(
        children: [
          CarouselSlider.builder(
            carouselController: carouselController,
            disableGesture: true,
            itemCount: itemsCount,
            itemBuilder: (context, index, realIndex) {
              return child.call(index, controller);
            },
            options: CarouselOptions(
              height: heightScroll,
              enableInfiniteScroll: enableInfiniteScroll,
              enlargeCenterPage: enlargeCenterPage,
              disableCenter: disableCenter,
              enlargeFactor: enlargeFactor,
              autoPlay: autoPlay,
              viewportFraction: viewportFraction,
              aspectRatio: aspectRatio,
              onPageChanged: onPageChanged,
              pauseAutoPlayInFiniteScroll: true,
            ),
          ),
          if (isUsingDotIndicator)
            DotsIndicator(
              onTap: (position) {
                currentIndexPosition.value = position.toInt();
                carouselController?.jumpToPage(currentIndexPosition.value);
                controller.update();
              },
              dotsCount: itemsCount,
              position: currentIndexPosition.value.toDouble(),
              decorator: DotsDecorator(
                activeColor: AppColors.backGroundColorButtonDefault,
              ),
            ),
        ],
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

  static Widget buildDropdown<T>({
    required Map<T, String> mapData,
    required Rx<T?> currentIndex,
    required Widget Function(String) itemWidget,
    required String defaultText,
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
              mapData[currentIndex.value] ?? defaultText,
              overflow: TextOverflow.ellipsis,
            ).paddingOnly(left: AppDimens.paddingVerySmall),
          )
        ],
      ),
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
    TypeInput typeInput = TypeInput.none,
    bool showCounter = false,
    bool isReadOnly = false,
    IconData? iconLeading,
    double borderRadius = 20,
    EdgeInsetsGeometry? contentPadding,
    TextAlign? alignText,
    bool isUseSuffixIcon = true,

  }) {
    return SizedBox(
        width: Get.width,
        child: BuildInputText(
          InputTextModel(
            textAlign: alignText,
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
              isUseSuffixIcon: isUseSuffixIcon,
              validator: (val) {
                if (isRequired) {
                  if (val!.isStringEmpty) {
                    //return AppStr.productDetailNotEmpty.tr;
                    return "label + AppStr.errorEmpty";
                  }
                }
                return val.validator(typeInput, minLength: minLengthInputForm);
              }),
        ));
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

  static Widget buildScrollList({
    required int itemsCount,
    required Widget Function(int) itemWidget,
    required Axis scrollDirection,
    Widget? separatorWidget,
    double? height,
    bool isScroll = true,
  }) {
    return SizedBox(
      height: scrollDirection == Axis.horizontal ? height : null,
      child: ListView.separated(
        physics: !isScroll ? const NeverScrollableScrollPhysics() : null,
        shrinkWrap: true,
        scrollDirection: scrollDirection,
        itemCount: itemsCount,
        itemBuilder: ((context, index) {
          return itemWidget.call(index);
        }),
        separatorBuilder: (BuildContext context, int index) {
          return separatorWidget ?? const SizedBox();
        },
      ),
    );
  }

  static Widget buildLiStScrollWithTitle<T>({
    Function()? action,
    Widget? actionWidget,
    required Widget leading,
    required int itemsCount,
    required Widget Function(int) itemsWidget,
    required Axis scrollDirection,
    double? height,
    bool isScroll = false,
    Widget? separatorWidget,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading,
            if (actionWidget != null)
              UtilButton.baseOnAction(
                  onTap: action ?? () {}, child: actionWidget)
          ],
        ),
        WidgetConst.sizedBoxPadding,
        buildScrollList(
          itemsCount: itemsCount,
          itemWidget: itemsWidget,
          scrollDirection: scrollDirection,
          height: height,
          isScroll: isScroll,
          separatorWidget: separatorWidget,
        )
      ],
    );
  }

  static Widget buildBodyPadding(Widget body,
      {double paddingHorizontal = 0, double paddingVertical = 0}) {
    return body.paddingSymmetric(
        horizontal: paddingHorizontal, vertical: paddingVertical);
  }

  static Widget itemLine({
    Function()? func,
    double? heightLeading,
    IconData? iconLeading,
    bool isShowLeading = true,
    String? title,
    TextStyle? titleStyle,
    String? subtitle,
    TextStyle? subStyle,
    Function()? onTap,
    Widget? trailing,
    String? urlImages,
    double? heightImagesLeading,
    double? widthImageLeading,
  }) {
    return UtilButton.baseOnAction(
        onTap: func ?? () {},
        child: ListTile(
          leading: isShowLeading
              ? buildIconInItemLine(
                  iconLeading: iconLeading,
                  urlImages: urlImages,
                  heightImage: heightImagesLeading,
                  widthImage: widthImageLeading,
                )
              : null,
          title: title != null
              ? Text(
                  title,
                  style: titleStyle,
                )
              : null,
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  style: subStyle,
                )
              : null,
          trailing: FittedBox(child: trailing),
          onTap: onTap ?? () {},
        ));
  }

  static Widget buildIconInItemLine({
    double? heightImage,
    double? widthImage,
    String? urlImages,
    IconData? iconLeading,
    Color? colorIcon,
  }) {
    return urlImages != null
        ? CardUtils.buildCardCustomRadiusBorder(
            radiusAll: 10,
            child: Container(
              height: heightImage ?? 50,
              width: widthImage ?? 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(urlImages), fit: BoxFit.cover),
              ),
            ),
          )
        : Icon(
            iconLeading,
            color: colorIcon,
          );
  }

  // static Widget buildRating(double rating, {Function()? func}) =>
  //     UtilButton.baseOnAction(
  //       onTap: func ?? () {},
  //       child: Row(
  //         children: [
  //           Text(
  //             rating.toString(),
  //             style: Get.textTheme.bodyText1,
  //           ),
  //           Icon(
  //             Icons.star,
  //             size: AppDimens.sizeIconSmall,
  //             color: AppColors.backGroundColorButtonDefault,
  //           )
  //         ],
  //       ),
  //     );

  static Widget buildItemLine({
    required Widget child,
    Function()? func,
    String? urlLeading,
    String? urlTrailing,
    Widget? leading,
    double? heightImage,
    double? widthImage,
    double? borderRadiusImage,
    double? spacing,
    Widget? trailing,
    bool isFromAsset = false,
    bool isFromLocalFile = false,
    bool isFromNetwork = true,
  }) {
    return UtilButton.baseOnAction(
        onTap: func ?? () {},
        child: Row(
          children: [
            urlLeading != null
                ? buildImageWidget(
                    urlLeading,
                    heightImage: heightImage,
                    widthImage: widthImage,
                    raidus: borderRadiusImage,
                    isFromAsset: isFromAsset,
                    isFromLocalFile: isFromLocalFile,
                    isFromNetwork: isFromNetwork,
                  )
                : leading ?? const SizedBox(),
            WidgetConst.sizedBox(width: spacing),
            Expanded(child: child),
            WidgetConst.sizedBox(width: spacing),
            urlTrailing != null
                ? buildImageWidget(
                    urlTrailing,
                    heightImage: heightImage,
                    widthImage: widthImage,
                    raidus: borderRadiusImage,
                    isFromAsset: isFromAsset,
                    isFromLocalFile: isFromLocalFile,
                    isFromNetwork: isFromNetwork,
                  )
                : trailing ?? const SizedBox(),
          ],
        ));
  }

  ///Default images from network
  static Widget buildImageWidget(
    String urlImages, {
    bool isFromNetwork = true,
    bool isFromAsset = false,
    bool isFromLocalFile = false,
    double? heightImage,
    double? widthImage,
    double? raidus,
  }) {
    return CardUtils.buildCardCustomRadiusBorder(
      radiusAll: 20,
      child: Container(
        height: heightImage ?? 50,
        width: widthImage ?? 50,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: (isFromNetwork
                  ? NetworkImage(urlImages)
                  : isFromAsset
                      ? AssetImage(urlImages)
                      : isFromLocalFile
                          ? FileImage(File(urlImages))
                          : null) as ImageProvider),
        ),
      ),
    );
  }

  static Widget buildAction({
    required String text,
    TextStyle? textStyle,
    IconData? iconData,
    double? iconSize,
    Color colorIcon = Colors.white,
    Function()? func,
    String? urlImage,
    bool isFromAsset = false,
    bool isFromLocalFile = false,
    bool isFromNetwork = true,
    double? spaceAround,
  }) {
    return UtilButton.baseOnAction(
      onTap: func ?? () {},
      child: Row(
        children: [
          AutoSizeText(
            text,
            style: textStyle ?? Get.textTheme.bodyText1!,
          ),
          WidgetConst.sizedBox(width: spaceAround),
          urlImage != null
              ? buildImageWidget(
                  urlImage,
                  heightImage: iconSize,
                  widthImage: iconSize,
                  isFromAsset: isFromAsset,
                  isFromLocalFile: isFromLocalFile,
                  isFromNetwork: isFromNetwork,
                )
              : Icon(
                  iconData,
                  size: iconSize,
                  color: colorIcon,
                ),
        ],
      ),
    );
  }

  static Widget buildTitle(
      {required String text, bool isBold = true, Color? colorText}) {
    return AutoSizeText(
      text,
      style: Get.textTheme.titleLarge!.copyWith(
        fontWeight: isBold ? FontWeight.bold : null,
        color: colorText,
      ),
    );
  }
}
