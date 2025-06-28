import 'package:flutter/material.dart';
import 'package:halaqat_wasl_main_app/theme/app_color.dart';

class AppTheme {
  static final theme = ThemeData(
    scaffoldBackgroundColor: AppColor.appBackgroundColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            ),
        ),
      ),
    ),
  );
}
