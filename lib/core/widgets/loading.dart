import 'package:doctorin/gen/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

import '../../gen/locale_keys.g.dart';
import '../utils/extensions.dart';
import 'custom_image.dart';

class CustomProgress extends StatelessWidget {
  final double size;
  final double? strokeWidth;
  final Color? color;
  final double? value;
  final Color? backgroundColor;
  const CustomProgress({
    super.key,
    this.size = 25,
    this.strokeWidth,
    this.color,
    this.backgroundColor,
    this.value,
  });
  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox(
      height: size,
      width: size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size,
            width: size,
            child: CircularProgressIndicator(
              value: value,
              strokeWidth: strokeWidth ?? 2,
              backgroundColor: backgroundColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? context.primaryColor,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class LoadingApp extends StatelessWidget {
  const LoadingApp({super.key});

  @override
  Widget build(BuildContext context) => CustomProgress(size: 25.h).center;
}

class LoadingImage extends StatelessWidget {
  final double? size;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  const LoadingImage({super.key, this.size, this.borderRadius, this.border});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    highlightColor: context.primaryColor,
    baseColor: context.primaryColor.withValues(alpha: 0.5),
    child: SizedBox(
      width: size ?? 70.h,
      height: size ?? 70.h,
      child: CustomImage(
        Assets.svg.appLogo,
        color: context.primaryColor,
      ).center.withPadding(horizontal: 10.w),
    ),
  ).center;
}

class PaginationLoading extends StatelessWidget {
  final bool isLoading;
  final double? height;
  const PaginationLoading({required this.isLoading, super.key, this.height});
  @override
  Widget build(BuildContext context) {
    if (!isLoading) return const SizedBox.shrink();
    return FadeTransition(
      opacity: const AlwaysStoppedAnimation(0.9),
      child: Container(
        height: height ?? 45.h,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: context.primaryColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: context.primaryColor.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          spacing: 12.w,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitThreeBounce(color: context.primaryColor, size: 18.h),
            Shimmer.fromColors(
              baseColor: context.hintColor.withValues(alpha: 0.4),
              highlightColor: context.primaryColorLight,
              child: Text(
                LocaleKeys.loading.tr(),
                style: context.mediumText.copyWith(
                  color: context.primaryColorDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
