import 'package:doctorin/core/utils/extensions.dart';
import 'package:doctorin/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

class InputValidator {
  static final arabicPhoneNumbersReg = RegExp(r"[\u0660-\u0669]");
  static final _arabicTextReg = RegExp(r"[\u0600-\u06ff]+");
  static final _emailReg = RegExp(
    r'[a-z]+\d*@[a-z]+\.[a-z]{3}',
    caseSensitive: false,
  );

  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return LocaleKeys.valIsRequired.tr(args: [LocaleKeys.email.tr()]);
    } else {
      if (_emailReg.hasMatch(value) == false) {
        return LocaleKeys.invalidEmail.tr();
      } else {
        return null;
      }
    }
  }

  static String? emailOrPhoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.valIsRequired.tr(args: [LocaleKeys.emailOrPhone.tr()]);
    } else if (value.isPhoneNumber) {
      return phoneValidator(value);
    } else {
      return emailValidator(value);
    }
  }

  static String? phoneValidator(String? value) {
    if (value!.isEmpty) {
      return LocaleKeys.valIsRequired.tr(args: [LocaleKeys.phone_number.tr()]);
    } else {
      if (!value.startsWith('0') && !value.startsWith('1')) {
        return LocaleKeys.invalid_phone_number.tr();
      }
      if (value.length < 10) {
        return LocaleKeys.the_phone_number_must_consist_of_val_numbers.tr(
          namedArgs: {'val': '10'},
        );
      } else {
        return null;
      }
    }
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return LocaleKeys.valIsRequired.tr(args: [LocaleKeys.password.tr()]);
    } else if (value.length < 8) {
      return LocaleKeys.passwordDigits.tr(args: ['8']);
    } else if (!hasSymbols(value) || !hasNumbers(value) || !hasLetters(value)) {
      return LocaleKeys.passwordMustContainLettersAndNumbers.tr();
    }
    return null;
  }

  static bool hasLetters(String value) => RegExp(r'[A-Za-z]').hasMatch(value);
  static bool hasNumbers(String value) => RegExp(r'[0-9]').hasMatch(value);
  static bool hasSymbols(String value) =>
      RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
  static bool isNumbersArabic(String value) {
    if (arabicPhoneNumbersReg.hasMatch(value)) {
      return true;
    }
    return false;
  }

  static String replaceArabicNumbers(String value) => value.replaceAllMapped(
    arabicPhoneNumbersReg,
    (m) => '${(m[0]!.codeUnits[0] - 1584) - 48}',
  );

  static bool isTextArabic(String value) {
    if (_arabicTextReg.hasMatch(value)) {
      return true;
    }
    return false;
  }

  static String fixPhone({required String phone, required String countryCode}) {
    if (phone.trim().startsWith("0")) {
      phone = phone.trim().substring(1);
    }
    return (countryCode) + replaceArabicNumbers(phone);
  }

  static String fixPhoneCode(String phoneCode) {
    if (phoneCode.startsWith("+")) {
      phoneCode = phoneCode.substring(1);
    }
    return phoneCode;
  }

  static String? requiredValidator({
    required String value,
    required String itemName,
    bool lengthRequired = false,
    int lengthNumber = 2,
  }) {
    if (value.trim().isEmpty) {
      return LocaleKeys.validate_required.tr(args: [itemName]);
    } else if (value.trim().length < lengthNumber && lengthRequired) {
      return LocaleKeys.validateAtLeast3Digits.tr(
        args: [itemName, lengthNumber.toString()],
      );
    }
    return null;
  }

  static String? requiredField({required String value}) {
    if (value.trim().isEmpty) {
      return LocaleKeys.requiredField.tr();
    }
    return null;
  }
}

class ArabicToEnglishFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;
    final converted = InputValidator.replaceArabicNumbers(newValue.text);
    return newValue.copyWith(
      text: converted,
      selection: TextSelection.collapsed(offset: converted.length),
    );
  }
}
