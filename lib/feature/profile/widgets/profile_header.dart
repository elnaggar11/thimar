import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 60.h, bottom: 24.h),
      decoration: BoxDecoration(
        color: context.primaryColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40.r)),
      ),
      child: Column(
        children: [
          Text(
            LocaleKeys.profile.tr(),
            style: context.boldText.copyWith(
              fontSize: 20.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            height: 80.w,
            width: 80.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.white, width: 2.w),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.r),
              child: const CustomImage(
                'https://randomuser.me/api/portraits/men/32.jpg', // Placeholder for now
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "محمد علي", // Mock data, should come from cubit/user model
            style: context.boldText.copyWith(
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "+96654787856", // Mock data
            style: context.regularText.copyWith(
              fontSize: 14.sp,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
