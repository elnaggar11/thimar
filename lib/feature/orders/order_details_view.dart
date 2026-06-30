import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/core/widgets/flash_helper.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/feature/orders/cubit/orders_cubit.dart';
import 'package:thimar/feature/orders/widgets/order_address_card.dart';
import 'package:thimar/feature/orders/widgets/order_details_card.dart';
import 'package:thimar/feature/orders/widgets/order_section_title.dart';
import 'package:thimar/feature/orders/widgets/order_summary_card.dart';
import 'package:thimar/feature/orders/widgets/cancel_order_button.dart';

class OrderDetailsView extends StatefulWidget {
  final int orderId;
  const OrderDetailsView({super.key, required this.orderId});

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  final _ordersCubit = sl<OrdersCubit>();

  @override
  void initState() {
    super.initState();
    _ordersCubit.getOrderDetails(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        title: 'تفاصيل الطلب',
        removeLeading: false,
        isTitleCentered: true,
      ),
      body: BlocListener<OrdersCubit, OrdersState>(
        bloc: _ordersCubit,
        listenWhen: (previous, current) =>
            previous.cancelOrderState != current.cancelOrderState,
        listener: (context, state) {
          if (state.cancelOrderState == RequestState.done) {
            FlashHelper.showToast(
              'تم إلغاء الطلب بنجاح',
              type: MessageType.success,
            );
            Navigator.pop(context);
          } else if (state.cancelOrderState == RequestState.error) {
            FlashHelper.showToast(state.message, type: MessageType.fail);
          }
        },
        child: BlocBuilder<OrdersCubit, OrdersState>(
          bloc: _ordersCubit,
          builder: (context, state) {
            if (state.orderDetailsState == RequestState.loading ||
                state.orderDetails == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.orderDetailsState == RequestState.error) {
              return Center(child: Text(state.message));
            }

            final order = state.orderDetails!;

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OrderDetailsCard(order: order),
                  SizedBox(height: 24.h),
                  const OrderSectionTitle(title: 'عنوان التوصيل'),
                  SizedBox(height: 12.h),
                  OrderAddressCard(order: order),
                  SizedBox(height: 24.h),
                  const OrderSectionTitle(title: 'ملخص الطلب'),
                  SizedBox(height: 12.h),
                  OrderSummaryCard(order: order),
                  SizedBox(height: 32.h),
                  if (order.status == 'finished' ||
                      order.status == 'مكتمل' ||
                      order.status == 'مغلق')
                    CustomButton(
                      title: 'تقييم المنتجات',
                      onTap: () {
                        push(
                          NamedRoutes.rateProducts,
                          arg: {'products': order.products},
                        );
                      },
                      backgroundColor: context.primaryColor,
                    )
                  else if (order.status == 'pending' ||
                      order.status == 'بإنتظار الموافقة' ||
                      order.status == 'قيد التنفيذ')
                    CancelOrderButton(orderId: widget.orderId, state: state),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
