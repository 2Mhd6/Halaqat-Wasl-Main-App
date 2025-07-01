import 'package:flutter/material.dart';
import 'package:halaqat_wasl_main_app/extensions/screen_size.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';

class EditProfileSuccessSheet extends StatelessWidget {
  const EditProfileSuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Successful',
              style: AppTextStyle.sfProW60020,
            ),
            Gap.gapH16,
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.primaryButtonColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded, color: Colors.white, size: 36),
            ),
            Gap.gapH16,
            const Text(
              'You have successfully changed password',
              textAlign: TextAlign.center,
              style: AppTextStyle.sfPro14,
            ),
            Gap.gapH16,
          ],
        ),
      ),
    );
  }
}
