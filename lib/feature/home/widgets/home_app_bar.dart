import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/feature/cart/cubit/cart_cubit.dart';
import 'package:thimar/feature/cart/cubit/cart_state.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final cubit = sl<CartCubit>();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leadingWidth: 70.w,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImage(
                Assets
                    .icons
                    .thimarLogo, // Assuming we use splashLogo or thimarLogo
                width: 25.w,
                height: 25.w,
              ),
              SizedBox(width: 4.w),
              Text(
                "سلة ثمار",
                style: context.boldText.copyWith(
                  fontSize: 14.sp,
                  color: context.primaryColor,
                ),
              ),
            ],
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.deliveryTo.tr(),
                  style: context.boldText.copyWith(
                    fontSize: 12.sp,
                    color: context.primaryColor,
                  ),
                ),
                Text(
                  "شارع الملك فهد - جدة",
                  style: context.regularText.copyWith(
                    fontSize: 14.sp,
                    color: context.primaryColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {
            push(NamedRoutes.cart);
          },
          child: BlocBuilder<CartCubit, CartState>(
            bloc: cubit,
            builder: (context, state) {
              return Center(
                child: Badge(
                  label: Text(
                    '${state.cartData?.items.length ?? 0}',
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                  ),
                  backgroundColor: context.primaryColor,
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      color: context.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: CustomImage(
                      Assets.icons.bag,
                      width: 20.w,
                      height: 20.w,
                      color: context.primaryColor,
                    ),
                  ),
                ),
              );
            },
          ).withPadding(horizontal: 16.w),
        ),
      ],
    );
  }
}
