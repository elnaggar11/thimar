import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';

class OrderSectionTitle extends StatelessWidget {
  final String title;

  const OrderSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.boldText.copyWith(
        color: context.primaryColor,
        fontSize: 16.sp,
      ),
    );
  }
}
