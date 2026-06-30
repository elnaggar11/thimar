import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/feature/orders/cubit/orders_cubit.dart';

class CancelOrderButton extends StatelessWidget {
  final int orderId;
  final OrdersState state;

  const CancelOrderButton({super.key, required this.orderId, required this.state});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: 'إلغاء الطلب',
      isLoading: state.cancelOrderState == RequestState.loading,
      onTap: () {
        sl<OrdersCubit>().cancelOrder(orderId);
      },
      backgroundColor: const Color(0xFFFFEAEA), // Light pink
      textColor: Colors.red,
      borderRadius: BorderRadius.circular(16.r),
    );
  }
}
