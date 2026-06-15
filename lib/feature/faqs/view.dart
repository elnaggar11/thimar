import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/base_shimmer.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/feature/faqs/cubit/faqs_cubit.dart';
import 'package:thimar/feature/faqs/model/faq_model.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class FaqsView extends StatefulWidget {
  const FaqsView({super.key});

  @override
  State<FaqsView> createState() => _FaqsViewState();
}

class _FaqsViewState extends State<FaqsView> {
  final cubit = sl<FaqsCubit>();
  @override
  void initState() {
    super.initState();
    cubit.getFaqs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: LocaleKeys.faqs.tr(), isTitleCentered: true),
      body: BlocBuilder<FaqsCubit, FaqsState>(
        bloc: cubit,
        builder: (context, state) {
          if (state.state.isLoading) {
            return _buildShimmerLoader();
          } else if (state.state.isError) {
            return _buildErrorState(context);
          } else {
            if (state.faqs.isEmpty) {
              return _buildEmptyState(context);
            }
            return _buildFaqsList(state.faqs);
          }
        },
      ),
    );
  }

  Widget _buildFaqsList(List<FaqModel> faqs) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: faqs.length,
      separatorBuilder: (context, index) => 16.hSpace,
      itemBuilder: (context, index) => FaqItemWidget(faq: faqs[index]),
    );
  }

  Widget _buildShimmerLoader() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: 6,
      separatorBuilder: (context, index) => 16.hSpace,
      itemBuilder: (context, index) => BaseShimmer(
        child: ShimmerContainer(height: 70.h, borderRadius: 12.r),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        LocaleKeys.dataNotFound.tr(),
        style: context.mediumText.copyWith(
          fontSize: 16.sp,
          color: context.hintColor,
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.something_went_wrong_please_try_again.tr(),
            style: context.mediumText.copyWith(
              fontSize: 16.sp,
              color: context.errorColor,
            ),
            textAlign: TextAlign.center,
          ).withPadding(horizontal: 32.w),
          16.hSpace,
          ElevatedButton(
            onPressed: () => context.read<FaqsCubit>().getFaqs(),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.primaryColor,
            ),
            child: Text(
              LocaleKeys.tryAgain.tr(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class FaqItemWidget extends StatefulWidget {
  final FaqModel faq;
  const FaqItemWidget({super.key, required this.faq});

  @override
  State<FaqItemWidget> createState() => _FaqItemWidgetState();
}

class _FaqItemWidgetState extends State<FaqItemWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(
              color: context.borderColor.withValues(alpha: 0.3),
              width: 1.w,
            ),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(
              color: context.borderColor.withValues(alpha: 0.3),
              width: 1.w,
            ),
          ),
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          childrenPadding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: 16.h,
          ),
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          title: Text(
            widget.faq.question,
            style: context.semiboldText.copyWith(
              fontSize: 15.sp,
              color: context.primaryColor,
              height: 1.3,
            ),
          ),
          trailing: Container(
            width: 28.w,
            height: 28.w,
            decoration: BoxDecoration(
              color: context.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: AnimatedRotation(
              turns: _isExpanded ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 250),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: context.primaryColor,
                size: 20.r,
              ),
            ),
          ),
          children: [
            Text(
              widget.faq.answer,
              style: context.regularText.copyWith(
                fontSize: 14.sp,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ).toStart,
          ],
        ),
      ),
    );
  }
}
