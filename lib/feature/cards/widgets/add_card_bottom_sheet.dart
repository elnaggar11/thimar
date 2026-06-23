import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/core/widgets/app_field.dart';
import 'package:thimar/gen/locale_keys.g.dart';

import '../cubit/cards_cubit.dart';

class AddCardBottomSheet extends StatelessWidget {
  final CardsCubit cubit;

  const AddCardBottomSheet({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 24.h,
        left: 16.w,
        right: 16.w,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      decoration: BoxDecoration(
        color: context.scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Form(
        key: cubit.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.addCard.tr(),
              style: context.boldText.copyWith(
                color: context.primaryColor,
                fontSize: 16.sp,
              ),
            ),
            16.verticalSpace,
            AppField(
              hintText: LocaleKeys.cardHolderName.tr(),
              controller: cubit.cardHolderNameController,
            ),
            16.verticalSpace,
            AppField(
              hintText: LocaleKeys.cardNumber.tr(),
              controller: cubit.cardNumberController,
              keyboardType: TextInputType.number,
            ),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: AppField(
                    hintText: LocaleKeys.expiryDateMonthYear.tr(),
                    controller: cubit.expiryDateController,
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: AppField(
                    hintText: LocaleKeys.cvvNumber.tr(),
                    controller: cubit.cvvController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            24.verticalSpace,
            CustomButton(
              title: LocaleKeys.addCard.tr(),
              onTap: () {
                cubit.addCard();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
