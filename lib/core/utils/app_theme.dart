import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/gen/locale_keys.g.dart';

// import '../../gen/fonts.gen.dart';
import 'extensions.dart';

class AppThemes {
  static const mainColor = '#007AFF';
  static const lightText = '#6D6D6D';
  static const scaffoldBackgroundColor = Colors.white;
  static const lightColor = '#FFFFFF';
  static const mainBorder = '#E6E7E9';
  static const blackColor = Colors.black;
  static const transparent = Colors.transparent;
  static const rateColor = '#F4BD5B';
  static const secondaryColor = '#00E0C3';
  static const errorColor = '#F43F3F';
  static const supportiveOrangeColor = '#FFB319';
  static const supportivePurpleColor = '#5C33CF';

  static ThemeData get lightTheme => ThemeData(
    primaryColor: mainColor.color,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    textTheme: arabicTextTheme,
    hoverColor: lightColor.color,
    // fontFamily: FontFamily.iBMPlexSansArabic,
    hintColor: lightText.color,
    primaryColorLight: Colors.white,
    primaryColorDark: blackColor,
    disabledColor: lightText.color,
    splashColor: transparent,
    highlightColor: transparent,
    dividerColor: mainBorder.color,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    iconTheme: const IconThemeData(color: blackColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: false,
      surfaceTintColor: scaffoldBackgroundColor,
      iconTheme: IconThemeData(color: blackColor, size: 20),
      titleTextStyle: TextStyle(
        color: blackColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: scaffoldBackgroundColor,
      selectedItemColor: mainColor.color,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: scaffoldBackgroundColor,
      enableFeedback: true,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return mainColor.color;
        } else {
          return mainBorder.color;
        }
      }),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(1000),
        borderSide: BorderSide.none,
      ),
      iconSize: 24.h,
      backgroundColor: mainColor.color,
      elevation: 1,
    ),
    colorScheme: ColorScheme.light(
      primaryContainer: lightColor.color,
      secondary: secondaryColor.color,
      primary: mainColor.color,
      error: errorColor.color,
    ),
    timePickerTheme: TimePickerThemeData(
      elevation: 0,
      dialHandColor: mainColor.color,
      dialTextColor: blackColor,
      backgroundColor: Colors.white,
      hourMinuteColor: scaffoldBackgroundColor,
      dayPeriodTextColor: blackColor,
      entryModeIconColor: transparent,
      dialBackgroundColor: scaffoldBackgroundColor,
      hourMinuteTextColor: blackColor,
      dayPeriodBorderSide: BorderSide(color: mainColor.color),
    ),
    dividerTheme: DividerThemeData(color: mainBorder.color),
    tabBarTheme: TabBarThemeData(
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: lightText.color.withValues(alpha: 0.2),
      indicatorColor: mainColor.color,
      labelStyle: TextStyle(
        fontSize: 15,
        fontFamily: 'tajawal',
        //  fontFamily: FontFamily.iBMPlexSansArabic,
        color: mainColor.color,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        //  fontFamily: FontFamily.iBMPlexSansArabic,
        color: blackColor,
        fontWeight: FontWeight.w600,
      ),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: const TextStyle(
        // fontFamily: FontFamily.iBMPlexSansArabic,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      inputDecorationTheme: InputDecorationTheme(
        suffixIconColor: mainColor.color,
        fillColor: scaffoldBackgroundColor,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: lightText.color),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: TextStyle(
        fontSize: 14,
        //  fontFamily: FontFamily.iBMPlexSansArabic,
        color: lightText.color,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: TextStyle(
        fontSize: 12,
        //  fontFamily: FontFamily.iBMPlexSansArabic,
        color: lightText.color,
        fontWeight: FontWeight.w400,
      ),
      fillColor: scaffoldBackgroundColor,
      filled: true,
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: errorColor.color),
        borderRadius: BorderRadius.circular(14.r),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mainBorder.color),
        borderRadius: BorderRadius.circular(14.r),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: mainBorder.color),
        borderRadius: BorderRadius.circular(14.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mainColor.color),
        borderRadius: BorderRadius.circular(14.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mainBorder.color),
        borderRadius: BorderRadius.circular(14.r),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.w),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: scaffoldBackgroundColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      actionsPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: scaffoldBackgroundColor,
      modalBackgroundColor: scaffoldBackgroundColor,
      shadowColor: transparent,
      surfaceTintColor: transparent,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      ),
    ),
  );

  static TextTheme get arabicTextTheme => const TextTheme(
    labelLarge: TextStyle(
      color: blackColor,
      fontSize: 14,
      fontFamily: 'tajawal',
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      color: blackColor,
      fontSize: 14,
      fontFamily: 'tajawal',
      fontWeight: FontWeight.w600,
    ),
    labelMedium: TextStyle(
      color: blackColor,
      fontSize: 14,
      fontFamily: 'tajawal',
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: TextStyle(
      color: blackColor,
      fontSize: 14,
      fontFamily: 'tajawal',
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      color: blackColor,
      fontSize: 14,
      fontFamily: 'tajawal',
      fontWeight: FontWeight.w300,
    ),
  );
}

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  const CustomPageTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final begin = LocaleKeys.lang.tr() == 'en'
        ? const Offset(1.0, 0.0)
        : const Offset(-1.0, 0.0);
    const end = Offset.zero;
    final inTween = Tween(
      begin: begin,
      end: end,
    ).chain(CurveTween(curve: Curves.easeOutCubic));

    return SlideTransition(position: animation.drive(inTween), child: child);
  }
}
