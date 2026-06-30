import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/loading.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/core/widgets/error_widget.dart';
import 'package:thimar/feature/addresses/cubit/addresses_cubit.dart';
import 'package:thimar/feature/addresses/cubit/addresses_state.dart';
import 'package:thimar/feature/addresses/widgets/address_item_widget.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/widgets/custom_dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class AddressesView extends StatefulWidget {
  const AddressesView({super.key});

  @override
  State<AddressesView> createState() => _AddressesViewState();
}

class _AddressesViewState extends State<AddressesView> {
  final _cubit = sl<AddressesCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: MainAppBar(title: LocaleKeys.addresses.tr(), isTitleCentered: true),
        body: BlocBuilder<AddressesCubit, AddressesState>(
          builder: (context, state) {
            if (state.state == RequestState.loading) {
              return const Center(child: CustomProgress());
            }

            if (state.state == RequestState.error) {
              return Center(
                child: Text(
                  state.message,
                  style: context.boldText.copyWith(color: context.errorColor),
                ),
              );
            }

            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: state.addresses.isEmpty
                        ? const CustomErrorWidget(
                            title: 'لا يوجد عناوين مضافة',
                            errType: ErrorType.empty,
                          )
                        : ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      itemCount: state.addresses.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemBuilder: (context, index) {
                        return AddressItemWidget(
                          address: state.addresses[index],
                          onEdit: () {
                            push(
                              NamedRoutes.addAddress,
                              arg: {'address': state.addresses[index]},
                            ).then((value) {
                              if (value == true) {
                                _cubit.getAddresses();
                              }
                            });
                          },
                          onDelete: () {
                            _cubit.deleteAddress(state.addresses[index].id, type: state.addresses[index].type);
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.r),
                    child: GestureDetector(
                      onTap: () {
                        push(NamedRoutes.addAddress).then((value) {
                          if (value == true) {
                            _cubit.getAddresses();
                          }
                        });
                      },
                      child: CustomDottedBorder(
                        color: context.primaryColor,
                        strokeWidth: 1.w,
                        radius: 16.r,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          alignment: Alignment.center,
                          child: Text(
                            LocaleKeys.addAddress.tr(),
                            style: context.boldText.copyWith(
                              fontSize: 16.sp,
                              color: context.primaryColor,
                            ),
                          ),
                        ),
                      ),
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
