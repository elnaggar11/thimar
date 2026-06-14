import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/gen/locale_keys.g.dart';
import 'package:thimar/models/product_model.dart';

class ProductCode extends StatelessWidget {
  final ProductModel product;

  const ProductCode({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          LocaleKeys.productCode.tr(),
          style: context.boldText.copyWith(
            fontSize: 14.sp,
            color: context.primaryColor,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          product.id.toString(),
          style: context.regularText.copyWith(
            fontSize: 14.sp,
            color: context.hintColor,
          ),
        ),
      ],
    );
  }
}
