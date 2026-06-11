import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:animate_do/animate_do.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/core/widgets/app_field.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Brand Logo with slow slide down animation
              FadeInDown(
                duration: const Duration(milliseconds: 800),
                child: CustomImage(Assets.icons.thimarLogo),
              ),
              21.hSpace,
              
              // Forget Password Title
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 150),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    LocaleKeys.forgetPasswordTitle.tr(),
                    style: context.boldText.copyWith(
                      fontSize: 16.sp,
                      color: context.primaryColor,
                    ),
                  ),
                ),
              ),
              8.hSpace,
              
              // Instruction Subtitle
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 300),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    LocaleKeys.enterMobileAssociated.tr(),
                    style: context.lightText.copyWith(fontSize: 16.sp),
                  ),
                ),
              ),
              20.hSpace,
              
              // Mobile input field
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 450),
                child: AppField(
                  hintText: LocaleKeys.mobileNumber.tr(),
                  keyboardType: TextInputType.phone,
                  prefixIcon: CustomImage(
                    Assets.icons.phone,
                  ).withPadding(all: 19.r),
                ),
              ),
              20.hSpace,
              
              // Confirm button
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 600),
                child: CustomButton(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Text(
                    LocaleKeys.confirmMobileNumber.tr(),
                    style: context.boldText.copyWith(
                      fontSize: 15.sp,
                      color: context.primaryColorLight,
                    ),
                  ),
                  onTap: () {
                    push(NamedRoutes.verify);
                  },
                ),
              ),
              45.hSpace,
              
              // Footer login navigation row
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 750),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.alreadyHaveAccount.tr(),
                      style: context.boldText.copyWith(
                        fontSize: 15.sp,
                        color: context.primaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        push(NamedRoutes.login);
                      },
                      child: Text(LocaleKeys.login.tr()),
                    ),
                  ],
                ),
              ),
            ],
          ).withPadding(horizontal: 16.r),
        ),
      ),
    );
  }
}
