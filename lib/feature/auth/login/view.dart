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

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              20.hSpace,
              // Top Brand Logo with slow slide down animation
              FadeInDown(
                duration: const Duration(milliseconds: 800),
                child: CustomImage(Assets.icons.thimarLogo),
              ),
              21.hSpace,

              // Welcome title with fade/slide up
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 150),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    LocaleKeys.welcomeBack.tr(),
                    style: context.boldText.copyWith(
                      fontSize: 26.sp,
                      color: context.primaryColor,
                    ),
                  ),
                ),
              ),
              8.hSpace,

              // Welcome subtitle
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 300),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    LocaleKeys.youCanLoginNow.tr(),
                    style: context.lightText.copyWith(fontSize: 16.sp),
                  ),
                ),
              ),
              26.hSpace,

              // Mobile number input field
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
              16.hSpace,

              // Password input field
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 600),
                child: AppField(
                  hintText: LocaleKeys.password.tr(),
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: CustomImage(
                    Assets.icons.password,
                  ).withPadding(all: 19.r),
                ),
              ),
              20.hSpace,

              // Forgot password button
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 750),
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () {
                      push(NamedRoutes.forgetPassword);
                    },
                    child: Text(
                      LocaleKeys.forgotPassword.tr(),
                      style: context.lightText.copyWith(
                        color: Color(0xFFB1B1B1),
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ),
              20.hSpace,

              // Login Button
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 900),
                child: CustomButton(
                  onTap: () {
                    pushAndRemoveUntil(NamedRoutes.layout);
                  },
                  borderRadius: BorderRadius.circular(15.r),
                  child: Text(
                    LocaleKeys.login.tr(),
                    style: context.boldText.copyWith(
                      fontSize: 15.sp,
                      color: context.primaryColorLight,
                    ),
                  ),
                ),
              ),
              45.hSpace,

              // Sign-up row section
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 1050),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.dontHaveAnAccount.tr(),
                      style: context.boldText.copyWith(
                        fontSize: 15.sp,
                        color: context.primaryColor,
                      ),
                    ),
                    4.horizontalSpace,
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),

                      onPressed: () {
                        push(NamedRoutes.signUp);
                      },
                      child: Text(LocaleKeys.registerNow.tr()),
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
