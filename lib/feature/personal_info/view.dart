import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/core/widgets/app_field.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/core/widgets/pick_image.dart';
import 'package:thimar/feature/personal_info/cubit/personal_info_cubit.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';
import 'package:thimar/models/user_model.dart';

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({super.key});

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  final cubit = sl<PersonalInfoCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: LocaleKeys.personalInfo.tr(),
        isTitleCentered: true,
      ),
      body: BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
        bloc: cubit,
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  // Profile Picture section
                  FadeInDown(
                    duration: const Duration(milliseconds: 500),
                    child: Center(
                      child: Column(
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              if (!state.isEditMode) return;
                              final file = await showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    PickImage(title: LocaleKeys.camera.tr()),
                              );
                              if (file != null) {
                                cubit.setPickedImage(file);
                              }
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 85.w,
                                  width: 85.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.r),
                                    child: state.pickedImage != null
                                        ? Image.file(
                                            state.pickedImage!,
                                            fit: BoxFit.cover,
                                          )
                                        : CustomImage(
                                            UserModel.i.avatarPath,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                if (state.isEditMode)
                                  Container(
                                    height: 85.w,
                                    width: 85.w,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Center(
                                      child: CustomImage(
                                        Assets.icons.camera,
                                        color: Colors.white,
                                        width: 24.w,
                                        height: 24.w,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  32.verticalSpace,

                  // Name Field
                  FadeInUp(
                    delay: const Duration(milliseconds: 100),
                    duration: const Duration(milliseconds: 400),
                    child: AppField(
                      hintText: LocaleKeys.name.tr(),
                      controller: cubit.nameController,
                      readOnly: !state.isEditMode,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomImage(Assets.icons.user),
                      ),
                    ),
                  ),
                  16.verticalSpace,

                  // Phone Field
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 400),
                    child: AppField(
                      hintText: LocaleKeys.mobileNumber.tr(),
                      controller: cubit.phoneController,
                      keyboardType: TextInputType.phone,
                      readOnly: !state.isEditMode,
                    ),
                  ),
                  16.verticalSpace,

                  // City Field
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    duration: const Duration(milliseconds: 400),
                    child: AppField(
                      hintText: LocaleKeys.cityName.tr(),
                      controller: cubit.cityController,
                      isRequired: false,
                      readOnly: true,
                      onTap: () {
                        if (!state.isEditMode) return;
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => ListView.builder(
                            itemCount: state.cities.length,
                            itemBuilder: (context, index) {
                              final city = state.cities[index];
                              return ListTile(
                                title: Text(city.name),
                                onTap: () {
                                  cubit.selectCity(city);
                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        );
                      },
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomImage(Assets.icons.city),
                      ),
                    ),
                  ),
                  16.verticalSpace,

                  // Password Field (Navigates to another screen)
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    duration: const Duration(milliseconds: 400),
                    child: AppField(
                      isRequired: false,
                      hintText: LocaleKeys.password.tr(),
                      readOnly: true,
                      onTap: () {
                        push(NamedRoutes.updatePassword);
                      },
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomImage(Assets.icons.password),
                      ),
                      suffixIcon: Transform.flip(
                        flipX: context.locale.toString() == 'en' ? true : false,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomImage(
                            Assets.icons.arrowLeft,
                            color: context.hintColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  32.verticalSpace,

                  // Save / Edit Button
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 400),
                    child: CustomButton(
                      borderRadius: BorderRadius.circular(12),
                      isLoading: state.state.isLoading,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        cubit.toggleEditMode();
                      },
                      child: Text(
                        state.isEditMode
                            ? LocaleKeys.save.tr()
                            : LocaleKeys.updateData.tr(),
                        style: context.boldText.copyWith(
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
