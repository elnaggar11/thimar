import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';

class CardItemWidget extends StatelessWidget {
  final String cardType;
  final String cardHolder;
  final String cardNumber;
  final String expiryDate;
  final Color backgroundColor;

  const CardItemWidget({
    super.key,
    required this.cardType,
    required this.cardHolder,
    required this.cardNumber,
    required this.expiryDate,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (cardType == 'VISA')
                Text(
                  'VISA',
                  style: context.boldText.copyWith(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontStyle: FontStyle.italic,
                  ),
                )
              else
                Row(
                  children: [
                    Container(
                      width: 24.r,
                      height: 24.r,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(-10, 0),
                      child: Container(
                        width: 24.r,
                        height: 24.r,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              Row(
                children: [
                  Icon(
                    Icons.security,
                    color: Colors.white.withValues(alpha: 0.5),
                    size: 16.r,
                  ),
                  4.horizontalSpace,
                  Container(
                    width: 16.r,
                    height: 16.r,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Icon(
                      Icons.check,
                      color: context.primaryColor,
                      size: 12.r,
                    ),
                  ),
                ],
              ),
            ],
          ),
          20.verticalSpace,
          Text(
            cardHolder,
            style: context.boldText.copyWith(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardNumber,
                style: context.boldText.copyWith(
                  color: Colors.white,
                  fontSize: 16.sp,
                  letterSpacing: 2,
                ),
              ),
              Text(
                expiryDate,
                style: context.boldText.copyWith(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
