import 'package:flutter/material.dart';
import 'package:halaqat_wasl_main_app/theme/app_color.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';

class SearchField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;

  const SearchField({super.key, required this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: const Icon(Icons.search, color: Colors.grey),
          hintText: hintText,
          hintStyle: AppTextStyle.sfPro14.copyWith(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
