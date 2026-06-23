import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/gen/locale_keys.g.dart';
import 'package:thimar/models/review_model.dart';

class ProductReviews extends StatelessWidget {
  final List<ReviewModel> reviews;
  const ProductReviews({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.ratings.tr(),
              style: context.boldText.copyWith(
                fontSize: 16.sp,
                color: context.primaryColor,
              ),
            ),
            Text(
              LocaleKeys.viewAll.tr(), // View all
              style: context.regularText.copyWith(
                fontSize: 14.sp,
                color: context.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 90.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return Container(
                width: 280.w,
                margin: EdgeInsets.only(left: 12.w),
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: CustomImage(
                        review.clientImage,
                        width: 40.w,
                        height: 40.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                review.clientName,
                                style: context.boldText.copyWith(
                                  fontSize: 14.sp,
                                  color: context.primaryColor,
                                ),
                              ),
                              Row(
                                children: List.generate(
                                  5,
                                  (starIndex) => Icon(
                                    starIndex < review.value
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.orange,
                                    size: 12.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            review.comment,
                            style: context.regularText.copyWith(
                              fontSize: 12.sp,
                              color: context.hintColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
