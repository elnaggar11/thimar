import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/utils/extensions.dart';

import '../routes/app_routes_fun.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.title,
    this.actions,
    this.bottom,
    this.backgroundColor,
    this.removeLeading = false,
    this.widget,
    this.toolbarHeight,
    this.titleColor,
    this.onLeadingTap,
    this.leading,
    this.isTitleCentered = false,
    this.shape,
  });

  final String? title;
  final double? toolbarHeight;
  final bool isTitleCentered, removeLeading;
  final Color? backgroundColor, titleColor;
  final PreferredSizeWidget? bottom;
  final void Function()? onLeadingTap;
  final List<Widget>? actions;
  final Widget? widget, leading;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) => AppBar(
    automaticallyImplyLeading: !removeLeading,
    toolbarHeight: toolbarHeight ?? (widget != null ? null : kToolbarHeight),
    title:
        widget ??
        Text(
          title ?? '',
          style: context.semiboldText.copyWith(fontSize: 22, color: titleColor),
        ),
    leading:
        leading ??
        (!removeLeading
            ? IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: context.borderColor,
                  padding: EdgeInsets.all(8.r),
                ),
                onPressed: onLeadingTap ?? pushBack,
                icon: Icon(
                  Platform.isAndroid
                      ? Icons.arrow_back
                      : Icons.arrow_back_ios_rounded,
                  size: 22.r,
                  color: context.primaryColorDark,
                ),
              )
            : null),
    backgroundColor: backgroundColor,
    actions: actions,
    bottom: bottom,
    centerTitle: isTitleCentered,
    shape: shape,
  );
  @override
  Size get preferredSize => Size(
    double.infinity,
    (bottom?.preferredSize.height ?? 0) + kToolbarHeight + 30.h,
  );
}
