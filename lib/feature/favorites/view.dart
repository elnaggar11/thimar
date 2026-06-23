import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/loading.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/feature/favorites/cubit/favorites_cubit.dart';
import 'package:thimar/feature/favorites/cubit/favorites_state.dart';
import 'package:thimar/feature/home/widgets/product_item.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final _cubit = sl<FavoritesCubit>();

  @override
  void initState() {
    super.initState();
    // Re-fetch when entering the tab to ensure fresh data
    _cubit.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: LocaleKeys.favorites.tr(), removeLeading: true),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state.state.isLoading) {
            return const Center(child: CustomProgress());
          }

          if (state.state.isError) {
            return Center(
              child: Text(
                state.message,
                style: context.mediumText.copyWith(color: Colors.red),
              ),
            );
          }

          if (state.favorites.isEmpty) {
            return Center(
              child: Text(
                "لا توجد منتجات في المفضلة", // Will rely on translations typically, but added fallback
                style: context.mediumText,
              ),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(16.r),
            itemCount: state.favorites.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
            ),
            itemBuilder: (context, index) {
              final product = state.favorites[index];
              return FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: Duration(milliseconds: 50 * index),
                child: ProductItem(product: product, isdetails: false),
              );
            },
          );
        },
      ),
    );
  }
}
