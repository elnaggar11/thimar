import 'package:doctorin/core/utils/extensions.dart';
import 'package:doctorin/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/assets.gen.dart';

class LogoName extends StatelessWidget {
  final MainAxisAlignment? mainAxisAlignment;
  final double? height, width, fontSize;
  const LogoName({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.height,
    this.width,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        spacing: 2.w,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        children: [
          CustomImage(
            Assets.svg.appLogo,
            width: width ?? 25.w,
            height: height ?? 25.h,
            color: context.primaryColor,
          ),
          RichText(
            text: TextSpan(
              text: "Doctor",
              style: context.boldText.copyWith(
                fontSize: fontSize ?? 20,
                color: context.primaryColor,
              ),
              children: [
                TextSpan(
                  text: " in",
                  style: context.boldText.copyWith(
                    fontSize: fontSize ?? 20,
                    color: context.secondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
