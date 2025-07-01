import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';

class RequestInput extends StatelessWidget {
  const RequestInput({super.key, required this.label, required this.iconPath, required this.onPressed});

  final String label;
  final String iconPath;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 4),
            blurRadius: 8,
            color: Color.fromRGBO(53, 50, 215, 0.10),
          ),
        ],
      ),
      child: ListTile(
        onTap: onPressed,
        title: Text(label,style: AppTextStyle.sfPro60014SecondaryTextColor,),
        trailing: iconPath.isEmpty ? null : SvgPicture.asset(iconPath!),
      ),
    );
  }
}
