import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/extensions.dart';

class BaseShimmer extends StatelessWidget {
  final Widget child;
  final Color? highlightColor, baseColor;
  const BaseShimmer({
    required this.child,
    super.key,
    this.highlightColor,
    this.baseColor,
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    highlightColor: highlightColor ?? context.hintColor.withValues(alpha: .05),
    baseColor: baseColor ?? context.hintColor.withValues(alpha: .2),
    child: child,
  );
}

class ShimmerContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxShape? shape;
  final Color? shadowColor;
  final double? borderRadius;
  final BorderRadiusGeometry? border;
  final EdgeInsetsGeometry? margin, padding;
  final Widget? child;
  const ShimmerContainer({
    super.key,
    this.height,
    this.borderRadius,
    this.width,
    this.shape,
    this.border,
    this.decoration,
    this.shadowColor,
    this.margin,
    this.padding,
    this.child,
  });
  final Decoration? decoration;
  @override
  Widget build(BuildContext context) => Container(
    height: height ?? 15,
    width: width ?? double.infinity,
    margin: margin,
    padding: padding,
    decoration:
        decoration ??
        BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: shadowColor ?? Colors.transparent,
              blurRadius: 2,
              offset: const Offset(1, 2),
            ),
          ],
          shape: shape ?? BoxShape.rectangle,
          color: context.hintColor,
          borderRadius: BoxShape.circle == shape
              ? null
              : border ?? BorderRadius.circular(borderRadius ?? 16.r),
        ),
    child: child,
  );
}
