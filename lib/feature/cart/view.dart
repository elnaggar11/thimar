import 'package:animate_do/animate_do.dart';
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
import 'package:thimar/core/widgets/loading.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/feature/cart/cubit/cart_cubit.dart';
import 'package:thimar/feature/cart/cubit/cart_state.dart';
import 'package:thimar/feature/cart/widgets/cart_item_widget.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final _cubit = sl<CartCubit>();
  final TextEditingController _couponController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: MainAppBar(title: LocaleKeys.cart.tr(), isTitleCentered: true),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state.state == RequestState.loading) {
              return const Center(child: CustomProgress());
            }

            if (state.state == RequestState.error) {
              return Center(
                child: Text(
                  state.message,
                  style: context.boldText.copyWith(color: context.errorColor),
                ),
              );
            }

            if (state.cartData == null || state.cartData!.items.isEmpty) {
              return Center(
                child: Pulse(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImage(
                        Assets.icons.bag,
                        width: 100.w,
                        height: 100.w,
                        color: context.primaryColor,
                      ),

                      SizedBox(height: 20.h),
                      Text(
                        LocaleKeys.there_are_no_items_to_display_in_this_section
                            .tr(),
                        style: context.mediumText.copyWith(
                          fontSize: 14.sp,
                          color: context.primaryColor,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      CustomButton(
                        title: LocaleKeys.searchHome.tr(),
                        fontSize: 12.sp,
                        width: 200.w,
                        backgroundColor: context.primaryColor,
                        textColor: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            final cart = state.cartData!;

            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      itemCount: cart.items.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemBuilder: (context, index) {
                        return CartItemWidget(
                          item: cart.items[index],
                          onAdd: () {
                            _cubit.updateCartItemLocal(
                              cartItemId: cart.items[index].id,
                              amount: cart.items[index].amount + 1,
                            );
                          },
                          onRemove: () {
                            if (cart.items[index].amount > 1) {
                              _cubit.updateCartItemLocal(
                                cartItemId: cart.items[index].id,
                                amount: cart.items[index].amount - 1,
                              );
                            }
                          },
                          onDelete: () {
                            _cubit.deleteCartItem(
                              cartItemId: cart.items[index].id,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  _buildBottomSection(context, cart),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, cart) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: AppField(
                  controller: _couponController,
                  hintText: LocaleKeys.haveCoupon.tr(),
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(width: 12.w),
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return CustomButton(
                    title: LocaleKeys.apply.tr(),
                    width: 90.w,
                    height: 50.h,
                    isLoading: state.applyCouponState == RequestState.loading,
                    backgroundColor: context.primaryColor,
                    textColor: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    fontSize: 14.sp,
                    onTap: () {
                      if (_couponController.text.isNotEmpty) {
                        _cubit.applyCoupon(_couponController.text);
                      }
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Center(
            child: Text(
              LocaleKeys.pricesIncludeVat.tr(),
              style: context.regularText.copyWith(
                fontSize: 12.sp,
                color: context.primaryColor,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: context.primaryColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.productsTotal.tr(),
                      style: context.regularText.copyWith(
                        fontSize: 14.sp,
                        color: context.primaryColor,
                      ),
                    ),
                    Text(
                      '${cart.totalPriceBeforeDiscount} ${LocaleKeys.sar.tr()}',
                      style: context.regularText.copyWith(
                        fontSize: 14.sp,
                        color: context.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.discount.tr(),
                      style: context.regularText.copyWith(
                        fontSize: 14.sp,
                        color: context.primaryColor,
                      ),
                    ),
                    Text(
                      '-${cart.totalDiscount} ${LocaleKeys.sar.tr()}',
                      style: context.regularText.copyWith(
                        fontSize: 14.sp,
                        color: context.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.total.tr(),
                      style: context.boldText.copyWith(
                        fontSize: 14.sp,
                        color: context.primaryColor,
                      ),
                    ),
                    Text(
                      '${cart.totalPriceWithVat} ${LocaleKeys.sar.tr()}',
                      style: context.boldText.copyWith(
                        fontSize: 14.sp,
                        color: context.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          CustomButton(
            title: LocaleKeys.goToCheckout.tr(),
            onTap: () {
              push(NamedRoutes.checkout);
            },
            backgroundColor: context.primaryColor,
            textColor: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ],
      ),
    );
  }
}
