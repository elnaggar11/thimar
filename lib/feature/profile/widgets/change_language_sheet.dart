import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/app_btn.dart';
import 'package:thimar/core/widgets/app_sheet.dart';
import 'package:thimar/core/widgets/custom_image.dart';
import 'package:thimar/gen/assets.gen.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class ChangeLanguageSheet extends StatefulWidget {
  const ChangeLanguageSheet({super.key});

  @override
  State<ChangeLanguageSheet> createState() => _ChangeLanguageSheetState();
}

class _ChangeLanguageSheetState extends State<ChangeLanguageSheet> {
  late String _selectedLocaleCode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedLocaleCode = context.locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppSheet(
      title: LocaleKeys.changeLanguage.tr(),
      children: [
        SizedBox(height: 8.h),
        _buildLanguageOption(
          title: 'العربية',
          localeCode: 'ar',
          flag: Assets.icons.ksaFlag,
        ),
        _buildLanguageOption(
          title: 'English',
          localeCode: 'en',
          flag: Assets.icons.language,
        ),
        SizedBox(height: 16.h),
        CustomButton(
          title: LocaleKeys.confirm.tr(),
          onTap: () async {
            if (_selectedLocaleCode != context.locale.languageCode) {
              await context.setLocale(Locale(_selectedLocaleCode));
              if (mounted) {
                Navigator.pop(context);
              }
            }
          },
        ),
      ],
    );
  }

  Widget _buildLanguageOption({
    required String title,
    required String localeCode,
    required String flag,
  }) {
    final isSelected = _selectedLocaleCode == localeCode;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLocaleCode = localeCode;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected
              ? context.primaryColor.withValues(alpha: 0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? context.primaryColor
                : context.borderColor.withValues(alpha: 0.5),
            width: isSelected ? 1.5.w : 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: isSelected
                    ? context.primaryColor.withValues(alpha: 0.1)
                    : context.borderColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: CustomImage(
                flag,
                width: 20.w,
                height: 20.h,
                color: isSelected ? context.primaryColor : context.hintColor,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: context.mediumText.copyWith(
                  fontSize: 16.sp,
                  color: isSelected ? context.primaryColor : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? context.primaryColor
                      : context.hintColor.withValues(alpha: 0.5),
                  width: 2.w,
                ),
                color: isSelected ? context.primaryColor : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 12.w, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
