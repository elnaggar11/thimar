import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/feature/profile/cubit/profile_cubit.dart';
import 'package:thimar/feature/profile/widgets/change_language_sheet.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/feature/profile/widgets/logout_sheet.dart';
import 'package:thimar/feature/profile/widgets/profile_header.dart';
import 'package:thimar/feature/profile/widgets/profile_item.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class _ProfileItemData {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const _ProfileItemData({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final group1 = [
      _ProfileItemData(
        title: LocaleKeys.personalInfo.tr(),
        icon: Assets.icons.duotoneUser,
        onTap: () {
          push(NamedRoutes.personalInfo);
        },
      ),
      _ProfileItemData(
        title: LocaleKeys.wallet.tr(),
        icon: Assets.icons.wallet,
        onTap: () {
          push(NamedRoutes.wallet);
        },
      ),
      _ProfileItemData(
        title: LocaleKeys.addresses.tr(),
        icon: Assets.icons.location,
        onTap: () {
          push(NamedRoutes.addresses);
        },
      ),
      _ProfileItemData(
        title: LocaleKeys.payment.tr(),
        icon: Assets.icons.buy,
        onTap: () {},
      ),
    ];

    final group2 = [
      _ProfileItemData(
        title: LocaleKeys.faqs.tr(),
        icon: Assets.icons.question,
        onTap: () {
          push(NamedRoutes.faqs);
        },
      ),
      _ProfileItemData(
        title: LocaleKeys.privacyPolicy.tr(),
        icon: Assets.icons.shield,
        onTap: () {
          push(NamedRoutes.privacyPolicy);
        },
      ),
      _ProfileItemData(
        title: LocaleKeys.contactUs.tr(),
        icon: Assets.icons.call,
        onTap: () {
          push(NamedRoutes.contactUs);
        },
      ),
      _ProfileItemData(
        title: LocaleKeys.complaintsAndSuggestions.tr(),
        icon: Assets.icons.edit,
        onTap: () {
          push(NamedRoutes.complaintsAndSuggestions);
        },
      ),
      _ProfileItemData(
        title: LocaleKeys.shareApp.tr(),
        icon: Assets.icons.info,
        onTap: () {},
      ),
    ];

    final group3 = [
      _ProfileItemData(
        title: LocaleKeys.aboutApp.tr(),
        icon: Assets.icons.info2,
        onTap: () {
          push(NamedRoutes.aboutUs);
        },
      ),
      _ProfileItemData(
        title: LocaleKeys.changeLanguage.tr(),
        icon: Assets.icons.language,
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const ChangeLanguageSheet(),
          );
        },
      ),
      _ProfileItemData(
        title: LocaleKeys.termsAndConditions.tr(),
        icon: Assets.icons.note2,
        onTap: () {
          push(NamedRoutes.termsAndConditions);
        },
      ),
      _ProfileItemData(
        title: LocaleKeys.rateApp.tr(),
        icon: Assets.icons.star,
        onTap: () {},
      ),
    ];

    int globalIndex = 0;

    Widget buildItem(_ProfileItemData item, int index) {
      return FadeInUp(
        duration: const Duration(milliseconds: 400),
        delay: Duration(milliseconds: 50 * index),
        child: ProfileItem(
          title: item.title,
          iconPath: item.icon,
          onTap: item.onTap,
        ),
      );
    }

    final cubit = sl<ProfileCubit>();

    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const ProfileHeader(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Column(
                  children: [
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: Container(
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
                            ...group1.map(
                              (item) => buildItem(item, globalIndex++),
                            ),
                            20.verticalSpace,
                            ...group2.map(
                              (item) => buildItem(item, globalIndex++),
                            ),
                            20.verticalSpace,
                            ...group3.map(
                              (item) => buildItem(item, globalIndex++),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    FadeInUp(
                      duration: const Duration(milliseconds: 450),
                      delay: Duration(milliseconds: 50 * globalIndex),
                      child: Container(
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
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (sheetContext) => BlocProvider.value(
                                value: cubit,
                                child: LogoutSheet(cubit: cubit),
                              ),
                            );
                          },
                        ),
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
