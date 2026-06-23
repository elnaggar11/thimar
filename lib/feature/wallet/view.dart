import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/custom_dotted_border.dart';
import 'package:thimar/core/widgets/loading.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/feature/wallet/cubit/wallet_cubit.dart';
import 'package:thimar/feature/wallet/cubit/wallet_state.dart';
import 'package:thimar/feature/wallet/widgets/transaction_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  final _cubit = sl<WalletCubit>()..getWalletData();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: MainAppBar(
          title: LocaleKeys.wallet.tr(),
          isTitleCentered: true,
        ),
        body: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            if (state.state == RequestState.loading) {
              return const Center(child: CustomProgress());
            }

            final wallet = state.walletData;
            final balance = wallet?.balance ?? "0";
            final transactions = wallet?.transactions ?? [];

            return Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 32.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          LocaleKeys.yourBalance.tr(),
                          style: context.semiboldText.copyWith(
                            fontSize: 16.sp,
                            color: context.primaryColor,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          '$balance ر.س',
                          style: context.boldText.copyWith(
                            fontSize: 24.sp,
                            color: context.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  GestureDetector(
                    onTap: () {
                      push(NamedRoutes.chargeWallet).then((value) {
                        if (value == true) {
                          _cubit.getWalletData();
                        }
                      });
                    },
                    child: CustomDottedBorder(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Text(
                          LocaleKeys.chargeNow.tr(),
                          textAlign: TextAlign.center,
                          style: context.boldText.copyWith(
                            fontSize: 16.sp,
                            color: context.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.transactionHistory.tr(),
                        style: context.boldText.copyWith(
                          fontSize: 16.sp,
                          color: context.primaryColor,
                        ),
                      ),
                      Text(
                        LocaleKeys.viewAll.tr(),
                        style: context.regularText.copyWith(
                          fontSize: 14.sp,
                          color: context.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: transactions.isEmpty
                        ? Center(
                            child: Text(
                              LocaleKeys.noTransactionsYet.tr(),
                              style: context.regularText.copyWith(
                                color: context.hintColor,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              return TransactionItemWidget(
                                transaction: transactions[index],
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
