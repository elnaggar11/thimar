import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/feature/home/widgets/product_item.dart';
import 'package:thimar/gen/locale_keys.g.dart';
import 'package:thimar/models/product_model.dart';

class SimilarProducts extends StatelessWidget {
  final ProductModel product;

  const SimilarProducts({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.similarProducts.tr(),
          style: context.boldText.copyWith(
            fontSize: 16.sp,
            color: context.primaryColor,
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 230.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 160.w,
                margin: EdgeInsets.only(left: 12.w, bottom: 8.h),
                child: ProductItem(
                  product: product,
                ), // Passing the same product as dummy
              );
            },
          ),
        ),
      ],
    );
  }
}
