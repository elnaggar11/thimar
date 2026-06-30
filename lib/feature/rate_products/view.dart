import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/core/widgets/flash_helper.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/models/order_model.dart';
import 'cubit/rate_products_cubit.dart';
import 'cubit/rate_products_state.dart';
import 'widgets/product_rate_item.dart';

class RateProductsView extends StatefulWidget {
  final List<OrderProductModel> products;
  const RateProductsView({super.key, required this.products});

  @override
  State<RateProductsView> createState() => _RateProductsViewState();
}

class _RateProductsViewState extends State<RateProductsView> {
  final Map<String, double> _ratings = {};
  final Map<String, String> _comments = {};

  void _submitRatings() {
    List<Map<String, dynamic>> payload = widget.products.map((p) {
      return {
        'product_id': p.id,
        'rating': _ratings[p.id] ?? 0.0,
        'comment': _comments[p.id] ?? '',
      };
    }).toList();

    sl<RateProductsCubit>().submitRatings(payload);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RateProductsCubit>(),
      child: Scaffold(
        appBar: const MainAppBar(
          title: 'تقييم المنتجات',
          removeLeading: false,
          isTitleCentered: true,
        ),
        body: BlocListener<RateProductsCubit, RateProductsState>(
          listenWhen: (previous, current) => previous.submitRatingState != current.submitRatingState,
          listener: (context, state) {
            if (state.submitRatingState == RequestState.done) {
              FlashHelper.showToast('تم إرسال التقييم بنجاح', type: MessageType.success);
              Navigator.pop(context);
            } else if (state.submitRatingState == RequestState.error) {
              FlashHelper.showToast(state.message, type: MessageType.fail);
            }
          },
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(16.r),
                  itemCount: widget.products.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final product = widget.products[index];
                    return ProductRateItem(
                      product: product,
                      onRatingChanged: (rating) {
                        _ratings[product.id] = rating;
                      },
                      onCommentChanged: (comment) {
                        _comments[product.id] = comment;
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: BlocBuilder<RateProductsCubit, RateProductsState>(
                  builder: (context, state) {
                    return CustomButton(
                      title: 'تقييم',
                      isLoading: state.submitRatingState == RequestState.loading,
                      onTap: _submitRatings,
                      backgroundColor: context.primaryColor,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
