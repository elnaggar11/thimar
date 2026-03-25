import 'package:doctorin/core/utils/app_theme.dart';
import 'package:doctorin/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusWidget extends StatelessWidget {
  final String status, statusTrans;
  const StatusWidget({
    super.key,
    required this.status,
    required this.statusTrans,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ['completed', 'arrived'].contains(status)
            ? AppThemes.secondaryColor.color.withValues(alpha: 0.1)
            : ['canceled', 'waiting_for_payment'].contains(status)
            ? context.errorColor.withValues(alpha: 0.1)
            : ['upcoming'].contains(status)
            ? AppThemes.mainBorder.color.withValues(alpha: 0.1)
            : ['preparing'].contains(status)
            ? AppThemes.supportivePurpleColor.color.withValues(alpha: 0.1)
            : AppThemes.supportiveOrangeColor.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Text(
        statusTrans,
        style: context.semiboldText.copyWith(
          fontSize: 16,
          color: ['completed', 'arrived'].contains(status)
              ? AppThemes.secondaryColor.color
              : ['canceled', 'waiting_for_payment'].contains(status)
              ? context.errorColor
              : ['upcoming'].contains(status)
              ? AppThemes.mainBorder.color
              : ['preparing'].contains(status)
              ? AppThemes.supportivePurpleColor.color
              : AppThemes.supportiveOrangeColor.color,
        ),
      ),
    );
  }
}
