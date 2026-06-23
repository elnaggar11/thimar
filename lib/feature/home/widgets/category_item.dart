import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsetsDirectional.only(end: 12.w),
        child: Column(
          children: [
            Container(
              width: 75.w,
              height: 75.w,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: isSelected
                    ? Border.all(color: context.primaryColor, width: 2)
                    : null,
                color: isSelected
                    ? context.primaryColor.withValues(alpha: 0.1)
                    : null,
              ),
              child: CustomImage(category.image),
            ),
            SizedBox(height: 6.h),
            SizedBox(
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.mediumText.copyWith(
                  fontSize: 14.sp,
                  color: isSelected ? context.primaryColor : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
