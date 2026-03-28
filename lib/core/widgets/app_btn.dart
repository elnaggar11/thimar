import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/widgets/loading.dart';

import '../utils/extensions.dart';

enum ButtonType { normal, error }

class CustomButton extends StatelessWidget {
  final bool isLoading, isDisabled;
  final Function()? onTap;
  final Color? backgroundColor, textColor, borderColor;
  final BorderRadiusGeometry? borderRadius;
  final String? title;
  final Widget? child;
  final double? height, width, borderWidth;
  final bool safeArea;
  final double? fontSize;
  final double? opacity;
  final bool isGradient;
  final Color? secondColor;
  final ButtonType type;

  const CustomButton({
    super.key,
    this.borderRadius,
    this.isLoading = false,
    this.title,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.child,
    this.height,
    this.width,
    this.safeArea = false,
    this.fontSize,
    this.opacity,
    this.borderColor,
    this.borderWidth,
    this.secondColor,
    this.isGradient = true,
    this.isDisabled = false,
    this.type = ButtonType.normal,
  });

  @override
  Widget build(BuildContext context) {
    // معالجة الألوان حسب الشروط
    Color effectiveTextColor = textColor ?? Colors.white;
    Color effectiveBackground = backgroundColor ?? context.primaryColor;
    Color effectiveBorderColor = borderColor ?? effectiveTextColor;

    if (type == ButtonType.error) {
      effectiveBackground = context.errorColor.withValues(alpha: 0.05);
      effectiveTextColor = context.errorColor;
      effectiveBorderColor = context.errorColor;
    }

    // لو textColor = backgroundColor → background transparent + border = textColor
    if (backgroundColor != null &&
        textColor != null &&
        backgroundColor == textColor) {
      effectiveBackground = Colors.transparent;
      effectiveBorderColor = textColor!;
    }

    final button = ElevatedButton(
      onPressed: () {
        if (isLoading || isDisabled) return;
        onTap?.call();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: effectiveBackground,
        foregroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(30.r),
          side: BorderSide(
            color: borderColor ?? effectiveBorderColor,
            width: borderWidth ?? 1,
          ),
        ),
        shadowColor: Colors.transparent,
      ),
      child: isLoading
          ? CustomProgress(size: 16.w, color: effectiveTextColor)
          : child ??
                Text(
                  title ?? '',
                  style: context.boldText.copyWith(
                    fontSize: fontSize ?? 16,
                    color: effectiveTextColor,
                  ),
                ),
    );

    final content = isGradient
        ? Container(
            decoration: BoxDecoration(
              color: effectiveBackground,
              borderRadius: borderRadius ?? BorderRadius.circular(30.r),
            ),
            child: button,
          )
        : button;

    return SafeArea(
      top: false,
      bottom: safeArea,
      child: SizedBox(
        width: width ?? double.infinity,
        height: height ?? 56,
        child: content,
      ),
    );
  }
}
