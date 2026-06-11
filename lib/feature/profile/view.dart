import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/feature/profile/cubit/profile_cubit.dart';
import 'package:thimar/feature/profile/widgets/profile_header.dart';
import 'package:thimar/feature/profile/widgets/profile_item.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileCubit>(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const ProfileHeader(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ProfileItem(
                            title: LocaleKeys.personalInfo.tr(),
                            iconPath: Assets.icons.duotoneUser, // from dir list
                            onTap: () {},
                          ),
                          ProfileItem(
                            title: LocaleKeys.wallet.tr(),
                            iconPath: Assets.icons.wallet,
                            onTap: () {},
                          ),
                          ProfileItem(
                            title: LocaleKeys.addresses.tr(),
                            iconPath: Assets.icons.location,
                            onTap: () {},
                          ),
                          ProfileItem(
                            title: LocaleKeys.payment.tr(),
                            iconPath: Assets.icons.note,
                            onTap: () {},
                          ),
                          20.verticalSpace,
                          ProfileItem(
                            title: LocaleKeys.faqs.tr(),
                            iconPath: Assets.icons.question,
                            onTap: () {},
                          ),
                          ProfileItem(
                            title: LocaleKeys.privacyPolicy.tr(),
                            iconPath: Assets.icons.shield,
                            onTap: () {},
                          ),
                          ProfileItem(
                            title: LocaleKeys.contactUs.tr(),
                            iconPath: Assets.icons.call,
                            onTap: () {},
                          ),
                          ProfileItem(
                            title: LocaleKeys.complaintsAndSuggestions.tr(),
                            iconPath: Assets.icons.edit,
                            onTap: () {},
                          ),
                          ProfileItem(
                            title: LocaleKeys.shareApp.tr(),
                            iconPath: Assets.icons.info,
                            onTap: () {},
                          ),
                          20.verticalSpace,
                          ProfileItem(
                            title: LocaleKeys.aboutApp.tr(),
                            iconPath: Assets.icons.info2,
                            onTap: () {},
                          ),
                          ProfileItem(
                            title: LocaleKeys.changeLanguage.tr(),
                            iconPath: Assets.icons.language,
                            onTap: () {},
                          ),
                          ProfileItem(
                            title: LocaleKeys.termsAndConditions.tr(),
                            iconPath: Assets.icons.note2,
                            onTap: () {},
                          ),
                          ProfileItem(
                            title: LocaleKeys.rateApp.tr(),
                            iconPath: Assets.icons.star,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ProfileItem(
                        title: LocaleKeys.logout.tr(),
                        iconPath: Assets.icons.turnOff,
                        hasTrailing: true,
                        onTap: () {},
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
