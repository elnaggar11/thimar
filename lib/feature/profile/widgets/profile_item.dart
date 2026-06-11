import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/gen/assets.gen.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final bool hasTrailing;
  final Color? color;

  const ProfileItem({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.hasTrailing = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final itemColor = color ?? context.primaryColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        child: Row(
          children: [
            if (iconPath != Assets.icons.turnOff)
              CustomImage(
                iconPath,
                color: itemColor,
                width: 24.w,
                height: 24.w,
              ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: context.boldText.copyWith(
                  fontSize: 16.sp,
                  color: itemColor,
                ),
              ),
            ),
            if (hasTrailing)
              CustomImage(
                iconPath == Assets.icons.turnOff
                    ? Assets.icons.turnOff
                    : Assets.icons.arrowLeft,
              ),
          ],
        ),
      ),
    );
  }
}
