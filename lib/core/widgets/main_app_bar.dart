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
    leadingWidth: removeLeading ? null : 56.w,
    toolbarHeight: toolbarHeight ?? (widget != null ? null : kToolbarHeight),
    title:
        widget ??
        Text(
          title ?? '',
          style: context.semiboldText.copyWith(
            fontSize: 18,
            color: context.primaryColor,
          ),
        ),
    leading:
        leading ??
        (!removeLeading
            ? Center(
                child: InkWell(
                  onTap: onLeadingTap ?? pushBack,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    width: 35.r,
                    height: 35.r,
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: context.primaryColor.withValues(alpha: 0.2),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20.r,
                      color: context.primaryColor,
                    ),
                  ),
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
