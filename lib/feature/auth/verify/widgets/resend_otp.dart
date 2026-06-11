import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';

class ResendOtpWidget extends StatelessWidget {
  const ResendOtpWidget({super.key, this.onComplete});
  final void Function()? onComplete;

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      width: 60,
      height: 60,
      duration: 70,
      fillColor: context.primaryColor,
      ringColor: context.primaryColor.withValues(alpha: 0.5),
      isReverse: true,
      textFormat: CountdownTextFormat.MM_SS,
      textStyle: context.mediumText.copyWith(
        fontSize: 15.sp,
        color: context.primaryColor,
      ),
      strokeWidth: 3,
      timeFormatterFunction: (defaultFormatterFunction, duration) {
        if (duration.inSeconds == 0) {
          return "0";
        }
        if (duration.inSeconds > 60) {
          // يعرض دقائق وثواني
          return defaultFormatterFunction(duration);
        } else {
          // يعرض ثواني بس
          return "${duration.inSeconds}";
        }
      },
      onComplete: onComplete,
    );
  }
}
