import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/models/order_model.dart';

class OrderProductStack extends StatelessWidget {
  final OrderModel order;

  const OrderProductStack({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    if (order.products.isEmpty) return const SizedBox.shrink();

    final maxVisible = 3;
    final displayCount = order.products.length > maxVisible ? maxVisible : order.products.length;
    final extraCount = order.products.length - maxVisible;

    List<Widget> children = [];

    if (extraCount > 0) {
      children.add(
        Container(
          width: 30.r,
          height: 30.r,
          decoration: BoxDecoration(
            color: const Color(0xFFE5F1E5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              '+$extraCount',
              style: context.boldText.copyWith(
                color: context.primaryColor,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      );
      children.add(SizedBox(width: 8.w));
    }

    for (int i = 0; i < displayCount; i++) {
      children.add(
        Container(
          margin: EdgeInsets.only(right: i == 0 ? 0 : 8.w),
          width: 30.r,
          height: 30.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: context.hintColor.withValues(alpha: 0.1)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CustomImage(
              order.products[i].url,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children.reversed.toList(),
    );
  }
}
