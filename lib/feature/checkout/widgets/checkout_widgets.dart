import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/feature/cart/cubit/cart_cubit.dart';
import 'package:thimar/feature/cart/cubit/cart_state.dart';
import 'package:thimar/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:thimar/models/address_model.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/gen/assets.gen.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onAdd;

  const SectionTitle({super.key, required this.title, this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.boldText.copyWith(
            color: context.primaryColor,
            fontSize: 16.sp,
          ),
        ),
        if (onAdd != null)
          GestureDetector(
            onTap: onAdd,
            child: Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                color: context.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.add, color: context.primaryColor, size: 16.r),
            ),
          ),
      ],
    );
  }
}

class CheckoutUserInfo extends StatelessWidget {
  const CheckoutUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'الاسم : محمد',
          style: context.boldText.copyWith(
            color: context.primaryColor,
            fontSize: 16.sp,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          'الجوال : ٠٥٠٦٨٢٨٥٩١٤',
          style: context.boldText.copyWith(
            color: context.primaryColor,
            fontSize: 16.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class CheckoutAddressSelector extends StatelessWidget {
  final AddressModel? address;
  final VoidCallback? onTap;

  const CheckoutAddressSelector({super.key, this.address, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: context.primaryColor.withValues(alpha: 0.5),
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                address != null
                    ? '${address!.type.isNotEmpty ? address!.type : 'العنوان'} : ${address!.location}'
                    : LocaleKeys.chooseDeliveryAddress.tr(),
                style: context.regularText.copyWith(
                  color: context.primaryColor,
                  fontSize: 14.sp,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: context.primaryColor),
          ],
        ),
      ),
    );
  }
}

class CheckoutDateSelector extends StatelessWidget {
  final String? selectedDate;
  final ValueChanged<String> onDateSelected;

  const CheckoutDateSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 30)),
        );
        if (date != null) {
          onDateSelected(
            "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: context.hintColor.withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedDate ?? LocaleKeys.selectDayAndDate.tr(),
              style: context.regularText.copyWith(
                color: selectedDate == null
                    ? context.hintColor
                    : context.primaryColor,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(width: 8.w),
            CustomImage(
              Assets.icons.calendar,
              color: context.primaryColor,
              height: 20.r,
              width: 20.r,
            ),
          ],
        ),
      ),
    );
  }
}

class CheckoutTimeSelector extends StatelessWidget {
  final String? selectedTime;
  final ValueChanged<String> onTimeSelected;

  const CheckoutTimeSelector({
    super.key,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (time != null) {
          onTimeSelected(
            "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}",
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: context.hintColor.withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedTime ?? LocaleKeys.selectTime.tr(),
              style: context.regularText.copyWith(
                color: selectedTime == null
                    ? context.hintColor
                    : context.primaryColor,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.access_time, color: context.primaryColor, size: 20.r),
          ],
        ),
      ),
    );
  }
}

class CheckoutPaymentMethods extends StatelessWidget {
  final String payType;
  final ValueChanged<String> onChanged;

