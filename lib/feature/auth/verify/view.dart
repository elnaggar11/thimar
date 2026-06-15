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
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/core/widgets/pin_code.dart';
import 'package:thimar/feature/auth/verify/cubit/verify_cubit.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';
import 'package:thimar/feature/auth/verify/widgets/resend_otp.dart';

class VerifyView extends StatefulWidget {
  const VerifyView({super.key});

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  bool _isTimerFinished = false;
  final cubit = sl<VerifyCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: cubit.formKey,
            child: Column(
              children: [
                20.hSpace,
                // Top Brand Logo with slow slide down
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: CustomImage(Assets.icons.thimarLogo),
                ),
                21.hSpace,
                // Verify/Forget Password Title
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 150),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      context.arg['verifyType'] == VerifyType.register
                          ? LocaleKeys.activateAccount.tr()
                          : LocaleKeys.forgetPasswordTitle.tr(),
                      style: context.boldText.copyWith(
                        fontSize: 16.sp,
                        color: context.primaryColor,
                      ),
                    ),
                  ),
                ),
                8.hSpace,
                // Code Sent Subtitle
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 300),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text.rich(
                      TextSpan(
                        text: '${LocaleKeys.enterCodeSentTo.tr()} ',
                        style: context.lightText.copyWith(fontSize: 16.sp),
                        children: [
                          TextSpan(
                            text: context.arg['phone']?.toString() ?? ' ',
                            style: context.boldText.copyWith(
                              fontSize: 16.sp,
                              color: context.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                26.hSpace,

                // Pin Code Input Widgets
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 450),
                  child: CustomPinCode(controller: cubit.codeController),
                ),
                28.hSpace,

                // Confirm button
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 600),
                  child: BlocConsumer<VerifyCubit, VerifyState>(
                    bloc: cubit,
                    listener: (context, state) {
                      if (state.state == RequestState.done) {
                        if (context.arg['verifyType'] == VerifyType.register) {
                          pushAndRemoveUntil(NamedRoutes.login);
                        } else if (context.arg['verifyType'] ==
                            VerifyType.forgetPassword) {
                          pushAndRemoveUntil(
                            NamedRoutes.resetPassword,
                            arg: {
                              'phone': context.arg['phone'],
                              "code": cubit.codeController.text,
                            },
                          );
                        }
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Text(
                          LocaleKeys.confirmCode.tr(),
                          style: context.boldText.copyWith(
                            fontSize: 15.sp,
                            color: context.primaryColorLight,
                          ),
                        ),
                        onTap: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.verify(
                              verifyType: context.arg['verifyType'],
                              phone: context.arg['phone'],
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                20.hSpace,

                // Resend code countdown and prompts
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 750),
                  child: Column(
                    children: [
                      Text(
                        LocaleKeys.did_not_you_receive_the_code.tr(),
                        style: context.lightText.copyWith(
                          fontSize: 16.sp,
                          color: context.hintColor,
                        ),
                      ),
                      if (!_isTimerFinished) ...[
                        Text(
                          LocaleKeys.youCanResendCodeAfter.tr(),
                          style: context.lightText.copyWith(
                            fontSize: 16.sp,
                            color: context.hintColor,
                          ),
                        ),
                        20.hSpace,
                        ResendOtpWidget(
                          onComplete: () {
                            setState(() {
                              _isTimerFinished = true;
                            });
                          },
                        ),
                      ] else ...[
                        20.hSpace,
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: context.primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 20.r,
                              horizontal: 16.r,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _isTimerFinished = false;
                              cubit.resend(
                                phone: context.arg['phone']?.toString() ?? '',
                              );
                            });
                          },
                          child: Text(
                            LocaleKeys.resend.tr(),
                            style: context.boldText.copyWith(
                              fontSize: 15.sp,
                              color: context.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                45.hSpace,

                // Footer login navigation row
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 900),
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
            ),
          ).withPadding(horizontal: 16.r),
        ),
      ),
    );
  }
}
