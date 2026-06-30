import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/models/order_model.dart';
import 'order_summary_row.dart';

class OrderSummaryCard extends StatelessWidget {
  final OrderModel order;

  const OrderSummaryCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBF9),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                OrderSummaryRow(label: 'إجمالي المنتجات', value: '${order.orderPrice} ر.س'),
                SizedBox(height: 12.h),
                OrderSummaryRow(label: 'سعر التوصيل', value: '${order.deliveryPrice} ر.س'),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Divider(color: context.hintColor.withValues(alpha: 0.2)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المجموع',
                      style: context.boldText.copyWith(
                        color: context.primaryColor,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      '${order.totalPrice} ر.س',
                      style: context.boldText.copyWith(
                        color: context.primaryColor,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFFEAEAEA),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'تم الدفع بواسطة',
                  style: context.regularText.copyWith(
                    color: context.primaryColor,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  order.payType.toUpperCase(),
                  style: context.boldText.copyWith(
                    color: Colors.blue.shade900,
                    fontSize: 16.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
