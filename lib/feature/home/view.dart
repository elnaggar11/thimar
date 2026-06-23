import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/core/widgets/loading.dart';
import 'package:thimar/feature/home/cubit/home_cubit.dart';
import 'package:thimar/feature/home/cubit/home_state.dart';
import 'package:thimar/feature/home/widgets/category_item.dart';
import 'package:thimar/feature/home/widgets/home_app_bar.dart';
import 'package:thimar/feature/home/widgets/home_banner.dart';
import 'package:thimar/feature/home/widgets/home_search_bar.dart';
import 'package:thimar/feature/home/widgets/product_item.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final _cubit = sl<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.state.isLoading && state.categories.isEmpty) {
              return const Center(child: CustomProgress());
            }

            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: FadeInDown(
                      duration: const Duration(milliseconds: 400),
                      child: HomeSearchBar(controller: _cubit.searchController),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                  SliverToBoxAdapter(
                    child: FadeIn(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 150),
                      child: const HomeBanner(),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: FadeIn(
                            duration: const Duration(milliseconds: 400),
                            delay: const Duration(milliseconds: 200),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocaleKeys.categories.tr(),
                                  style: context.boldText.copyWith(
                                    fontSize: 16.sp,
                                  ),
                                ),
                                Text(
                                  LocaleKeys.viewAll.tr(),
                                  style: context.regularText.copyWith(
                                    fontSize: 14.sp,
                                    color: context.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          height: 120.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.categories.length,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            itemBuilder: (context, index) {
                              final category = state.categories[index];
                              final isSelected =
                                  state.selectedCategoryId ==
                                  int.parse(category.id);
                              return FadeInUp(
                                duration: const Duration(milliseconds: 450),
                                delay: Duration(milliseconds: 50 * index),
                                child: CategoryItem(
                                  category: category,
                                  isSelected: isSelected,
                                  onTap: () {
                                    if (isSelected) {
                                      _cubit.getHomeData(); // Deselect
                                    } else {
                                      _cubit.getProductsByCategory(
                                        int.parse(category.id),
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                  if (state.state.isLoading)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: const Center(child: CustomProgress()),
                      ),
                    )
                  else if (state.products.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 32.h),
                        child: Center(
                          child: Column(
                            children: [
                              Pulse(
                                child: CustomImage(Assets.icons.thimarLogo),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                LocaleKeys
                                    .there_are_no_items_to_display_in_this_section
                                    .tr(),
                                style: context.mediumText.copyWith(
                                  color: context.primaryColor,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: FadeInUp(
                              duration: const Duration(milliseconds: 400),
                              delay: const Duration(milliseconds: 250),
                              child: Text(
                                LocaleKeys.products.tr(),
                                style: context.boldText.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            itemCount: state.products.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: 12.w,
                                  mainAxisSpacing: 12.h,
                                ),
                            itemBuilder: (context, index) {
                              final product = state.products[index];
                              final delayIndex = index > 8 ? 8 : index;
                              return FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: Duration(milliseconds: 50 * delayIndex),
                                child: ProductItem(
                                  product: product,
                                  isdetails: false,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: state.state.isLoading ? SizedBox(height: 250) : null,
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 32.h)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
