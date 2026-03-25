import 'package:doctorin/core/routes/app_routes_fun.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_theme.dart';
import '../utils/extensions.dart';

enum MessageType { success, fail, warning }

class FlashHelper {
  static Future<void> showToast(
    String msg, {
    int duration = 2,
    MessageType type = MessageType.fail,
  }) async {
    if (msg.isEmpty) return;
    return showFlash(
      context: navigator.currentContext!,
      builder: (context, controller) => FlashBar(
        controller: controller,
        position: FlashPosition.top,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 10.h),
          decoration: BoxDecoration(
            border: Border.all(
              color: type == MessageType.success
                  ? AppThemes.secondaryColor.color
                  : _getBgColor(type),
            ),
            borderRadius: BorderRadius.circular(20.r),
            color: _getBgColor(type),
          ),
          child: Row(
            spacing: 10.w,
            children: [
              _getIcon(type),
              Expanded(
                child: Text(
                  msg,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                  style: context.semiboldText,
                ),
              ),
            ],
          ),
        ),
      ),
      duration: const Duration(milliseconds: 3000),
    );
  }

  static Widget _getIcon(MessageType msgType) {
    switch (msgType) {
      case MessageType.success:
        return Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppThemes.secondaryColor.color.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, color: AppThemes.secondaryColor.color),
        );
      case MessageType.warning:
        return Icon(
          Icons.info_outline_rounded,
          color: AppThemes.supportiveOrangeColor.color,
        );
      default:
        return Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppThemes.scaffoldBackgroundColor.withValues(
              alpha: 0.4,
            ), // Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.close_rounded,
            color: AppThemes.scaffoldBackgroundColor,
          ),
        );
    }
  }

  static Color _getBgColor(MessageType msgType) {
    switch (msgType) {
      case MessageType.success:
        return "#F6FFF9".color;
      case MessageType.warning:
        return "#FFCC00".color.withValues(alpha: 0.2);
      default:
        return "#EF233C".color;
    }
  }
}
