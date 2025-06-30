import 'package:flutter/material.dart';
import 'package:halaqat_wasl_main_app/theme/app_color.dart';

class ProfileItem {
  final String hintText;
  final String icon;

  ProfileItem({required this.hintText, required this.icon});
}

// Widget to display 'profile item' in the UI
class ProfileItemWidget extends StatelessWidget {
  const ProfileItemWidget({super.key, required this.item, this.onTap});

  final ProfileItem item;

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 5.0,
        shadowColor: AppColor.profileItemBorderColor,
        child: TextFormField(
          onTap: onTap,
          enabled: false,
          decoration: InputDecoration(
            hintText: item.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: AppColor.profileItemBorderColor),
            ),
            prefixIcon: Image.asset(item.icon),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
