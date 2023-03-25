import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:get/get.dart';

import '../../enums/input_formatter_enum.dart';
import '../../theme/colors.dart';
import '../../values/AppPaddings/padding_input.dart';
import '../../values/dimens.dart';
import '../hardware_keyboard_win.dart';
import '../limit_textfield.dart';
import '../models/input_text_form_field_model.dart';

class BuildInputText extends StatefulWidget {
  final InputTextModel inputTextFormModel;

  const BuildInputText(this.inputTextFormModel, {Key? key}) : super(key: key);

  @override
  _BuildInputTextState createState() => _BuildInputTextState();
}

class _BuildInputTextState extends State<BuildInputText> {
  final RxBool _isShowButtonClear = false.obs;
  final RxBool _showPassword = false.obs;

  @override
  void initState() {
    widget.inputTextFormModel.controller.addListener(() {
      if (widget.inputTextFormModel.controller.text.isNotEmpty) {
        _isShowButtonClear.value = true;
      }
    });
    _showPassword.value = widget.inputTextFormModel.obscureText;
    super.initState();
  }

  List<TextInputFormatter> getFormatters() {
    switch (widget.inputTextFormModel.inputFormatter) {
      case InputFormatter.digitsOnly:
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(
              widget.inputTextFormModel.maxLengthInputForm),
        ];
      case InputFormatter.textOnly:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9-_\.]')),
        ];

      // case InputFormatterEnum.negativeNumber:
      //   return [
      //     FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
      //   ];

      // case InputFormatterEnum.identity:
      //   return [
      //     FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
      //     MaskedInputFormatter('############')
      //   ];
      case InputFormatter.phoneNumber:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
          MaskedInputFormatter('##############')
        ];
      default:
        return [
          LengthLimitingTextFieldFormatterFixed(
              widget.inputTextFormModel.maxLengthInputForm)
        ];
    }
  }

  Widget? _suffixIcon() {
    if (widget.inputTextFormModel.suffixIcon != null) {
      return widget.inputTextFormModel.suffixIcon;
    }
    if (!_isShowButtonClear.value || widget.inputTextFormModel.isReadOnly) {
      return null;
    }
    return widget.inputTextFormModel.obscureText
        ? GestureDetector(
            onTap: () {
              _showPassword.toggle();
            },
            child: Icon(
              _showPassword.value
                  ? Icons.visibility_off_outlined
                  : Icons.remove_red_eye_outlined,
              color: widget.inputTextFormModel.suffixColor ??
                  AppColors.textColor(),
            ),
          )
        : Visibility(
            visible: _isShowButtonClear.value &&
                !widget.inputTextFormModel.isReadOnly,
            child: GestureDetector(
              onTap: () {
                widget.inputTextFormModel.controller.clear();
                widget.inputTextFormModel.onChanged?.call('');
                _isShowButtonClear.value = false;
              },
              child: Icon(
                Icons.clear,
                color: widget.inputTextFormModel.suffixColor ??
                    AppColors.textColor(),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ShiftRightFixer(
        child: TextFormField(
          maxLines: widget.inputTextFormModel.maxLines,
          inputFormatters: getFormatters(),
          validator: widget.inputTextFormModel.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (v) {
            if (!_isShowButtonClear.value || v.isEmpty) {
              _isShowButtonClear.value = v.isNotEmpty;
            }
            widget.inputTextFormModel.onChanged?.call(v);
          },
          textInputAction: widget.inputTextFormModel.iconNextTextInputAction,
          style: widget.inputTextFormModel.style ??
              Get.textTheme.bodyText1?.copyWith(
                  fontSize: widget.inputTextFormModel.textSize ??
                      AppDimens.fontSmall(),
                  color: widget.inputTextFormModel.textColor ?? Colors.black),
          controller: widget.inputTextFormModel.controller,
          obscureText: _showPassword.value,
          onTap: widget.inputTextFormModel.onTap,
          enabled: widget.inputTextFormModel.enable,
          autofocus: widget.inputTextFormModel.autoFocus,
          focusNode: widget.inputTextFormModel.currentNode,
          scrollPadding: const EdgeInsets.only(
            bottom: AppDimens.sizeAppBarBig + AppDimens.sizeAppBarSmall,
          ),
          keyboardType: widget.inputTextFormModel.textInputType,
          readOnly: widget.inputTextFormModel.isReadOnly,
          maxLength: widget.inputTextFormModel.maxLengthInputForm,
          textAlign: widget.inputTextFormModel.textAlign ?? TextAlign.start,
          onFieldSubmitted: (v) {
            if (widget.inputTextFormModel.iconNextTextInputAction.toString() ==
                TextInputAction.next.toString()) {
              FocusScope.of(context)
                  .requestFocus(widget.inputTextFormModel.nextNode);

              widget.inputTextFormModel.onNext?.call(v);
            } else {
              widget.inputTextFormModel.submitFunc?.call(v);
            }
          },
          decoration: InputDecoration(
            counterText:
                widget.inputTextFormModel.isShowCounterText ? null : '',
            filled: widget.inputTextFormModel.filled,
            fillColor:
                widget.inputTextFormModel.fillColor ?? AppColors.textColorWhite,
            hintStyle: TextStyle(
              fontSize: widget.inputTextFormModel.hintTextSize ??
                  AppDimens.fontMedium(),
              color: widget.inputTextFormModel.hintTextColor ??
                  AppColors.colorHintText,
            ),
            hintText: widget.inputTextFormModel.hintText,
            labelText: widget.inputTextFormModel.labelText,
            labelStyle: Get.textTheme.bodyText2,
            errorStyle: TextStyle(
              color: widget.inputTextFormModel.errorTextColor ??
                  AppColors.colorRed444,
            ),
            prefixIcon: widget.inputTextFormModel.iconLeading != null
                ? Icon(
                    widget.inputTextFormModel.iconLeading,
                    color: widget.inputTextFormModel.prefixIconColor ??
                        AppColors.colorIconDefault,
                    size: AppDimens.sizeIcon,
                  )
                : null,
            prefixStyle: const TextStyle(
                color: Colors.red, backgroundColor: AppColors.colorIconDefault),
            border: widget.inputTextFormModel.border ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        widget.inputTextFormModel.borderRadius),
                    borderSide: BorderSide.none),
            contentPadding: widget.inputTextFormModel.contentPadding ??
                AppPaddings.paddingContentInput,
            suffixIcon: _suffixIcon(),
            helperText: widget.inputTextFormModel.helperText,
            helperStyle: widget.inputTextFormModel.helperStyle,
            helperMaxLines: widget.inputTextFormModel.helperMaxLines,
          ),
        ),
      ),
    );
  }
}
