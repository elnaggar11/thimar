import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/models/order_model.dart';
import 'order_product_stack.dart';

class OrderDetailsCard extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'طلب #${order.id}',
                style: context.boldText.copyWith(
                  color: context.primaryColor,
                  fontSize: 16.sp,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F1E5), // Light green
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  order.status,
                  style: context.boldText.copyWith(
                    color: context.primaryColor,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            order.date,
            style: context.regularText.copyWith(
              color: context.hintColor,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '${order.totalPrice}',
                    style: context.boldText.copyWith(
                      color: context.primaryColor,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'ر.س',
                    style: context.regularText.copyWith(
                      color: context.primaryColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              OrderProductStack(order: order),
            ],
          ),
        ],
      ),
    );
  }
}
