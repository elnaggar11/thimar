import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/core/widgets/app_field.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/gen/assets.gen.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomImage(Assets.icons.thimarLogo),
              21.hSpace,
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'نسيت كلمة المرور',
                  style: context.boldText.copyWith(
                    fontSize: 26,
                    color: context.primaryColor,
                  ),
                ),
              ),
              8.hSpace,
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'أدخل رقم الجوال المرتبط بحسابك',
                  style: context.lightText.copyWith(fontSize: 16),
                ),
              ),

              20.hSpace,
              AppField(
                hintText: 'رقم الجوال',
                keyboardType: TextInputType.phone,
                prefixIcon: CustomImage(
                  Assets.icons.phone,
                ).withPadding(all: 19.r),
              ),
              20.hSpace,
              CustomButton(
                borderRadius: BorderRadius.circular(15.r),
                child: Text(
                  "تسجيل ",
                  style: context.boldText.copyWith(
                    fontSize: 15.sp,
                    color: context.primaryColorLight,
                  ),
                ),
              ),
              45.hSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'لديك حساب بالفعل ؟',
                    style: context.boldText.copyWith(
                      fontSize: 15.sp,
                      color: context.primaryColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      push(NamedRoutes.login);
                    },
                    child: Text('تسجيل الدخول'),
                  ),
                ],
              ),
            ],
          ).withPadding(horizontal: 16.r),
        ),
      ),
    );
  }
}
