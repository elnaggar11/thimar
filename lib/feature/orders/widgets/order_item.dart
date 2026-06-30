import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/models/order_model.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderModel model;
  const OrderItemWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: context.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: context.borderColor,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${LocaleKeys.orderNum.tr()}${model.id}',
                    style: context.boldText.copyWith(
                      color: context.primaryColor,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    model.date,
                    style: context.regularText.copyWith(
                      color: context.hintColor,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: model.backgroundColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  model.statusText,
                  style: context.boldText.copyWith(
                    color: model.textColor,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  ...List.generate(
                    model.products.length > 3 ? 3 : model.products.length,
                    (index) => Container(
                      width: 25.w,
                      height: 25.w,
                      margin: EdgeInsetsDirectional.only(end: 4.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: context.borderColor),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CustomImage(
                        model.products[index].url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (model.products.length > 3)
                    Container(
                      width: 25.w,
                      height: 25.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xffEDF5E6),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        "+${model.products.length - 3}",
                        style: context.boldText.copyWith(
                          color: context.primaryColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    model.totalPrice.toString(),
                    style: context.boldText.copyWith(
                      color: context.primaryColor,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    "ر.س",
                    style: context.boldText.copyWith(
                      color: context.primaryColor,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
