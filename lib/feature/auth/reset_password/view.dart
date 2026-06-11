import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/core/widgets/app_field.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/gen/assets.gen.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

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
                    fontSize: 16,
                    color: context.primaryColor,
                  ),
                ),
              ),
              8.hSpace,
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'أدخل كلمة المرور الجديدة',
                  style: context.lightText.copyWith(fontSize: 16),
                ),
              ),
              20.hSpace,
              AppField(
                hintText: 'كلمة المرور الجديدة',
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: CustomImage(
                  Assets.icons.password,
                ).withPadding(all: 19.r),
              ),
              20.hSpace,
              AppField(
                hintText: 'تأكيد كلمة المرور الجديدة',
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: CustomImage(
                  Assets.icons.password,
                ).withPadding(all: 19.r),
              ),
              20.hSpace,
              CustomButton(
                borderRadius: BorderRadius.circular(15.r),
                child: Text(
                  "تغيير كلمة المرور",
                  style: context.boldText.copyWith(
                    fontSize: 15.sp,
                    color: context.primaryColorLight,
                  ),
                ),
                onTap: () {
                  pushAndRemoveUntil(NamedRoutes.login);
                },
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
