import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/models/address_model.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/core/widgets/custom_image.dart';

class AddressItemWidget extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const AddressItemWidget({
    super.key,
    required this.address,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.primaryColor, width: 1.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      address.type.isNotEmpty ? address.type : 'العنوان',
                      style: context.boldText.copyWith(
                        fontSize: 16.sp,
                        color: context.primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onEdit,
                          child: Container(
                            padding: EdgeInsets.all(6.r),
                            decoration: BoxDecoration(
                              color: context.primaryColor.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: CustomImage(
                              Assets.icons.edit,
                              width: 16,
                              height: 16,
                              color: context.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: onDelete,
                          child: Container(
                            padding: EdgeInsets.all(6.r),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: CustomImage(
                              Assets.icons.trash,
                              width: 16,
                              height: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'العنوان: ${address.location}',
                  style: context.regularText.copyWith(
                    fontSize: 14.sp,
                    color: context.primaryColor,
                  ),
                ),
                if (address.description.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    address.description,
                    style: context.regularText.copyWith(
                      fontSize: 14.sp,
                      color: context.hintColor,
                    ),
                  ),
                ],
                if (address.phone.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    address.phone,
                    style: context.regularText.copyWith(
                      fontSize: 14.sp,
                      color: context.hintColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
