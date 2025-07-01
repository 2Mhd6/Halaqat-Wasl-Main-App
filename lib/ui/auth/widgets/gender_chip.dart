import 'package:flutter/material.dart';
import 'package:halaqat_wasl_main_app/extensions/screen_size.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';

class GenderChip extends StatelessWidget {
  const GenderChip({
    super.key,
    required this.label,
    required this.genderIndex,
    required this.selectedGender,
    required this.onPressed,
  });

  final String label;
  final int genderIndex;
  final int selectedGender;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {

    final isSelected = genderIndex == selectedGender;
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: context.getWidth(multiplied: 0.2),
        height: context.getHeight(multiplied: 0.04),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected? AppColors.primaryButtonColor : AppColors.secondaryTextColor,
          borderRadius: BorderRadius.circular(9),
          boxShadow: isSelected
              ? 
              null
              : 
              [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
              ],
        ),
        child: Text(label,style: isSelected ? AppTextStyle.sfPro60016WhiteTextColor : AppTextStyle.sfPro60016,),
      ),
    );
  }
}
