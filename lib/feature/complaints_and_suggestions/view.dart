import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/core/widgets/app_field.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/feature/complaints_and_suggestions/cubit/complaints_and_suggestions_cubit.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class ComplaintsAndSuggestionsView extends StatefulWidget {
  const ComplaintsAndSuggestionsView({super.key});

  @override
  State<ComplaintsAndSuggestionsView> createState() =>
      _ComplaintsAndSuggestionsViewState();
}

class _ComplaintsAndSuggestionsViewState
    extends State<ComplaintsAndSuggestionsView> {
  final cubit = sl<ComplaintsAndSuggestionsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: LocaleKeys.complaintsAndSuggestions.tr(),
        isTitleCentered: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Form(
          key: cubit.formKey,
          child: Column(
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                child: AppField(
                  hintText: LocaleKeys.name.tr(),
                  controller: cubit.nameController,
                  keyboardType: TextInputType.name,
                ),
              ),
              16.hSpace,
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 150),
                child: AppField(
                  hintText: LocaleKeys.mobileNumber.tr(),
                  controller: cubit.phoneController,
                  keyboardType: TextInputType.phone,
                ),
              ),
              16.hSpace,
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 300),
                child: AppField(
                  hintText: LocaleKeys.subject.tr(),
                  controller: cubit.subjectController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                ),
              ),
              32.hSpace,
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 450),
                child: BlocBuilder<
                  ComplaintsAndSuggestionsCubit,
                  ComplaintsAndSuggestionsState
                >(
                  bloc: cubit,
                  builder: (context, state) {
                    return CustomButton(
                      isLoading: state.state.isLoading,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        cubit.sendContact();
                      },
                      borderRadius: BorderRadius.circular(15.r),
                      child: Text(
                        LocaleKeys.send.tr(),
                        style: context.boldText.copyWith(
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
