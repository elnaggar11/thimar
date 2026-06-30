import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/core/widgets/app_field.dart';
import 'package:thimar/core/widgets/flash_helper.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:thimar/feature/orders/cubit/orders_cubit.dart';
import 'package:thimar/feature/checkout/widgets/saved_cards_bottom_sheet.dart';
import 'package:thimar/feature/checkout/widgets/checkout_widgets.dart';
import 'package:thimar/feature/addresses/cubit/addresses_cubit.dart';
import 'package:thimar/models/address_model.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String _payType = 'cash';
  final TextEditingController _noteController = TextEditingController();
  String? _selectedDate;
  String? _selectedTime;

  AddressModel? _selectedAddress;
  final _addressesCubit = sl<AddressesCubit>();
  final _ordersCubit = sl<OrdersCubit>();

  @override
  void initState() {
    super.initState();
    _addressesCubit.getAddresses();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submitOrder() {
    if (_selectedAddress == null) {
      FlashHelper.showToast(
        LocaleKeys.chooseDeliveryAddress.tr(),
        type: MessageType.fail,
      );
      return;
    }
    if (_selectedDate == null || _selectedTime == null) {
      FlashHelper.showToast(
        LocaleKeys.pleaseSelectDateAndTime.tr(),
        type: MessageType.fail,
      );
      return;
    }

    if (_payType != 'cash') {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => SavedCardsBottomSheet(
          onConfirm: () {
            Navigator.pop(context);
            _executeOrder();
          },
        ),
      );
    } else {
      _executeOrder();
    }
  }

  void _executeOrder() {
    _ordersCubit.storeOrder(
      addressId: int.parse(_selectedAddress!.id),
      date: _selectedDate!,
      time: _selectedTime!,
      payType: _payType,
      note: _noteController.text,
    );
  }

  void _showAddressesBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) => AddressesBottomSheet(
        addressesCubit: _addressesCubit,
        onAddressSelected: (address) {
          setState(() {
            _selectedAddress = address;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersCubit, OrdersState>(
      bloc: _ordersCubit,
      listenWhen: (previous, current) =>
          previous.storeOrderState != current.storeOrderState,
      listener: (context, state) {
        if (state.storeOrderState == RequestState.done) {
          FlashHelper.showToast(
            LocaleKeys.orderSentSuccessfully.tr(),
            type: MessageType.success,
          );
          Navigator.pop(context);
        } else if (state.storeOrderState == RequestState.error) {
          FlashHelper.showToast(state.message, type: MessageType.fail);
        }
      },
      child: Scaffold(
        appBar: MainAppBar(
          title: LocaleKeys.checkout.tr(),
          removeLeading: false,
          isTitleCentered: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CheckoutUserInfo(),
              SizedBox(height: 24.h),
              SectionTitle(
                title: LocaleKeys.chooseDeliveryAddress.tr(),
                onAdd: () {
                  push(NamedRoutes.addAddress).then((value) {
                    if (value == true) {
                      _addressesCubit.getAddresses();
                    }
                  });
                },
              ),
              SizedBox(height: 12.h),
              CheckoutAddressSelector(
                address: _selectedAddress,
                onTap: _showAddressesBottomSheet,
              ),
              SizedBox(height: 24.h),
              SectionTitle(title: LocaleKeys.selectDeliveryTime.tr()),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: CheckoutDateSelector(
                      selectedDate: _selectedDate,
                      onDateSelected: (date) =>
                          setState(() => _selectedDate = date),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CheckoutTimeSelector(
                      selectedTime: _selectedTime,
                      onTimeSelected: (time) =>
                          setState(() => _selectedTime = time),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              SectionTitle(title: LocaleKeys.notesAndInstructions.tr()),
              SizedBox(height: 12.h),
              AppField(
                controller: _noteController,
                hintText: LocaleKeys.notesAndInstructions.tr(),
                maxLines: 4,
              ),
              SizedBox(height: 24.h),
              SectionTitle(title: LocaleKeys.choosePaymentMethod.tr()),
              SizedBox(height: 12.h),
              CheckoutPaymentMethods(
                payType: _payType,
                onChanged: (type) => setState(() => _payType = type),
              ),
              SizedBox(height: 24.h),
              SectionTitle(title: LocaleKeys.orderSummary.tr()),
              SizedBox(height: 12.h),
              const CheckoutOrderSummary(),
              SizedBox(height: 24.h),
              BlocBuilder<OrdersCubit, OrdersState>(
                bloc: _ordersCubit,
                builder: (context, state) {
                  return CustomButton(
                    title: LocaleKeys.finishOrder.tr(),
                    isLoading: state.storeOrderState == RequestState.loading,
                    onTap: _submitOrder,
                    backgroundColor: context.primaryColor,
                    textColor: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  );
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
