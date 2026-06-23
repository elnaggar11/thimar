import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/feature/cart/cubit/cart_cubit.dart';
import 'package:thimar/feature/product_details/cubit/product_details_cubit.dart';
import 'package:thimar/feature/product_details/cubit/product_details_state.dart';
import 'package:thimar/feature/product_details/widgets/product_code.dart';
import 'package:thimar/feature/product_details/widgets/product_details_section.dart';
import 'package:thimar/feature/product_details/widgets/product_header_image.dart';
import 'package:thimar/feature/product_details/widgets/product_reviews.dart';
import 'package:thimar/feature/product_details/widgets/product_title_and_price.dart';
import 'package:thimar/feature/product_details/widgets/similar_products.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';
import 'package:thimar/models/product_model.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsView({super.key, required this.product});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  late final _cubit = sl<ProductDetailsCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.init(widget.product);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        bloc: _cubit,
        builder: (context, state) {
          return FadeInUp(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 600),
            child: InkWell(
              onTap: () {
                sl<CartCubit>().addToCart(
                  productId: widget.product.id,
                  amount: state.quantity,
                );
              },
              child: Container(
                height: 60.h,
                margin: EdgeInsets.all(16.r),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: context.primaryColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CustomImage(
                              Assets.icons.shoppingCart,
                              height: 24.h,
                              width: 24.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          LocaleKeys.addToCart.tr(),
                          style: context.boldText.copyWith(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${(state.product?.priceAfterDiscount ?? 0) * state.quantity} ${LocaleKeys.sar.tr()}',
                      style: context.boldText.copyWith(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        bloc: _cubit,
        builder: (context, state) {
          final product = state.product;
          if (product == null) return const SizedBox.shrink();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: ProductHeaderImage(product: product),
                ),
                Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        duration: const Duration(milliseconds: 450),
                        delay: const Duration(milliseconds: 100),
                        child: ProductTitleAndPrice(
                          product: product,
                          quantity: state.quantity,
                          onIncrement: _cubit.incrementQuantity,
                          onDecrement: _cubit.decrementQuantity,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      FadeInUp(
                        duration: const Duration(milliseconds: 450),
                        delay: const Duration(milliseconds: 200),
                        child: ProductCode(product: product),
                      ),
                      SizedBox(height: 16.h),
                      FadeInUp(
                        duration: const Duration(milliseconds: 450),
                        delay: const Duration(milliseconds: 300),
                        child: ProductDetailsSection(product: product),
                      ),
                      SizedBox(height: 16.h),
                      FadeInUp(
                        duration: const Duration(milliseconds: 450),
                        delay: const Duration(milliseconds: 400),
                        child: ProductReviews(reviews: state.reviews),
                      ),
                      SizedBox(height: 16.h),
                      FadeInUp(
                        duration: const Duration(milliseconds: 450),
                        delay: const Duration(milliseconds: 500),
                        child: SimilarProducts(product: product),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
