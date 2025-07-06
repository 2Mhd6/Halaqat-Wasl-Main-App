import 'package:flutter/material.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';

// Widget for Edit Profile screen
class EditProfileField extends StatelessWidget { 
  const EditProfileField({
    super.key,
    this.initialValue,
    this.icon,
    this.hintText,
    required this.controller,
    this.validator,
    this.obsecureText = false, this.suffixIcon,
  });

  final TextEditingController controller;

  final String? initialValue;

  final String? icon;

  final String? hintText;
  
  final FormFieldValidator<String>? validator;

  final bool obsecureText;

  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 5.0,
        shadowColor: AppColors.profileItemBorderColor,
        child: TextFormField(
          // Bind the text controller to the field
          controller: controller,
          validator: validator,
           obscureText: obsecureText,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: AppColors.profileItemBorderColor),
            ),
            prefixIcon: icon != null ? Image.asset(icon!) : null,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
