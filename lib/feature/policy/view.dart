import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/loading.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/feature/policy/cubit/policy_cubit.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class PolicyView extends StatelessWidget {
  const PolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PolicyCubit>(),
      child: Scaffold(
        appBar: MainAppBar(
          title: LocaleKeys.privacyPolicy.tr(),
          isTitleCentered: true,
        ),
        body: BlocBuilder<PolicyCubit, PolicyState>(
          builder: (context, state) {
            if (state.state == RequestState.loading) {
              return const Center(child: CustomProgress());
            } else if (state.state == RequestState.done) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.r),
                child: FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child: HtmlWidget(
                    state.policyHtml,
                    textStyle: context.mediumText.copyWith(
                      fontSize: 16.sp,
                      height: 1.6,
                    ),
                  ),
                ),
              );
            } else if (state.state == RequestState.error) {
              return Center(
                // fallback to empty if there's no error message translation, though UI has state
                child: const Text("حدث خطأ، يرجى المحاولة لاحقاً"),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
