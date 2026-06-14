import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/models/product_model.dart';

class ProductHeaderImage extends StatelessWidget {
  final ProductModel product;

  const ProductHeaderImage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.r),
              bottomRight: Radius.circular(40.r),
            ),
            child: CarouselSlider(
              items: List.generate(
                3,
                (index) => CustomImage(
                  product.banner,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
              ),
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircularButton(
                  context: context,
                  icon: Icons.arrow_forward_ios,
                  onTap: () => Navigator.pop(context),
                  iconSize: 18.sp,
                ),
                _buildCircularButton(
                  context: context,
                  icon: Icons.favorite_border,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == 2
                      ? Colors.black
                      : Colors.black.withValues(alpha: 0.5),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildCircularButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onTap,
    double? iconSize,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: const Color(0xFF61B80C).withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Transform.flip(
          flipX: true,
          child: Icon(
            icon,
            color: const Color(0xFF61B80C),
            size: iconSize ?? 24.sp,
          ),
        ),
      ),
    );
  }
}
