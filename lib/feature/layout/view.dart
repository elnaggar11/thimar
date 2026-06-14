import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/feature/home/view.dart';
import 'package:thimar/feature/layout/cubit/layout_cubit.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';
import 'package:thimar/feature/orders/view.dart';
import 'package:thimar/feature/notifications/view.dart';
import 'package:thimar/feature/favorites/view.dart';
import 'package:thimar/feature/profile/view.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<LayoutCubit>();
    return BlocBuilder<LayoutCubit, LayoutState>(
      bloc: cubit,
      builder: (context, state) {
        final List<Widget> screens = [
          const HomeView(),
          const OrdersView(),
          const NotificationsView(),
          const FavoritesView(),
          const ProfileView(),
        ];

        return Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position:
                      Tween<Offset>(
                        begin: const Offset(0.0, 0.05),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        ),
                      ),
                  child: child,
                ),
              );
            },
            child: SizedBox(
              key: ValueKey<int>(state.selectedIndex),
              child: screens[state.selectedIndex],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.selectedIndex,
            onTap: cubit.changeIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: context.primaryColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              _buildNavItem(
                context: context,
                icon: Assets.icons.home,
                label: LocaleKeys.home.tr(),
                isSelected: state.selectedIndex == 0,
                index: 0,
              ),
              _buildNavItem(
                context: context,
                icon: Assets.icons.note,
                label: LocaleKeys.myBookings.tr(),
                isSelected: state.selectedIndex == 1,
                index: 1,
              ),
              _buildNavItem(
                context: context,
                icon: Assets.icons.notification,
                label: LocaleKeys.notifications.tr(),
                isSelected: state.selectedIndex == 2,
                index: 2,
              ),
              _buildNavItem(
                context: context,
                icon: Assets.icons.heartEmpty,
                label: LocaleKeys.favorites.tr(),
                isSelected: state.selectedIndex == 3,
                index: 3,
              ),
              _buildNavItem(
                context: context,
                icon: Assets.icons.user,
                label: LocaleKeys.profile.tr(),
                isSelected: state.selectedIndex == 4,
                index: 4,
              ),
            ],
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required BuildContext context,
    required String icon,
    required String label,
    required bool isSelected,
    required int index,
  }) {
    final delay = Duration(milliseconds: 50 + (index * 50));
    
    return BottomNavigationBarItem(
      icon: FadeIn(
        delay: delay,
        duration: const Duration(milliseconds: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImage(icon, color: Colors.white70, width: 24.w, height: 24.w),
            SizedBox(height: 4.h),
            SizedBox(
              width: 65.w,
              height: 20.h,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: context.regularText.copyWith(
                    fontSize: 11.sp,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      activeIcon: FadeIn(
        delay: delay,
        duration: const Duration(milliseconds: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImage(icon, color: Colors.white, width: 24.w, height: 24.w),
            SizedBox(height: 4.h),
            SizedBox(
              width: 65.w,
              height: 20.h,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: context.boldText.copyWith(
                    fontSize: 11.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      label: '',
    );
  }
}
