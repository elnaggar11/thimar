import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';

import '../utils/extensions.dart';

class CustomAppSheet extends StatelessWidget {
  final String? title, subtitle;
  final List<Widget>? children;
  final bool isClose;
  final bool? isWithPadding;

  const CustomAppSheet({
    super.key,
    this.isClose = true,
    this.title,
    this.children,
    this.isWithPadding = true,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
    child:
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (title != null)
                    Expanded(
                      child: Text(
                        title!,
                        style: context.boldText.copyWith(fontSize: 20),
                      ),
                    ),
                  if (isClose)
                    InkWell(
                      onTap: () => pushBack(),
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: context.borderColor.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.close, size: 25.r),
                      ),
                    ),
                ],
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: context.regularText.copyWith(
                    color: context.hintColor,
                    fontSize: 16,
                  ),
                ).toStart.withPadding(top: 16.h, bottom: 16.h),
              Column(
                spacing: 16.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children ?? [],
              ),
            ],
          ),
        ).withPadding(
          horizontal: 15.r,
          top: 12.h,
          bottom: isWithPadding == true ? context.bottomBarHeight : 0,
        ),
  );
}
