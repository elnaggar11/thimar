import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/gen/locale_keys.g.dart';
import 'package:thimar/models/product_model.dart';

class ProductDetailsSection extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.productDetails.tr(),
          style: context.boldText.copyWith(
            fontSize: 16.sp,
            color: context.primaryColor,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          product.description,
          style: context.regularText.copyWith(
            fontSize: 14.sp,
            color: context.hintColor,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
