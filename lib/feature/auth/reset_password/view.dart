import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/core/widgets/app_field.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/feature/auth/reset_password/cubit/reset_password_cubit.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final cubit = sl<ResetPasswordCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: cubit.formKey,
            child: Column(
              children: [
                CustomImage(Assets.icons.thimarLogo),
                21.hSpace,
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    LocaleKeys.forgetPasswordTitle.tr(),
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
                    LocaleKeys.enterYouNewPasswordMakeSureIt.tr(),
                    style: context.lightText.copyWith(fontSize: 16),
                  ),
                ),
                20.hSpace,
                BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return AppField(
                      hintText: LocaleKeys.newPassword.tr(),
                      controller: cubit.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                    );
                  },
                ),
                20.hSpace,
                BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return AppField(
                      hintText: LocaleKeys.confirmPassword.tr(),
                      controller: cubit.confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                    );
                  },
                ),
                20.hSpace,
                BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                  bloc: cubit,
                  listener: (context, state) {
                    if (state.resetState == RequestState.done) {
                      pushAndRemoveUntil(NamedRoutes.login);
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      borderRadius: BorderRadius.circular(15.r),
                      isLoading: state.resetState == RequestState.loading,
                      child: Text(
                        LocaleKeys.changePassword.tr(),
                        style: context.boldText.copyWith(
                          fontSize: 15.sp,
                          color: context.primaryColorLight,
                        ),
                      ),
                      onTap: () {
                        // Pass phone dynamically from args
                        final phone = context.arg['phone'] as String? ?? '';
                        final code = context.arg['code'] as String? ?? '';
                        cubit.resetPassword(phone, code);
                      },
                    );
                  },
                ),
                45.hSpace,
                Row(
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
              ],
            ).withPadding(horizontal: 16.r),
          ),
        ),
      ),
    );
  }
}
