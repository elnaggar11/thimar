import 'dart:ui' as ui;

import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/core/widgets/app_field.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/core/widgets/loading.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/feature/contact_us/cubit/contact_us_cubit.dart';
import 'package:thimar/feature/contact_us/model/contact_info_model.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final cubit = sl<ContactUsCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        appBar: MainAppBar(
          title: LocaleKeys.contactUs.tr(),
          isTitleCentered: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<ContactUsCubit, ContactUsState>(
                buildWhen: (previous, current) =>
                    previous.state != current.state ||
                    previous.contactInfo != current.contactInfo,
                builder: (context, state) {
                  if (state.state == RequestState.loading) {
                    return const Center(child: CustomProgress());
                  }

                  if (state.contactInfo != null) {
                    return FadeInDown(
                      duration: const Duration(milliseconds: 500),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          // Map Background
                          Container(
                            height: 250.h,
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 24.h),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: MapWidget(contactInfo: state.contactInfo!),
                            ),
                          ),
                          // Info Card
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 20.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        state.contactInfo!.location,
                                        style: context.mediumText.copyWith(
                                          fontSize: 14.sp,
                                          color: Colors.grey.shade700,
                                          height: 1.5,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    12.wSpace,
                                    CustomImage(
                                      Assets.icons.location,
                                      width: 24.w,
                                      height: 24.w,
                                      color: context.primaryColor,
                                    ),
                                  ],
                                ),
                                16.hSpace,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      state.contactInfo!.phone,
                                      style: context.mediumText.copyWith(
                                        fontSize: 14.sp,
                                        color: Colors.grey.shade700,
                                      ),
                                      textDirection: ui.TextDirection.ltr,
                                    ),
                                    12.wSpace,
                                    CustomImage(
                                      Assets.icons.call,
                                      width: 24.w,
                                      height: 24.w,
                                      color: context.primaryColor,
                                    ),
                                  ],
                                ),
                                16.hSpace,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      state.contactInfo!.email,
                                      style: context.mediumText.copyWith(
                                        fontSize: 14.sp,
                                        color: Colors.grey.shade700,
                                      ),
                                      textDirection: ui.TextDirection.ltr,
                                    ),
                                    12.wSpace,
                                    CustomImage(
                                      Assets.icons.message,
                                      width: 24.w,
                                      height: 24.w,
                                      color: context.primaryColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              32.hSpace,

              FadeInUp(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 500),
                child: Center(
                  child: Text(
                    "أو يمكنك إرسال رسالة",
                    style: context.boldText.copyWith(
                      fontSize: 15.sp,
                      color: context.primaryColor,
                    ),
                  ),
                ),
              ),
              24.hSpace,

              Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 500),
                      child: AppField(
                        hintText: LocaleKeys.name.tr(),
                        controller: cubit.nameController,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    16.hSpace,
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 500),
                      child: AppField(
                        hintText: LocaleKeys.mobileNumber.tr(),
                        controller: cubit.phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    16.hSpace,
                    FadeInUp(
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(milliseconds: 500),
                      child: AppField(
                        hintText: LocaleKeys.subject.tr(),
                        controller: cubit.subjectController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                      ),
                    ),
                    32.hSpace,
                    BlocBuilder<ContactUsCubit, ContactUsState>(
                      buildWhen: (previous, current) =>
                          previous.sendState != current.sendState,
                      builder: (context, state) {
                        return FadeInUp(
                          delay: const Duration(milliseconds: 600),
                          duration: const Duration(milliseconds: 500),
                          child: CustomButton(
                            isLoading: state.sendState.isLoading,
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
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MapWidget extends StatelessWidget {
  const MapWidget({super.key, required this.contactInfo});

  final ContactInfoModel contactInfo;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(contactInfo.lat, contactInfo.lng),
        zoom: 14,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('location'),
          position: LatLng(contactInfo.lat, contactInfo.lng),
        ),
      },
      myLocationEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      compassEnabled: false,
      scrollGesturesEnabled: false,
      myLocationButtonEnabled: false,
    );
  }
}
