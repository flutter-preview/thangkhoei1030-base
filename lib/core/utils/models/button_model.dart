import 'package:flutter/material.dart';

class ButtonModel {
  String btnTitle;
  Function()? funcHandle;
  double? width;
  double? height;
  double? fontSize;
  double? radius;
  Color? textColor;
  BorderRadius? borderRadius;
  List<Color> colors;
  AlignmentGeometry? alignment;
  bool isShowLoading;
  bool isLoading;
  ButtonModel({
    required this.btnTitle,
    this.funcHandle,
    this.width,
    this.height,
    this.fontSize,
    this.textColor,
    this.borderRadius,
    this.colors = const [],
    this.alignment,
    this.isShowLoading = false,
    this.isLoading = false,
  });

  ButtonModel copyWith({
    String? btnTitle,
    Function()? funcHandle,
    Color? backgroundColor,
    double? width,
    double? height,
    double? fontSize,
    Color? textColor,
    BorderRadius? borderRadius,
    List<Color>? colorGradient,
    AlignmentGeometry? alignment,
    bool? isShowLoading,
    bool? isLoading,
  }) {
    return ButtonModel(
      btnTitle: btnTitle ?? this.btnTitle,
      funcHandle: funcHandle ?? this.funcHandle,
      width: width ?? this.width,
      height: height ?? this.height,
      fontSize: fontSize ?? this.fontSize,
      textColor: textColor ?? this.textColor,
      borderRadius: borderRadius ?? this.borderRadius,
      colors: colorGradient ?? colors,
      alignment: alignment ?? this.alignment,
      isShowLoading: isShowLoading ?? this.isShowLoading,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  LinearGradient? get gradientColors =>
      isUseLinearGradientColor
          ? LinearGradient(colors: colors)
          : null;

  Color? get backGroundColors =>
      isUseLinearGradientColor || colors.length != 1 ? null : colors.first;

  bool get isUseLinearGradientColor => colors.length > 1;
}
