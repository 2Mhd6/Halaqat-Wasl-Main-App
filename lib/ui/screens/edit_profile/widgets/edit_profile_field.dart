import 'package:flutter/material.dart';
import 'package:halaqat_wasl_main_app/theme/app_color.dart';


// Widget for Edit Profile screen
class EditProfileField extends StatelessWidget { 
  const EditProfileField({super.key, this.initialValue, this.icon, this.hintText, required this.controller, });
  final TextEditingController controller;
  final String? initialValue;
  final String? icon;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 12.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 5.0,
         shadowColor: AppColor.profileItemBorderColor,
        child: TextFormField(
          // Bind the text controller to the field
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: AppColor.profileItemBorderColor),
            ),
            prefixIcon: icon != null? Image.asset(icon!) : null,
            filled: true,
            fillColor: Colors.white
          ),
        ),
      ),
    );
  }
}

