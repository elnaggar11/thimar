import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      // leadingWidth: 70.w,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImage(
                  Assets
                      .icons
                      .thimarLogo, // Assuming we use splashLogo or thimarLogo
                  width: 25.w,
                  height: 25.w,
                ),
                SizedBox(width: 4.w),
                Text(
                  "سلة ثمار",
                  style: context.boldText.copyWith(
                    fontSize: 14.sp,
                    color: context.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          30.horizontalSpace,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleKeys.deliveryTo.tr(),
                style: context.boldText.copyWith(
                  fontSize: 12.sp,
                  color: context.primaryColor,
                ),
              ),
              Text(
                "شارع الملك فهد - جدة",
                style: context.regularText.copyWith(
                  fontSize: 14.sp,
                  color: context.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Center(
          child: Badge(
            label: Text(
              '0',
              style: TextStyle(color: Colors.white, fontSize: 10.sp),
            ),
            backgroundColor: context.primaryColor,
            child: Container(
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color: context.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: CustomImage(
                Assets.icons.bag,
                width: 20.w,
                height: 20.w,
                color: context.primaryColor,
              ),
            ),
          ),
        ).withPadding(horizontal: 16.w),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
