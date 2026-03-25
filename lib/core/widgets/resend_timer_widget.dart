import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/locale_keys.g.dart';
import '../utils/extensions.dart';
import 'custom_timer.dart';
import 'loading.dart';

class ResendTimerWidget extends StatefulWidget {
  final Function onTap;
  final bool loading;
  final CustomTimerController timer;
  const ResendTimerWidget({
    required this.onTap,
    required this.loading,
    required this.timer,
    super.key,
  });

  @override
  State<ResendTimerWidget> createState() => _ResendTimerWidgetState();
}

class _ResendTimerWidgetState extends State<ResendTimerWidget> {
  @override
  Widget build(BuildContext context) => CustomTimerWidget(
    autoStart: true,
    onFinish: () {
      setState(() {});
    },
    builder: (tiker) {
      final bool isTimerFinished = tiker.minutes == 0 && tiker.seconds == 0;
      return Row(
        spacing: 5.w,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: LocaleKeys.did_not_you_receive_the_code.tr(),
                  style: context.mediumText,
                ),
                const TextSpan(text: " "),
              ],
            ),
          ),
          if (widget.loading)
            CustomProgress(size: 12.r).withPadding(horizontal: 10.r),
          GestureDetector(
            onTap: isTimerFinished ? () => widget.onTap.call() : null,
            child: Text(
              LocaleKeys.resend.tr(),
              style: context.semiboldText.copyWith(
                fontSize: 14,
                color: isTimerFinished
                    ? context.primaryColorDark
                    : context.borderColor,
              ),
            ),
          ),
          const Spacer(),
          Text(
            "${"${tiker.minutes}".padLeft(2, "0")}:${"${tiker.seconds}".padLeft(2, "0")}",
            style: context.semiboldText,
          ),
        ],
      );
    },
    controller: widget.timer,
  );
}
