import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/models/order_model.dart';

class ProductRateItem extends StatefulWidget {
  final OrderProductModel product;
  final ValueChanged<double> onRatingChanged;
  final ValueChanged<String> onCommentChanged;

  const ProductRateItem({
    super.key,
    required this.product,
    required this.onRatingChanged,
    required this.onCommentChanged,
  });

  @override
  State<ProductRateItem> createState() => _ProductRateItemState();
}

class _ProductRateItemState extends State<ProductRateItem> {
  int _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
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
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CustomImage(
                  widget.product.url,
                  width: 70.r,
                  height: 70.r,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: context.boldText.copyWith(
                        color: context.primaryColor,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'السعر / 1كجم', // Can be dynamic if API provides unit
                      style: context.regularText.copyWith(
                        color: context.hintColor,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${widget.product.price} ر.س',
                      style: context.boldText.copyWith(
                        color: context.primaryColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentRating = index + 1;
                  });
                  widget.onRatingChanged(_currentRating.toDouble());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Icon(
                    index < _currentRating ? Icons.star : Icons.star_border,
                    color: Colors.orange,
                    size: 32.r,
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 16.h),
          TextFormField(
            onChanged: widget.onCommentChanged,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'أضف تعليق',
              hintStyle: context.regularText.copyWith(
                color: context.hintColor,
                fontSize: 12.sp,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: context.hintColor.withValues(alpha: 0.2)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: context.hintColor.withValues(alpha: 0.2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: context.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
