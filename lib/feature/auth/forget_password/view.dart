import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:animate_do/animate_do.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/core/widgets/app_field.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/feature/auth/forget_password/cubit/forget_password_cubit.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final cubit = sl<ForgetPasswordCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: cubit.formKey,
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
                    controller: cubit.phoneController,
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
                  child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                    bloc: cubit,
                    listener: (context, state) {
                      if (state.state == RequestState.done) {
                        push(
                          NamedRoutes.verify,
                          arg: {
                            'phone': cubit.phoneController.text,
                            'verifyType': VerifyType.forgetPassword,
                          },
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        borderRadius: BorderRadius.circular(15.r),
                        isLoading: state.state == RequestState.loading,
                        child: Text(
                          LocaleKeys.confirmMobileNumber.tr(),
                          style: context.boldText.copyWith(
                            fontSize: 15.sp,
                            color: context.primaryColorLight,
                          ),
                        ),
                        onTap: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.forgetPassword(cubit.phoneController.text);
                          }
                        },
                      );
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
      ),
    );
  }
}
