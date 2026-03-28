import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/gen/locale_keys.g.dart';

import '../routes/app_routes_fun.dart';
import 'app_sheet.dart';
import 'custom_image.dart';

void showImagePreview(String imageUrl) => showDialog(
  context: navigator.currentContext!,
  barrierColor: Colors.transparent,
  useSafeArea: false,
  barrierDismissible: false,
  builder: (_) => Dialog(
    backgroundColor: Colors.transparent,
    child: GestureDetector(
      onTap: pushBack,
      child: InteractiveViewer(
        child: CustomImage(
          imageUrl,
          fit: BoxFit.cover,
          width: 300.w,
          height: 300.h,
          borderRadius: BorderRadius.circular(150.r),
        ),
      ),
    ),
  ),
);

void showLangDialog() => showModalBottomSheet(
  context: navigator.currentContext!,
  builder: (context) => CustomAppSheet(
    title: LocaleKeys.language.tr(),
    // children: const [LangWidget()],
  ),
);
