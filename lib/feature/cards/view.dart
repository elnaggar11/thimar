import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/core/widgets/custom_dotted_border.dart';
import 'package:thimar/gen/locale_keys.g.dart';

import 'cubit/cards_cubit.dart';
import 'widgets/card_item_widget.dart';
import 'widgets/add_card_bottom_sheet.dart';

class CardsView extends StatefulWidget {
  const CardsView({super.key});

  @override
  State<CardsView> createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  final _cubit = sl<CardsCubit>();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: LocaleKeys.payment.tr(),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          CardItemWidget(
            cardType: 'VISA',
            cardHolder: 'Mohamed ali',
            cardNumber: '**** **** **** 0197',
            expiryDate: '06/22',
            backgroundColor: const Color(0xff0b0b0b),
          ),
          16.verticalSpace,
          CardItemWidget(
            cardType: 'MasterCard',
            cardHolder: 'Mohamed ali',
            cardNumber: '**** **** **** 0197',
            expiryDate: '06/22',
            backgroundColor: context.primaryColor,
          ),
          24.verticalSpace,
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (ctx) => AddCardBottomSheet(cubit: _cubit),
              );
            },
            child: CustomDottedBorder(
              color: context.primaryColor,
              strokeWidth: 1,
              radius: 12.r,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    LocaleKeys.addCard.tr(),
                    style: context.boldText.copyWith(
                      color: context.primaryColor,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
