import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../gen/assets.gen.dart';
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
    this.size = 75, // حجم مناسب وواضح
    this.strokeWidth,
    this.color,
    this.backgroundColor,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // خلفية دائرية بيضاء مع ظل ناعم (يعطي إحساس بالعمق والاحترافية)
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (color ?? context.primaryColor).withValues(alpha: 0.15),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
          // دائرة التحميل تدور بالضبط على حافة الخلفية البيضاء
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: value,
              strokeWidth: strokeWidth ?? 3.5,
              strokeCap: StrokeCap.round, // حواف ناعمة
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? context.primaryColor,
              ),
              backgroundColor: backgroundColor ?? Colors.transparent, // شفافة لتبرز الخلفية البيضاء
            ),
          ),
          // اللوجو في المنتصف وينبض (بحجم متناسق داخل الدائرة)
          Pulse(
            infinite: true,
            duration: const Duration(milliseconds: 1500), // إبطاء النبض قليلاً ليكون أهدأ
            child: CustomImage(
              Assets.icons.thimarLogo,
              width: size * 0.55, // اللوجو يأخذ 55% من مساحة الدائرة ليترك هوامش مريحة للعين
              height: size * 0.55,
            ),
          ),
        ],
      ),
    );
  }
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
        // TODO : put image name
        "Assets.svg.appLogo",

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
            // SpinKitThreeBounce(color: context.primaryColor, size: 18.h),
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
