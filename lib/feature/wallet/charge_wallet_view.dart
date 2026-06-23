import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/core/widgets/app_field.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/feature/wallet/cubit/wallet_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class ChargeWalletView extends StatefulWidget {
  const ChargeWalletView({super.key});

  @override
  State<ChargeWalletView> createState() => _ChargeWalletViewState();
}

class _ChargeWalletViewState extends State<ChargeWalletView> {
  final _cubit = sl<WalletCubit>();

  @override
  void dispose() {
    super.dispose();
  }

  void _onPay() async {
    final success = await _cubit.chargeWallet();

    if (success && mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: LocaleKeys.chargeNow.tr(), isTitleCentered: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.amountInfo.tr(),
              style: context.boldText.copyWith(
                fontSize: 16.sp,
                color: context.primaryColor,
              ),
            ),
            SizedBox(height: 16.h),
            AppField(
              controller: _cubit.amountController,
              hintText: LocaleKeys.yourAmount.tr(),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 32.h),
            Text(
              LocaleKeys.cardInfo.tr(),
              style: context.boldText.copyWith(
                fontSize: 16.sp,
                color: context.primaryColor,
              ),
            ),
            SizedBox(height: 16.h),
            AppField(
              controller: _cubit.nameController,
              hintText: LocaleKeys.name.tr(),
            ),
            SizedBox(height: 16.h),
            AppField(
              controller: _cubit.cardController,
              hintText: LocaleKeys.creditCardNumber.tr(),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: AppField(
                    controller: _cubit.expiryController,
                    hintText: LocaleKeys.expiryDate.tr(),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: AppField(
                    controller: _cubit.cvvController,
                    hintText: LocaleKeys.cvv.tr(),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 48.h),
            CustomButton(
              title: LocaleKeys.pay.tr(),
              onTap: _onPay,
              backgroundColor: context.primaryColor,
              textColor: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ],
        ),
      ),
    );
  }
}
