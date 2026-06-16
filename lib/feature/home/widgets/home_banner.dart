import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/core/widgets/loading.dart';
import 'package:thimar/feature/home/cubit/home_cubit.dart';
import 'package:thimar/feature/home/cubit/home_state.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final cubit = sl<HomeCubit>();
  @override
  void initState() {
    super.initState();
    cubit.getSliders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: cubit,
      builder: (context, state) {
        if (state.banners.isEmpty) {
          return SizedBox(
            height: 160.h,
            child: const Center(child: LoadingApp()),
          );
        }

        return Stack(
          children: [
            Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 160.h,
                    viewportFraction: 1.0,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      cubit.changeBannerIndex(index);
                    },
                  ),
                  items: state.banners.map((banner) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: CustomImage(banner.image, fit: BoxFit.cover),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            Positioned(
              bottom: 8.h,
              left: 0.w,
              right: 0.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  state.banners.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    width: index == state.currentBannerIndex ? 20.w : 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: state.currentBannerIndex == index
                          ? context.primaryColor
                          : context.primaryColor.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
