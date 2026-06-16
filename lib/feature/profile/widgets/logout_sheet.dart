import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/feature/profile/cubit/profile_cubit.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class LogoutSheet extends StatelessWidget {
  const LogoutSheet({super.key, required this.cubit});
  final ProfileCubit cubit;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      bloc: cubit,
      listener: (context, state) {
        if (state.logoutState == RequestState.done) {
          pushAndRemoveUntil(NamedRoutes.login);
        }
      },
      child: Container(
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 5.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: context.hintColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            24.verticalSpace,
            Text(
              LocaleKeys.logout.tr(),
              style: context.boldText.copyWith(
                fontSize: 18.sp,
                color: context.primaryColor,
              ),
            ),
            16.verticalSpace,
            Text(
              LocaleKeys.areYouSureYouWantToLogout.tr(),
              textAlign: TextAlign.center,
              style: context.regularText.copyWith(
                fontSize: 14.sp,
                color: context.hintColor,
              ),
            ),
            32.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    backgroundColor: Colors.white,
                    textColor: context.primaryColor,
                    borderColor: context.primaryColor,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: LocaleKeys.cancel.tr(),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return CustomButton(
                        isLoading: state.logoutState == RequestState.loading,
                        onTap: () {
                          context.read<ProfileCubit>().logout();
                        },
                        title: LocaleKeys.yesLogout.tr(),
                      );
                    },
                  ),
                ),
              ],
            ),
            (MediaQuery.of(context).padding.bottom + 16).verticalSpace,
          ],
        ),
      ),
    );
  }
}
