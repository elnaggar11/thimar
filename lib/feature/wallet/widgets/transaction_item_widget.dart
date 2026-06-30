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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon on the far right (first child in RTL)
          Container(
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: isRecharge ? context.primaryColor : Colors.red,
                width: 1.5,
              ),
            ),
            child: Icon(
              isRecharge ? Icons.call_received_rounded : Icons.arrow_outward_rounded,
              color: isRecharge ? context.primaryColor : Colors.red,
              size: 16.sp,
            ),
          ),
          SizedBox(width: 8.w),
          // Content column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isRecharge ? LocaleKeys.chargeWalletActivity.tr() : LocaleKeys.paidForThisOrder.tr(),
                      style: context.boldText.copyWith(
                        fontSize: 14.sp,
                        color: context.primaryColor,
                      ),
                    ),
                    Text(
                      transaction.createdAtFormat,
                      style: context.regularText.copyWith(
                        fontSize: 12.sp,
                        color: context.hintColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                if (isRecharge)
                  Text(
                    '${transaction.amount} ر.س',
                    style: context.boldText.copyWith(
                      fontSize: 20.sp,
                      color: context.primaryColor,
                    ),
                  ),
                if (!isRecharge)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${LocaleKeys.orderNum.tr()} ${transaction.id}', // or transaction.meta['order_id']
                            style: context.boldText.copyWith(
                              fontSize: 12.sp,
                              color: context.primaryColor,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: context.primaryColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  '+2',
                                  style: context.boldText.copyWith(
                                    color: context.primaryColor,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              _buildProductImage(),
                              SizedBox(width: 4.w),
                              _buildProductImage(),
                              SizedBox(width: 4.w),
                              _buildProductImage(),
                            ],
                          ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 24.w,
      height: 24.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.r),
        child: Image.asset(
          'assets/images/Rectangle 3499.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
