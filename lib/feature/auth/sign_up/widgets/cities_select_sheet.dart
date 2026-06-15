import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_field.dart';
import 'package:thimar/core/widgets/app_sheet.dart';
import 'package:thimar/feature/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class CitiesSelectSheet extends StatefulWidget {
  final SignUpCubit cubit;

  const CitiesSelectSheet({super.key, required this.cubit});

  @override
  State<CitiesSelectSheet> createState() => _CitiesSelectSheetState();
}

class _CitiesSelectSheetState extends State<CitiesSelectSheet> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      bloc: widget.cubit,
      builder: (context, state) {
        return CustomAppSheet(
          title: LocaleKeys.cityName.tr(),
          children: [
            if (state.citiesState.isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ).withPadding(vertical: 20.h)
            else if (state.citiesState.isError)
              Center(
                child: Column(
                  children: [
                    Text(
                      state.message.isNotEmpty
                          ? state.message
                          : LocaleKeys.something_went_wrong_please_try_again
                                .tr(),
                      style: context.mediumText.copyWith(
                        color: context.errorColor,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextButton(
                      onPressed: () => widget.cubit.getCities(),
                      child: Text(LocaleKeys.confirm.tr()),
                    ),
                  ],
                ),
              ).withPadding(vertical: 20.h)
            else ...[
              AppField(
                hintText: "ابحث عن مدينتك...",
                prefixIcon: const Icon(Icons.search),
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
              ),
              SizedBox(height: 10.h),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: Builder(
                  builder: (context) {
                    final filteredCities = state.cities.where((city) {
                      return city.name.toLowerCase().contains(
                        _searchQuery.toLowerCase(),
                      );
                    }).toList();

                    if (filteredCities.isEmpty) {
                      return Center(
                        child: Text(
                          "لا توجد مدن تطابق بحثك",
                          style: context.mediumText.copyWith(
                            color: context.hintColor,
                          ),
                        ),
                      ).withPadding(vertical: 20.h);
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: filteredCities.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 8.h),
                      itemBuilder: (context, index) {
                        final city = filteredCities[index];
                        final isSelected = state.selectedCity?.id == city.id;

                        return InkWell(
                          onTap: () {
                            widget.cubit.selectCity(city);
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? context.primaryColor.withValues(alpha: 0.1)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: isSelected
                                    ? context.primaryColor
                                    : context.borderColor.withValues(
                                        alpha: 0.5,
                                      ),
                                width: isSelected ? 1.5.w : 1.w,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    city.name,
                                    style: context.mediumText.copyWith(
                                      fontSize: 16.sp,
                                      color: isSelected
                                          ? context.primaryColor
                                          : Colors.black,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    Icons.check_circle,
                                    color: context.primaryColor,
                                    size: 20.r,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
