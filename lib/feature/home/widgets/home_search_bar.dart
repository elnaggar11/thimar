import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_field.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class HomeSearchBar extends StatelessWidget {
  final TextEditingController controller;

  const HomeSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: AppField(
        controller: controller,
        hintText: LocaleKeys.searchHome.tr(),
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        fillColor: Colors.grey.shade100,
        height: 50.h,
        hintColor: context.primaryColor.withValues(alpha: 0.5),
      ),
    );
  }
}
