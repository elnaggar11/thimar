import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/gen/locale_keys.g.dart';
import 'package:thimar/models/product_model.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/feature/favorites/cubit/favorites_cubit.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.product, this.isdetails = true});
  final ProductModel product;
  final bool isdetails;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.product.isFavorite;
  }

  void _toggleFavorite() async {
    // Optimistic local update
    setState(() {
      isFavorite = !isFavorite;
      widget.product.isFavorite = isFavorite;
    });

    // Call the Cubit which handles the API request
    final success = await sl<FavoritesCubit>().toggleFavorite(
      product: widget.product,
    );

    if (!success) {
      // Revert if API failed
      setState(() {
        isFavorite = !isFavorite;
        widget.product.isFavorite = isFavorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        push(NamedRoutes.productDetails, arg: {'product': widget.product});
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CustomImage(
                        widget.product.banner,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: context.boldText.copyWith(
                          fontSize: 14.sp,
                          color: context.primaryColor,
                        ),
                      ),
                      Text(
                        LocaleKeys.pricePerKg.tr(),
                        style: context.regularText.copyWith(
                          fontSize: 12.sp,
                          color: context.hintColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${widget.product.priceAfterDiscount}',
                                style: context.boldText.copyWith(
                                  fontSize: 14.sp,
                                  color: context.primaryColor,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                LocaleKeys.sar.tr(),
                                style: context.boldText.copyWith(
                                  fontSize: 12.sp,
                                  color: context.primaryColor,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${widget.product.price} ${LocaleKeys.sar.tr()}',
                                style: context.regularText.copyWith(
                                  fontSize: 10.sp,
                                  color: context.hintColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                              color: Color(0xFF61B80C),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                if (!widget.isdetails)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: CustomButton(
                      backgroundColor: Color(0xFF61B80C),
                      height: 35.h,
                      title: LocaleKeys.addToCart.tr(),
                      onTap: () {},
                      textColor: Colors.white,
                      fontSize: 12.sp,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                SizedBox(height: 8.h),
              ],
            ),
            Positioned.directional(
              textDirection: ui.TextDirection.ltr,
              top: 0,
              start: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: context.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
                  ),
                ),
                child: Text(
                  "-${widget.product.discount.toInt()}%",
                  style: context.boldText.copyWith(
                    color: Colors.white,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
            Positioned.directional(
              textDirection: Directionality.of(context),
              top: 8.h,
              start: 8.w,
              child: GestureDetector(
                onTap: _toggleFavorite,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: context.primaryColor.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
