import 'package:flutter/material.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';

class AppTheme {
  static final theme = ThemeData(
    scaffoldBackgroundColor: AppColors.appBackgroundColor,
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.transparent
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.appBackgroundColor
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.appBackgroundColor
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryButtonColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
        overlayColor: Colors.transparent
      )
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryAppColor,
        textStyle: AppTextStyle.sfProBold14,
        splashFactory: NoSplash.splashFactory,
        overlayColor: Colors.transparent
      )
    )
  );
}
