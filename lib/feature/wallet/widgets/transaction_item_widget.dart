import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/models/wallet_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class TransactionItemWidget extends StatelessWidget {
  final WalletTransaction transaction;

  const TransactionItemWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    // Determine if it's a recharge or payment
    final isRecharge = transaction.isCredit || transaction.isUp || transaction.type == 'charge';
    
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                transaction.createdAtFormat,
                style: context.regularText.copyWith(
                  fontSize: 12.sp,
                  color: context.hintColor,
                ),
              ),
              Row(
                children: [
                  Text(
                    isRecharge ? LocaleKeys.chargeWalletActivity.tr() : LocaleKeys.paidForThisOrder.tr(),
                    style: context.semiboldText.copyWith(
                      fontSize: 14.sp,
                      color: context.primaryColor,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    isRecharge ? Icons.arrow_outward_rounded : Icons.call_received_rounded,
                    color: isRecharge ? Colors.green : Colors.red,
                    size: 20.sp,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          if (!isRecharge) ...[
            Text(
              '${LocaleKeys.orderNum.tr()}${transaction.id}', // or transaction.meta['order_id'] if available
              style: context.mediumText.copyWith(
                fontSize: 12.sp,
                color: context.hintColor,
              ),
            ),
            SizedBox(height: 8.h),
          ],
          Row(
            mainAxisAlignment: isRecharge ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
            children: [
              if (!isRecharge)
                Row(
                  // Dummy products images based on design
                  children: [
                    _buildProductImage(),
                    _buildProductImage(),
                    _buildProductImage(),
                  ],
                ),
              Text(
                '${transaction.amount} ر.س',
                style: context.boldText.copyWith(
                  fontSize: 18.sp,
                  color: context.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 24.w,
      height: 24.h,
      margin: EdgeInsets.only(right: 4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Icon(Icons.image, size: 12.sp, color: Colors.grey),
    );
  }
}
