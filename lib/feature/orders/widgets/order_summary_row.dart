import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';

class OrderSummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const OrderSummaryRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.regularText.copyWith(
            color: context.primaryColor,
            fontSize: 14.sp,
          ),
        ),
        Text(
          value,
          style: context.regularText.copyWith(
            color: context.primaryColor,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
