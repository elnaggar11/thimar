import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/gen/locale_keys.g.dart';
import 'package:thimar/models/product_model.dart';

class ProductTitleAndPrice extends StatelessWidget {
  final ProductModel product;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ProductTitleAndPrice({
    super.key,
    required this.product,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: context.boldText.copyWith(fontSize: 22.sp, color: context.primaryColor),
            ),
            Text(
              LocaleKeys.pricePerKg.tr(),
              style: context.regularText.copyWith(fontSize: 14.sp, color: context.hintColor),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  '${product.priceAfterDiscount} ${LocaleKeys.sar.tr()}',
                  style: context.boldText.copyWith(fontSize: 16.sp, color: context.primaryColor),
                ),
                SizedBox(width: 8.w),
                Text(
                  '${product.price} ${LocaleKeys.sar.tr()}',
                  style: context.regularText.copyWith(
                    fontSize: 14.sp,
                    color: context.hintColor,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  '${product.discount.toInt()}%',
                  style: context.boldText.copyWith(fontSize: 14.sp, color: Colors.red),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFF61B80C).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: onDecrement,
                    child: Icon(Icons.remove, color: const Color(0xFF61B80C), size: 20.sp),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    '$quantity',
                    style: context.boldText.copyWith(fontSize: 16.sp, color: const Color(0xFF61B80C)),
                  ),
                  SizedBox(width: 16.w),
                  InkWell(
                    onTap: onIncrement,
                    child: Icon(Icons.add, color: const Color(0xFF61B80C), size: 20.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
