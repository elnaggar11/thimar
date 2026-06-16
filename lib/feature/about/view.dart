import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:animate_do/animate_do.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/core/widgets/loading.dart';
import 'package:thimar/feature/about/cubit/about_cubit.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  final cubit = sl<AboutCubit>();
  AnimationController? _logoController;

  @override
  void initState() {
    super.initState();
    cubit.getAbout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: LocaleKeys.aboutApp.tr(),
        isTitleCentered: true,
      ),
      body: BlocBuilder<AboutCubit, AboutState>(
        bloc: cubit,
        builder: (context, state) {
          if (state.state.isLoading) {
            return Center(child: CustomProgress(size: 30.h));
          } else if (state.state.isError) {
            return Center(
              child: Text(
                LocaleKeys.something_went_wrong_please_try_again.tr(),
                style: context.mediumText.copyWith(
                  color: context.errorColor,
                  fontSize: 16.sp,
                ),
              ),
            );
          }
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _logoController?.reset();
                    _logoController?.forward();
                  },
                  child: Pulse(
                    duration: const Duration(milliseconds: 800),
                    controller: (controller) => _logoController = controller,
                    child: CustomImage(
                      Assets.icons.thimarLogo,
                      width: 130.w,
                      height: 130.w,
                    ),
                  ),
                ),
                24.hSpace,
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 300),
                  child: HtmlWidget(
                    state.about,
                    textStyle: context.regularText.copyWith(
                      fontSize: 15.sp,
                      color: context.hintColor,
                      height: 1.8,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
