
  import 'package:flutter/material.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';

void appSnackBar({required BuildContext context,required String message, required isSuccess}) {
    
    final color = isSuccess ? AppColors.completedBackgroundColor: AppColors.errorColor ; // background color
    final icon = isSuccess ? Icons.check_circle : Icons.error; // icon type

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),), // rounded corners
        margin:  EdgeInsets.symmetric(horizontal: 16,vertical: 16), // margin
        duration: const Duration(seconds: 2),
        content: Row(
        children: [
          Icon(icon, color: Colors.white), // leading icon
          Gap.gapW16, // horizontal space
          Expanded(child: Text(message,style: AppTextStyle.sfPro60014.copyWith(color: Colors.white),),
          ),
        ],
      ),
      ),
    );
  }

