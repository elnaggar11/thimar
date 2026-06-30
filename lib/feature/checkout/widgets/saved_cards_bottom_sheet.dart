import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class SavedCardsBottomSheet extends StatelessWidget {
  final VoidCallback onConfirm;
  const SavedCardsBottomSheet({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 8.h),
          Text(
            LocaleKeys.savedCards.tr(),
            style: context.boldText.copyWith(
              fontSize: 16.sp,
              color: context.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          SizedBox(
            height: 120.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCard(
                  context,
                  color: const Color(0xFF5A9D23),
                  isVisa: false,
                  cardNumber: '**** **** **** 0000',
                  expiry: '04/22',
                ),
                SizedBox(width: 16.w),
                _buildCard(
                  context,
                  color: Colors.black,
                  isVisa: true,
                  name: 'Mohamed ali',
                  cardNumber: '0197 **** **** ****',
                  expiry: '04/22',
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () {
              push(NamedRoutes.cards);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  LocaleKeys.addPaymentCard.tr(),
                  style: context.boldText.copyWith(
                    fontSize: 14.sp,
                    color: context.primaryColor,
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: context.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.add,
                    color: context.primaryColor,
                    size: 16.r,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          CustomButton(
            title: LocaleKeys.confirmSelection.tr(),
            onTap: onConfirm,
            backgroundColor: context.primaryColor,
            textColor: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required Color color,
    required bool isVisa,
    String? name,
    required String cardNumber,
    required String expiry,
  }) {
    return Container(
      width: 180.w,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isVisa)
                Text(
                  'VISA',
                  style: context.boldText.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontStyle: FontStyle.italic,
                  ),
                )
              else
                const SizedBox.shrink(),
              Icon(Icons.radio_button_checked, color: Colors.white, size: 16.r),
            ],
          ),
          if (name != null)
            Text(
              name,
              style: context.regularText.copyWith(
                color: Colors.white,
                fontSize: 10.sp,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                cardNumber,
                style: context.boldText.copyWith(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
              ),
              Text(
                expiry,
                style: context.regularText.copyWith(
                  color: Colors.white,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
