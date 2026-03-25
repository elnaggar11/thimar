import 'package:doctorin/core/widgets/app_btn.dart';
import 'package:doctorin/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/enums.dart';
import '../utils/extensions.dart';
import 'custom_image.dart';

class CustomErrorWidget extends StatelessWidget {
  final String title;
  final String? subtitle, image;
  final Color? color;
  final ErrorType? errType;
  final void Function()? onTap;
  final String? btnTitle;
  final double? height;
  final EdgeInsetsGeometry? padding;
  const CustomErrorWidget({
    required this.title,
    super.key,
    this.subtitle,
    this.image,
    this.color,
    this.errType,
    this.height,
    this.padding,
    this.onTap,
    this.btnTitle,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: padding ?? EdgeInsets.only(bottom: context.bottomBarHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8.h,
        children: [
          if (img != null) ...[
            CustomImage(img, height: 180.h, color: color).center,
            SizedBox(height: 24.h),
          ],
          SingleChildScrollView(
            child: Text(
              title,
              maxLines: 5,
              textAlign: TextAlign.center,
              style: context.mediumText.copyWith(fontSize: 18),
            ),
          ),
          if (subtitle?.isNotEmpty == true)
            Text(
              subtitle ?? '',
              textAlign: TextAlign.center,
              style: context.regularText.copyWith(color: context.hintColor),
            ),
          if (onTap != null) ...[
            SizedBox(height: 12.h),
            CustomButton(
              title: btnTitle ?? LocaleKeys.tryAgain.tr(),
              onTap: onTap,
            ),
          ],
        ],
      ).withPadding(horizontal: 24.w),
    ),
  );

  String? get img {
    if (image?.isNotEmpty == true) {
      return image;
    }
    switch (errType) {
      case ErrorType.network:
        return 'assets/svg/no-internet.svg';
      case ErrorType.empty:
        return 'assets/svg/no-result.svg';
      case ErrorType.server:
        return 'assets/svg/no-result.svg';
      default:
        return 'assets/svg/no-result.svg';
    }
  }
}

class CustomEmptyWidget extends StatelessWidget {
  final ErrorType? errorStatus;
  final String? errorMessage;
  final VoidCallback? onTap;
  // final VoidCallback? onTap;

  const CustomEmptyWidget({
    super.key,
    this.errorStatus = ErrorType.empty,
    this.errorMessage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          16.h.verticalSpace,
          Text(
            errorMessage ?? LocaleKeys.dataNotFound.tr(),
            style: context.mediumText,
            textAlign: TextAlign.center,
          ),
          30.h.verticalSpace,
          if (onTap != null)
            SizedBox(
              width: 0.5.sw,
              child: CustomButton(title: "refresh", onTap: onTap),
            ),
        ],
      ),
    ),
  );
}
