import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/ui/requests/bloc/request_details_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:halaqat_wasl_main_app/ui/requests/request_details_screen.dart';

/// Widget to display address and data
Widget infoItem(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AppTextStyle.sfProW40014),
      const SizedBox(height: 8),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.fieldBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(value, style: AppTextStyle.sfProW40014),
      ),
    ],
  );
}

/// Status Chip
Widget buildStatusChip(String status) {
  Color background;
  Color textColor;

  switch (status) {
    case 'pending':
      background = AppColors.statusPendingBackground;
      textColor = AppColors.statusPendingText;
      break;
    case 'accepted':
      background = AppColors.statusAcceptedBackground;
      textColor = AppColors.statusAcceptedText;
      break;
    case 'cancelled':
      background = AppColors.statusCancelledBackground;
      textColor = AppColors.statusCancelledText;
      break;
    case 'completed':
    default:
      background = AppColors.statusCompletedBackground;
      textColor = AppColors.statusCompletedText;
      break;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: background, //Color changes depending on the order status.
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      (status.isNotEmpty) ? status[0].toUpperCase() + status.substring(1) : '',
      style: TextStyle(
        fontFamily: 'SFPro',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    ),
  );
}

/// descriptionBox for response from ManagerApp
Widget descriptionBox(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.fieldBackground,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(text, style: AppTextStyle.sfProW40014),
  );
}

/// Icon waiting
Widget waitingResponseIcon() {
  return Container(
    width: double.infinity,
    height: 100,
    decoration: BoxDecoration(
      color: AppColors.fieldBackground,
      borderRadius: BorderRadius.circular(10),
    ),
    child: const Center(child: Icon(Icons.access_time, size: 36)),
  );
}

/// Enable it only if the condition is: ComplaintWriting or ComplaintWritingButEmpty
Widget buildComplaintBox({
  required BuildContext context,
  required ComplaintStatus status,
  required TextEditingController controller,
}) {
  final bool isEditable =
      status == ComplaintStatus.writing ||
      status == ComplaintStatus.writingButEmpty;

  return TextFormField(
    controller: controller,
    enabled:
        isEditable, //Control the ability to write within the complaint field
    maxLines: 5,
    onChanged: (value) {
      context.read<RequestDetailsBloc>().add(
        value.trim().isEmpty
            ? WritingComplaintEmpty() //If the value is empty, the "Submit Complaint" button will be disabled
            : StartWritingComplaint(), //If the value is not empty, the "Submit Complaint" button will be activated.
      );
    },
    //decoration
    decoration: InputDecoration(
      hintText: 'request_details_screen.complaint_header'.tr(),
      filled: true,
      fillColor: AppColors.fieldBackground,
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
    style: AppTextStyle.sfProW40014,
  );
}
