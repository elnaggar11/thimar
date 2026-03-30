import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/input_validator.dart';
import 'package:thimar/core/widgets/fade_in_slide.dart';
import 'package:thimar/gen/assets.gen.dart';

import '../../gen/locale_keys.g.dart';
import '../utils/extensions.dart';
import 'custom_image.dart';
import 'loading.dart';

class AppField extends StatefulWidget {
  final String? hintText, labelText, title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? margin;
  final String? Function(String? v)? validator;
  final bool isRequired, loading;
  final bool? enable, readOnly;
  final int maxLines;
  final int? maxLenght;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final Widget? suffixIcon, prefixIcon;
  final Color? fillColor;
  final String? direction;
  final InputBorder? border;
  final List<TextInputFormatter>? inputFormatters;
  final double? height;

  const AppField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType,
    this.border,
    this.margin,
    this.validator,
    this.isRequired = true,
    this.loading = false,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.maxLenght,
    this.suffixIcon,
    this.fillColor,
    this.prefixIcon,
    this.title,
    this.enable,
    this.readOnly = false,
    this.direction,
    this.inputFormatters,
    this.height,
  });

  @override
  State<AppField> createState() => _AppFieldState();
}

class _AppFieldState extends State<AppField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    widget.controller?.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.dispose();
    widget.controller?.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: widget.margin ?? EdgeInsets.zero,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5.w,
      children: [
        if (widget.keyboardType == TextInputType.phone)
          FadeInSlide(
            duration: 0.6,
            child: Container(
              // padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 8.h),
              decoration: BoxDecoration(
                border: Border.all(color: context.borderColor),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("🇸🇦", style: TextStyle(fontSize: 18.sp)),
                  SizedBox(height: 2.h),
                  Text(
                    "+966",
                    style: context.mediumText.copyWith(
                      color: context.primaryColor,
                      fontSize: 15.sp,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ).withPadding(horizontal: 18.r, vertical: 8.r),
            ),
          ),
        Expanded(
          child: SizedBox(
            height: widget.height,
            child: Stack(
              children: [
                TextFormField(
                  focusNode: _focusNode,
                  onChanged: widget.onChanged,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  maxLines: widget.maxLines,
                  maxLength: widget.keyboardType == TextInputType.phone
                      ? 9
                      : widget.maxLenght,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  readOnly: widget.readOnly == true || widget.onTap != null,
                  onTap: widget.onTap,
                  enabled: widget.enable,
                  obscureText:
                      widget.keyboardType == TextInputType.visiblePassword &&
                      showPass,
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  inputFormatters: [
                    if (widget.keyboardType == TextInputType.phone ||
                        widget.keyboardType == TextInputType.emailAddress)
                      ArabicToEnglishFormatter(),
                    ...?widget.inputFormatters,
                  ],
                  validator: (v) {
                    if (widget.validator != null) {
                      return widget.validator?.call(v);
                    }
                    if (widget.isRequired && v?.isEmpty == true) {
                      if ([
                        LocaleKeys.password.tr(),
                        LocaleKeys.enter_password_again.tr(),
                        LocaleKeys.message.tr(),
                      ].contains(widget.labelText)) {
                        return LocaleKeys.valueIsRequired.tr(
                          args: [
                            widget.labelText?.replaceAll('*', '') ??
                                widget.title ??
                                LocaleKeys.this_field.tr(),
                          ],
                        );
                      } else {
                        return LocaleKeys.valIsRequired.tr(
                          args: [
                            widget.labelText?.replaceAll('*', '') ??
                                widget.title ??
                                LocaleKeys.this_field.tr(),
                          ],
                        );
                      }
                    } else if (widget.keyboardType ==
                        TextInputType.emailAddress) {
                      return InputValidator.emailValidator(v!);
                    } else if (widget.keyboardType == TextInputType.phone) {
                      return InputValidator.phoneValidator(v!);
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: widget.height != null
                        ? EdgeInsets.symmetric(horizontal: 14.w)
                        : (widget.labelText != null
                              ? EdgeInsets.fromLTRB(14.w, 24.h, 14.w, 8.h)
                              : null),
                    hintText:
                        widget.hintText ??
                        (widget.labelText == null
                            ? LocaleKeys.write_val.tr(
                                args: [widget.title ?? ''],
                              )
                            : null),
                    hintStyle: context.mediumText,
                    counterText:
                        (widget.keyboardType == TextInputType.phone ||
                            widget.maxLenght != null)
                        ? ""
                        : null,
                    errorMaxLines: 2,
                    fillColor: widget.fillColor,
                    prefixIcon: buildPrefixIcon(context),
                    suffixIcon: buildSuffixIcon(context),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: context.errorColor),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(14.r),
                        bottom: Radius.circular(14.r),
                      ),
                    ),
                    disabledBorder:
                        widget.border ??
                        OutlineInputBorder(
                          borderSide: BorderSide(
                            color: context.mainBorderColor,
                          ),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(14.r),
                            bottom: Radius.circular(14.r),
                          ),
                        ),
                    border:
                        widget.border ??
                        OutlineInputBorder(
                          borderSide: BorderSide(
                            color: context.mainBorderColor,
                          ),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(14.r),
                            bottom: Radius.circular(14.r),
                          ),
                        ),
                    focusedBorder:
                        widget.border ??
                        OutlineInputBorder(
                          borderSide: BorderSide(color: context.primaryColor),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(14.r),
                            bottom: Radius.circular(14.r),
                          ),
                        ),
                    enabledBorder:
                        widget.border ??
                        OutlineInputBorder(
                          borderSide: BorderSide(
                            color: context.mainBorderColor,
                          ),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(14.r),
                            bottom: Radius.circular(14.r),
                          ),
                        ),
                  ),
                ),
                if (widget.labelText != null)
                  AnimatedPositionedDirectional(
                    duration: const Duration(milliseconds: 200),
                    start: 14.w,
                    top: (widget.controller?.text.isNotEmpty ?? false)
                        ? 1.h
                        : 20.h,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: (widget.controller?.text.isNotEmpty ?? false)
                          ? 1.0
                          : 0.0,
                      child: IgnorePointer(
                        child: Text(
                          widget.labelText!,
                          style: context.regularText.copyWith(
                            fontSize: 12,
                            color: context.hintColor,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  bool showPass = true;

  Widget? buildSuffixIcon(BuildContext context) {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon!;
    } else if (widget.loading) {
      return SizedBox(
        height: 20.h,
        width: 20.h,
        child: CustomProgress(size: 15.h),
      );
    } else if (widget.keyboardType == TextInputType.visiblePassword) {
      return GestureDetector(
        onTap: () {
          setState(() {
            showPass = !showPass;
          });
        },
        child: SizedBox(
          width: 20.w,
          height: 20.w,
          child: CustomImage(
            // TODO: change icons
            showPass ? 'Icons.password' : 'Icons.apartment',
            width: 20.w,
            height: 20.w,
            color: context.primaryColor,
          ).center,
        ),
      );
    }
    return null;
  }

  Widget? buildPrefixIcon(BuildContext context) {
    if (widget.prefixIcon != null) {
      return widget.prefixIcon;
    }
    return null;
  }
}
