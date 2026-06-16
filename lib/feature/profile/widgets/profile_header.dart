import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/gen/locale_keys.g.dart';
import 'package:thimar/models/user_model.dart';

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
          FadeInDown(
            duration: const Duration(milliseconds: 400),
            child: Text(
              LocaleKeys.profile.tr(),
              style: context.boldText.copyWith(
                fontSize: 20.sp,
                color: Colors.white,
              ),
            ),
          ),
          24.verticalSpace,
          ZoomIn(
            duration: const Duration(milliseconds: 600),
            child: Container(
              height: 80.w,
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: Colors.white, width: 2.w),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.r),
                child: CustomImage(UserModel.i.avatarPath, fit: BoxFit.cover),
              ),
            ),
          ),
          12.verticalSpace,
          FadeInDown(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 200),
            child: Text(
              UserModel.i.name,
              style: context.boldText.copyWith(
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          ),
          4.verticalSpace,
          FadeInDown(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 300),
            child: Text(
              "${UserModel.i.phone}+",
              style: context.regularText.copyWith(
                fontSize: 14.sp,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
