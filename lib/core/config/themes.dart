import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/app_colors.dart';

/// Google fonts constant setting: https://fonts.google.com/
class Themes {
  static const String darkTheme = 'darkTheme';
  static const String lightTheme = 'lightTheme';

  /// Build the App Theme
  static ThemeData buildTheme(
      {required BuildContext context, String theme = Themes.darkTheme}) {
    var isDarkTheme = theme == Themes.darkTheme;

    var fontFamily = 'TitilliumWeb';
    if (isDarkTheme) {
      return buildDarkTheme(context, fontFamily);
    }
    return buildLightTheme(context, fontFamily);
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static ThemeData buildDarkTheme(BuildContext context,
      [String fontFamily = 'Roboto']) {
    return ThemeData.dark().copyWith(
      primaryColor: AppColors.primaryColor,
      appBarTheme: _darkApBarTheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      buttonTheme: _buttonTheme(context),
      elevatedButtonTheme: _elevatedButtonTheme,
      cardColor: AppColors.darkCard,
      dividerColor: AppColors.divider,
      drawerTheme: const DrawerThemeData(backgroundColor: AppColors.darkCard),
      sliderTheme: _sliderTheme,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.darkBottomNavBar),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor),
    );
  }

  static ThemeData buildLightTheme(BuildContext context,
      [String fontFamily = 'TitilliumWeb']) {
    return ThemeData.light().copyWith(
      primaryColor: AppColors.primaryColor,
      appBarTheme: _lightAppBarTheme,
      scaffoldBackgroundColor: AppColors.lightBackground,
      buttonTheme: _buttonTheme(context),
      elevatedButtonTheme: _elevatedButtonTheme,
      dividerColor: AppColors.divider,
      cardColor: AppColors.lightCard,
      drawerTheme:
          DrawerThemeData(backgroundColor: Colors.white, width: 210.sp),
      sliderTheme: _sliderTheme,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightBottomNavBar,
      ),
      textTheme: TextTheme(
        headline1:
            TextStyle(color: AppColors.primaryColor, fontFamily: fontFamily),
        headline2:
            TextStyle(color: AppColors.primaryColor, fontFamily: fontFamily),
        headline3:
            TextStyle(color: AppColors.primaryColor, fontFamily: fontFamily),
        headline4:
            TextStyle(color: AppColors.primaryColor, fontFamily: fontFamily),
        headline5:
            TextStyle(color: AppColors.primaryColor, fontFamily: fontFamily),
        headline6:
            TextStyle(color: AppColors.primaryColor, fontFamily: fontFamily),
        bodyText1:
            TextStyle(color: AppColors.primaryColor, fontFamily: fontFamily),
        bodyText2: TextStyle(
            color: AppColors.darkText,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600),
        subtitle1: TextStyle(color: Colors.black, fontFamily: fontFamily),
        subtitle2: TextStyle(color: Colors.pinkAccent, fontFamily: fontFamily),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor),
      iconTheme: IconThemeData(color: AppColors.iconsColor),
    );
  }

  static const _darkApBarTheme = AppBarTheme(color: Colors.transparent);

  static const _lightAppBarTheme = AppBarTheme(
      centerTitle: true,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.grey),
      titleTextStyle: TextStyle(color: Colors.grey),
      color: Colors.transparent);
  static const _sliderTheme = SliderThemeData(
    activeTrackColor: AppColors.primaryColor,
    thumbColor: AppColors.primaryColor,
  );

  static _buttonTheme(context) => ButtonTheme.of(context).copyWith(
      buttonColor: AppColors.primaryColor, textTheme: ButtonTextTheme.primary);

  static final _elevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryColor,
  ));
}
