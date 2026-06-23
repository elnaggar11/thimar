import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/gen/locale_keys.g.dart';
import 'package:thimar/models/cart_model.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModle item;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Delete icon on the far left (in RTL mode it's at the end)
          GestureDetector(
            onTap: onDelete,
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.delete_outline, color: Colors.red, size: 20.sp),
            ),
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.productName,
                  style: context.boldText.copyWith(
                    fontSize: 14.sp,
                    color: context.primaryColor,
                  ),
                  textAlign: TextAlign.end,
                ),
                SizedBox(height: 4.h),
                Text(
                  '${item.priceAfterDiscount} ${LocaleKeys.sar.tr()}',
                  style: context.boldText.copyWith(
                    fontSize: 14.sp,
                    color: context.primaryColor,
                  ),
                  textAlign: TextAlign.end,
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: context.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: onRemove,
                        child: Icon(
                          Icons.remove,
                          color: context.primaryColor,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        '${item.quantity}',
                        style: context.boldText.copyWith(
                          fontSize: 14.sp,
                          color: context.primaryColor,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      GestureDetector(
                        onTap: onAdd,
                        child: Icon(
                          Icons.add,
                          color: context.primaryColor,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          // Image on the far right (start in RTL)
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CustomImage(
              item.image,
              width: 80.w,
              height: 80.w,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
