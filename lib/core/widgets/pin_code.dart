import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' as dr;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:thimar/gen/locale_keys.g.dart';

import '../utils/extensions.dart';

class CustomPinCode extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onCompleted, onChanged;
  final String? Function(String?)? validate;

  const CustomPinCode({
    super.key,
    this.controller,
    this.onCompleted,
    this.validate,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: dr.TextDirection.ltr,
    child: PinCodeTextField(
      appContext: context,
      autoFocus: true,
      pastedTextStyle: const TextStyle(fontWeight: FontWeight.bold),
      length: 4,
      hintCharacter: '-',
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return LocaleKeys.valIsRequired.tr(args: [LocaleKeys.code.tr()]);
        } else if (value.length < 4) {
          return LocaleKeys.contains_4.tr();
        }
        return null;
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      hintStyle: TextStyle(color: context.hintColor),
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        activeColor: context.borderColor,
        selectedColor: context.primaryColor,
        activeFillColor: context.scaffoldBackgroundColor,
        borderWidth: 1.r,
        activeBorderWidth: 0.5.r,
        disabledBorderWidth: 0.5.r,
        selectedBorderWidth: 0.8.r,
        inactiveBorderWidth: 0.5.r,
        selectedFillColor: context.scaffoldBackgroundColor,
        inactiveColor: context.borderColor,
        inactiveFillColor: context.scaffoldBackgroundColor,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(20.r),
        fieldHeight: 60.h,
        fieldWidth: 70.w,
        fieldOuterPadding: EdgeInsets.symmetric(horizontal: 5.w),
      ),
      cursorColor: context.primaryColorDark,
      animationDuration: const Duration(milliseconds: 500),
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      animationCurve: Curves.easeInQuad,
      useExternalAutoFillGroup: true,
      onChanged: onChanged,
      onCompleted: onCompleted,
      beforeTextPaste: (text) => false,
    ),
  );
}
