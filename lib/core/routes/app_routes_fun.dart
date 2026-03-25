import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future push(String named, {dynamic arg}) =>
    navigator.currentState!.pushNamed(named, arguments: arg);

Future<dynamic> replacement(String named, {dynamic arg}) => Navigator.of(
  navigator.currentContext!,
).pushReplacementNamed(named, arguments: arg);

Future<dynamic> pushAndRemoveUntil(String named, {dynamic arg, String? until}) {
  return Navigator.of(navigator.currentContext!).pushNamedAndRemoveUntil(
    named,
    arguments: arg,
    (route) {
      if (until == null) return false;
      return route.settings.name == until;
    },
  );
}

Future<void> pushBack([dynamic arg]) async =>
    Navigator.of(navigator.currentContext!).pop(arg);

Future pushDialog(Widget child) => Navigator.of(navigator.currentContext!).push(
  DialogRoute(
    context: navigator.currentContext!,
    builder: (context) => Container(
      margin: EdgeInsets.symmetric(vertical: 40.r, horizontal: 30.r),
      child: ClipRRect(borderRadius: BorderRadius.circular(30.r), child: child),
    ),
  ),
);

final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
