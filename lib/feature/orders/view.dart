import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/loading.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/feature/orders/cubit/orders_cubit.dart';
import 'package:thimar/feature/orders/widgets/order_item.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final _cubit = sl<OrdersCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.getCurrentOrders();
    _cubit.getFinishedOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: MainAppBar(
            title: LocaleKeys.myBookings.tr(),
            removeLeading: true,
            isTitleCentered: true,
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  height: 55.h,
                  decoration: BoxDecoration(
                    color: context.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: context.borderColor),
                  ),
                  padding: EdgeInsets.all(4.r),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: context.primaryColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: context.hintColor,
                    labelStyle: context.boldText.copyWith(fontSize: 14.sp),
                    unselectedLabelStyle: context.regularText.copyWith(
                      fontSize: 14.sp,
                    ),
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(text: LocaleKeys.currentOrders.tr()),
                      Tab(text: LocaleKeys.finishedOrders.tr()),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildCurrentOrdersList(),
                    _buildFinishedOrdersList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentOrdersList() {
    return BlocBuilder<OrdersCubit, OrdersState>(
      buildWhen: (previous, current) =>
          previous.currentOrdersState != current.currentOrdersState,
      builder: (context, state) {
        if (state.currentOrdersState == RequestState.loading) {
          return const Center(child: CustomProgress());
        }
        if (state.currentOrdersState == RequestState.error) {
          return Center(child: Text(state.message));
        }
        if (state.currentOrders.isEmpty) {
          return const Center(child: Text("لا توجد طلبات حالية"));
        }
        return ListView.separated(
          itemCount: state.currentOrders.length,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder: (context, index) =>
              OrderItemWidget(model: state.currentOrders[index]),
        );
      },
    );
  }

  Widget _buildFinishedOrdersList() {
    return BlocBuilder<OrdersCubit, OrdersState>(
      buildWhen: (previous, current) =>
          previous.finishedOrdersState != current.finishedOrdersState,
      builder: (context, state) {
        if (state.finishedOrdersState == RequestState.loading) {
          return const Center(child: CustomProgress());
        }
        if (state.finishedOrdersState == RequestState.error) {
          return Center(child: Text(state.message));
        }
        if (state.finishedOrders.isEmpty) {
          return const Center(child: Text("لا توجد طلبات منتهية"));
        }
        return ListView.separated(
          itemCount: state.finishedOrders.length,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder: (context, index) =>
              OrderItemWidget(model: state.finishedOrders[index]),
        );
      },
    );
  }
}
