
import 'package:flutter/material.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';

class MapSearchBar extends StatelessWidget {
  const MapSearchBar({super.key, required this.label, required this.searchBarController});
  final String label;
  final TextEditingController searchBarController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      height: 46,
      child: TextField(
        controller: searchBarController,
        cursorColor: AppColors.primaryTextColor,
        cursorHeight: 14,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hint: Text(label),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(width: 0, color: Colors.transparent),
          ),
    
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(width: 0, color: Colors.transparent),
          ),
    
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(width: 0, color: Colors.transparent),
          ),
    
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(width: 0, color: Colors.transparent),
          ),
        ),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
