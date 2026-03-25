import 'package:doctorin/core/utils/extensions.dart';
import 'package:doctorin/core/widgets/app_btn.dart';
import 'package:doctorin/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ================= ENUM =================
enum AdaptivePickerType { time, monthYear }

/// ================= MAIN FUNCTION =================
Future<dynamic> showAdaptivePicker({
  required BuildContext context,
  required AdaptivePickerType type,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  String? title,
}) {
  switch (type) {
    case AdaptivePickerType.time:
      return _showAdaptiveTimePicker(
        context: context,
        initialDate: initialDate,
      );

    case AdaptivePickerType.monthYear:
      return _showAdaptiveMonthYearPicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        title: title ?? '',
      );
  }
}

/// ================= TIME PICKER =================
Future<String?> _showAdaptiveTimePicker({
  required BuildContext context,
  required DateTime initialDate,
}) {
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    return _showCupertinoTimePicker(context: context, initialDate: initialDate);
  } else {
    return _showAndroidTimePicker(context: context, initialDate: initialDate);
  }
}

Future<String?> _showCupertinoTimePicker({
  required BuildContext context,
  required DateTime initialDate,
}) {
  DateTime selectedTime = initialDate;

  return showCupertinoModalPopup<String>(
    context: context,
    builder: (_) => Container(
      padding: EdgeInsets.all(16.r),
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground.resolveFrom(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        children: [
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: initialDate,
              onDateTimeChanged: (value) => selectedTime = value,
            ),
          ),
          SafeArea(
            top: false,
            child: CustomButton(
              onTap: () {
                final formatted = DateFormat(
                  'hh:mm a',
                  'en',
                ).format(selectedTime).toLowerCase();
                Navigator.pop(context, formatted);
              },
              title: LocaleKeys.apply.tr(),
            ).withPadding(vertical: 10.h),
          ),
        ],
      ),
    ),
  );
}

Future<String?> _showAndroidTimePicker({
  required BuildContext context,
  required DateTime initialDate,
}) async {
  final picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(initialDate),
  );

  if (picked == null) return null;

  final dateTime = DateTime(
    initialDate.year,
    initialDate.month,
    initialDate.day,
    picked.hour,
    picked.minute,
  );

  return DateFormat('hh:mm a', 'en').format(dateTime).toLowerCase();
}

/// ================= MONTH / YEAR PICKER =================
Future<DateTime?> _showAdaptiveMonthYearPicker({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  required String title,
}) {
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    return _showCupertinoMonthYearPicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      title: title,
    );
  } else {
    return _showAndroidMonthYearPicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }
}

Future<DateTime?> _showCupertinoMonthYearPicker({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  required String title,
}) {
  DateTime selectedDate = initialDate;

  return showCupertinoModalPopup<DateTime>(
    context: context,
    builder: (_) => Container(
      padding: EdgeInsets.all(16.r),
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground.resolveFrom(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: context.boldText.copyWith(fontSize: 18)),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.monthYear,
              initialDateTime: initialDate,
              minimumDate: firstDate,
              maximumDate: lastDate,
              onDateTimeChanged: (value) {
                selectedDate = DateTime(value.year, value.month);
              },
            ),
          ),
          SafeArea(
            top: false,
            child: CustomButton(
              onTap: () => Navigator.pop(context, selectedDate),
              title: LocaleKeys.apply.tr(),
            ).withPadding(vertical: 10.h),
          ),
        ],
      ),
    ),
  );
}

Future<DateTime?> _showAndroidMonthYearPicker({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final picked = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate ?? DateTime(2000),
    lastDate: lastDate ?? DateTime(2100),
    initialDatePickerMode: DatePickerMode.year,
  );

  if (picked == null) return null;

  return DateTime(picked.year, picked.month);
}
