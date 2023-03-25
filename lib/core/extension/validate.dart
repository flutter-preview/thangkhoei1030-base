import 'package:flutter_application_3/core/enums/enum_type_input.dart';

import '../values/const.dart';

extension StringUtils on String? {
  bool get isStringNotEmpty => this != null && this!.trim().isNotEmpty;

  bool get isStringEmpty => this != null && this!.trim().isEmpty;
}

List<int> test = [1, 2, 3, 4];

extension ListUtils<T> on Iterable<T>? {
  bool get isListNotEmpty => this != null && this!.isNotEmpty;
}

String convertDoubleToStringSmart(double? value) {
  return '${value?.toInt() == value ? value?.toInt() : value}';
}

extension ValidateInfo on String? {
  bool isPasswordValidate({
    required int minLength,
    int maxLength = 0,
  }) {
    if (isStringNotEmpty) {
      // Trường hợp có yêu cầu nhập tối đa vào mật khẩu.
      if (maxLength > 0) {
        if (this!.length >= minLength && this!.length <= maxLength) {
          return true;
        }
      } else {
        // Trường hợp chỉ yêu cầu số ký tự tối thiểu nhập vào của mật khẩu.
        if (this!.length >= minLength) {
          return true;
        }
      }
    }
    return false;
  }

  bool get isPhoneValidate {
    if (this == null) return false;
    if (this!.trim().isEmpty || !RegExp(r'\d{10,14}').hasMatch(this!)) {
      return false;
    }
    return true;
  }

  bool get isIdentityCard {
    if (this == null) return false;
    if (this!.trim().isEmpty || !RegExp(r'\d{9,12}').hasMatch(this!)) {
      return false;
    }
    return true;
  }

  bool get isTaxCode {
    if (this!.length < 10) return false;
    return true;
  }

  bool get isEmail {
    RegExp _email = RegExp(
        r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

    if (this == null) return false;
    if (this!.trim().isEmpty || !_email.hasMatch(this!.toLowerCase())) {
      return false;
    }

    return true;
  }

  String? validator(TypeInput type, {int? minLength}) {
    switch (type) {
      case TypeInput.email:
        if (isStringNotEmpty && !isEmail) {
          return "AppStr.errorEmail.tr";
        }
        print(isStringNotEmpty && isEmail);
        break;
      case TypeInput.password:
        return isPasswordValidate(minLength: minLength ?? 0)
            ? null
            : "AppStr.errorPassword";
      default:
        return null;
    }
    return null;
  }
}

