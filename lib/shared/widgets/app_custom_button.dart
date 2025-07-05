import 'package:flutter/material.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';

class AppCustomButton extends StatelessWidget {
  const AppCustomButton({super.key, this.label, this.loading  ,required this.buttonColor ,required this.width, required this.height, required this.onPressed});

  final String? label;
  final Widget? loading;
  final double width;
  final double height;
  final Color buttonColor; 
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, height),
        backgroundColor: buttonColor
      ),
      child: label != null ? Text(label!, style: AppTextStyle.sfProBold20,) : loading
    );
  }
}