  const CheckoutPaymentMethods({
    super.key,
    required this.payType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PaymentOptionCard(
            type: 'mastercard',
            imageAsset: Assets.icons.masterCard,
            payType: payType,
            onChanged: onChanged,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _PaymentOptionCard(
            type: 'visa',
            imageAsset: Assets.icons.visa,
            payType: payType,
            onChanged: onChanged,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _PaymentOptionTextCard(
            type: 'cash',
            label: LocaleKeys.cash.tr(),
            asset: Assets.icons.money,
            payType: payType,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _PaymentOptionCard extends StatelessWidget {
  final String type;
  final String imageAsset;
  final String payType;
  final ValueChanged<String> onChanged;

  const _PaymentOptionCard({
    required this.type,
    required this.imageAsset,
    required this.payType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = payType == type;
    return GestureDetector(
      onTap: () => onChanged(type),
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? context.primaryColor
                : context.hintColor.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: CustomImage(
            imageAsset,
            height: 24.h,
            width: 40.w,
            color: isSelected ? context.primaryColor : null,
          ),
        ),
      ),
    );
  }
}

class _PaymentOptionTextCard extends StatelessWidget {
  final String type;
  final String label;
  final String asset;
  final String payType;
  final ValueChanged<String> onChanged;

  const _PaymentOptionTextCard({
    required this.type,
    required this.label,
    required this.asset,
    required this.payType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = payType == type;
    return GestureDetector(
      onTap: () => onChanged(type),
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? context.primaryColor
                : context.hintColor.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: context.boldText.copyWith(
                color: isSelected ? context.primaryColor : context.hintColor,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(width: 8.w),
            CustomImage(
              asset,
              color: isSelected ? context.primaryColor : context.hintColor,
              height: 20.r,
              width: 20.r,
            ),
          ],
        ),
      ),
    );
  }
}

class CheckoutOrderSummary extends StatelessWidget {
  const CheckoutOrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: BlocBuilder<CartCubit, CartState>(
        bloc: sl<CartCubit>(),
        builder: (context, state) {
          final cart = state.cartData;
          if (cart == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              _SummaryRowItem(
                label: LocaleKeys.productsTotal.tr(),
                value:
                    '${cart.totalPriceBeforeDiscount} ${LocaleKeys.sar.tr()}',
              ),
              SizedBox(height: 12.h),
              _SummaryRowItem(
                label: LocaleKeys.deliveryCost.tr(),
                value: '${cart.deliveryCost} ${LocaleKeys.sar.tr()}',
              ),
              SizedBox(height: 12.h),
              _SummaryRowItem(
                label: LocaleKeys.discount.tr(),
                value: '-${cart.totalDiscount} ${LocaleKeys.sar.tr()}',
                isDiscount: true,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Divider(color: context.hintColor.withValues(alpha: 0.2)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.total.tr(),
                    style: context.boldText.copyWith(
                      color: context.primaryColor,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    '${cart.totalPriceWithVat} ${LocaleKeys.sar.tr()}',
                    style: context.boldText.copyWith(
                      color: context.primaryColor,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SummaryRowItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isDiscount;

  const _SummaryRowItem({
    required this.label,
    required this.value,
    this.isDiscount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.regularText.copyWith(
            color: context.primaryColor,
            fontSize: 14.sp,
          ),
        ),
        Text(
          value,
          style: context.regularText.copyWith(
            color: context.primaryColor,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}

class AddressesBottomSheet extends StatelessWidget {
  final dynamic addressesCubit;
  final ValueChanged<AddressModel> onAddressSelected;

  const AddressesBottomSheet({
    super.key,
    required this.addressesCubit,
    required this.onAddressSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: addressesCubit,
      builder: (context, dynamic state) {
        if (state.state == RequestState.loading) {
          return SizedBox(
            height: 200.h,
            child: const Center(
              child: CircularProgressIndicator(),
            ), // Assuming CustomProgress isn't imported here
          );
        }
        if (state.addresses.isEmpty) {
          return Container(
            height: 200.h,
            alignment: Alignment.center,
            child: Text(
              LocaleKeys.noSavedAddresses.tr(),
              style: context.boldText.copyWith(color: context.primaryColor),
            ),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.all(16.r),
          itemCount: state.addresses.length,
          separatorBuilder: (_, __) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            final address = state.addresses[index];
            return ListTile(
              title: Row(
                children: [
                  Text(
                    '${address.type == 'home' ? LocaleKeys.home.tr() : (address.type == 'work' ? LocaleKeys.work.tr() : address.type)} : ${address.location}',
                  ),
                  if (address.type == 'home' || address.type == 'work') ...[
                    SizedBox(width: 8.w),
                    CustomImage(
                      address.type == 'home'
                          ? Assets.icons.home
                          : Assets.icons.city,
                      height: 18.h,
                      width: 18.w,
                      color: context.primaryColor,
                    ),
                  ],
                ],
              ),
              subtitle: address.description.isNotEmpty
                  ? Text(address.description)
                  : null,
              onTap: () => onAddressSelected(address),
            );
          },
        );
      },
    );
  }
}
