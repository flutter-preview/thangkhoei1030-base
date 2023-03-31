import 'package:flutter/material.dart';

import '../../enums/input_formatter_enum.dart';

class InputTextModel {
  IconData? iconLeading;

  String? hintText;

  TextEditingController controller;

  FocusNode? currentNode;

  FocusNode? nextNode;

  bool obscureText;

  double borderRadius;

  TextInputAction iconNextTextInputAction;

  ValueChanged<String>? submitFunc;

  ValueChanged<String>? onNext;

  FormFieldValidator<String>? validator;

  /// 0 : LengthLimitingText. Giới hạn ký tự nhập(nếu có)
  /// 1 : digitsOnly. Chỉ nhập số
  /// 2 : TaxCode. Kiểu nhập là mã số thuế
  /// 3 : Không cho nhập các ký tự đặc biệt. dấu cách
  /// 4 : Nhập giá trị tiền
  /// 5 : Cho phép nhập giá trị âm
  InputFormatter inputFormatter;

  TextInputType textInputType;

  /// The [lengthLimit] must be null, -1 or greater than zero. If it is null or -1
  /// then no limit is enforced.
  int? maxLengthInputForm;

  bool isReadOnly;

  bool autoFocus;

  Color? fillColor;

  Color? textColor;

  Color? hintTextColor;

  double? hintTextSize;

  double? textSize;

  Color? prefixIconColor;

  Color? errorTextColor;

  Color? suffixColor;

  ValueChanged<String>? onChanged;

  int? maxLines;

  Widget? suffixIcon;

  TextAlign? textAlign;

  bool isShowCounterText;

  bool enable;

  String? labelText;

  VoidCallback? onTap;

  EdgeInsetsGeometry? contentPadding;

  String? helperText;

  TextStyle? helperStyle;

  int? helperMaxLines;

  TextStyle? style;

  InputBorder? border;

  bool filled;
  bool isUseSuffixIcon;
  bool? showCursor;
  Widget? suffixWidget;
  InputTextModel(
      {this.iconLeading,
      this.hintText,
      required this.controller,
      this.currentNode,
      this.submitFunc,
      this.nextNode,
      this.obscureText = false,
      this.iconNextTextInputAction = TextInputAction.next,
      this.onNext,
      this.validator,
      this.inputFormatter = InputFormatter.none,
      this.borderRadius = 10.0,
      this.textInputType = TextInputType.text,
      this.maxLengthInputForm,
      this.isReadOnly = false,
      this.autoFocus = false,
      this.fillColor,
      this.textColor,
      this.hintTextColor,
      this.hintTextSize,
      this.textSize,
      this.prefixIconColor,
      this.errorTextColor,
      this.suffixColor,
      this.onChanged,
      this.maxLines = 1,
      this.suffixIcon,
      this.isShowCounterText = true,
      this.textAlign,
      this.enable = true,
      this.contentPadding,
      this.labelText,
      this.onTap,
      this.helperText,
      this.helperStyle,
      this.helperMaxLines,
      this.style,
      this.border,
      this.filled = true,
      this.showCursor,
      this.isUseSuffixIcon = false,
      this.suffixWidget});
}
