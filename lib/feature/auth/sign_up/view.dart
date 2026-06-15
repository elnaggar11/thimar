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
import 'package:thimar/feature/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:thimar/feature/auth/sign_up/widgets/cities_select_sheet.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final cubit = sl<SignUpCubit>();

  @override
  void initState() {
    super.initState();
    cubit.getCities();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
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
                        LocaleKeys.youCanRegisterNewAccountNow.tr(),
                        style: context.lightText.copyWith(fontSize: 16.sp),
                      ),
                    ),
                  ),
                  26.hSpace,

                  // Username input field
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 450),
                    child: AppField(
                      controller: cubit.usernameController,
                      hintText: LocaleKeys.username.tr(),
                      prefixIcon: CustomImage(
                        Assets.icons.user,
                      ).withPadding(all: 19.r),
                    ),
                  ),
                  20.hSpace,

                  // Mobile number input field
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 600),
                    child: AppField(
                      controller: cubit.phoneController,
                      hintText: LocaleKeys.mobileNumber.tr(),
                      keyboardType: TextInputType.phone,
                      prefixIcon: CustomImage(
                        Assets.icons.phone,
                      ).withPadding(all: 19.r),
                    ),
                  ),
                  20.hSpace,

                  // City name input field
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 750),
                    child: BlocBuilder<SignUpCubit, SignUpState>(
                      builder: (context, state) {
                        return AppField(
                          controller: cubit.cityController,
                          hintText: LocaleKeys.cityName.tr(),
                          prefixIcon: CustomImage(
                            Assets.icons.city,
                          ).withPadding(all: 19.r),
                          readOnly: true,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) =>
                                  CitiesSelectSheet(cubit: cubit),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  20.hSpace,
                  // Password input field
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 900),
                    child: AppField(
                      controller: cubit.passwordController,
                      hintText: LocaleKeys.password.tr(),
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: CustomImage(
                        Assets.icons.password,
                      ).withPadding(all: 19.r),
                    ),
                  ),
                  20.hSpace,

                  // Confirm Password input field
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 1050),
                    child: AppField(
                      controller: cubit.confirmPasswordController,
                      hintText: LocaleKeys.confirmPassword.tr(),
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: CustomImage(
                        Assets.icons.password,
                      ).withPadding(all: 19.r),
                    ),
                  ),
                  20.hSpace,
                  // SignUp Button
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 1200),
                    child: BlocConsumer<SignUpCubit, SignUpState>(
                      bloc: cubit,
                      listener: (context, state) {
                        if (state.state.isDone) {
                          push(
                            NamedRoutes.verify,
                            arg: {
                              'verifyType': VerifyType.register,
                              "phone": cubit.phoneController.text,
                            },
                          );
                        }
                      },
                      builder: (context, state) {
                        return CustomButton(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Text(
                            LocaleKeys.register.tr(),
                            style: context.boldText.copyWith(
                              fontSize: 15.sp,
                              color: context.primaryColorLight,
                            ),
                          ),
                          onTap: () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.signUp();
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
                    delay: const Duration(milliseconds: 1350),
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
                        // 4.horizontalSpace,
                        TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
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
      ),
    );
  }
}
