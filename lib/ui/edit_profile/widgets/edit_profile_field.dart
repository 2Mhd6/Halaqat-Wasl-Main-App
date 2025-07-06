import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';

// Widget for Edit Profile screen
class EditProfileField extends StatelessWidget { 
  const EditProfileField({
    super.key,
    this.icon,
    this.hintText,
    required this.controller,
    this.validator,
    this.obsecureText = false, this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.inputFormatters,
  });

  final TextEditingController controller;

  final TextInputType keyboardType;

  final String? icon;

  final String? hintText;
  
  final FormFieldValidator<String>? validator;

  final bool obsecureText;

  final Widget? suffixIcon;

  final ValueChanged<String>? onChanged;

  final List<TextInputFormatter>? inputFormatters;


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
           keyboardType: keyboardType,
           onChanged: onChanged,
          inputFormatters: inputFormatters,
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
