import 'package:flutter/material.dart';
import 'package:halaqat_wasl_main_app/theme/app_color.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const status = 'accepted'; 

    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.appBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
        title: const Text('Request Details', style: AppTextStyle.sfProBold20),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Request Number', style: AppTextStyle.sfProW40014),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('#Req-001', style: AppTextStyle.sfProBold16),
                _buildStatusChip(status),
              ],
            ),
            Gap.gapH16,
            _infoItem('Pick Up', 'King Abdulaziz Road'),
            Gap.gapH16,
            _infoItem('Destination', 'Alnahdi Pharmacy'),
            Gap.gapH16,
            _infoItem('Date & Time', '12:59pm 16 May, 2025'),
            Gap.gapH16,
            _infoItem('Additional Notes', 'I need chair I need ch....'),
            Gap.gapH16,
            _infoItem('Driver Name', 'Osama Abdullah'),

            if (status == 'completed') ...[
              Gap.gapH24,
              const Text('Complaint Description', style: AppTextStyle.sfProBold16),
              Gap.gapH8,
              _descriptionBox('I swear I will never work with you again'),
              Gap.gapH24,
              const Text('Response', style: AppTextStyle.sfProBold16),
              Gap.gapH8,
              _descriptionBox(
                'We\'re sorry that happened to you and will try our best to make it happened again',
              ),
              Gap.gapH24,
              // const Text('Rating', style: AppTextStyle.sfProBold16),
              // Gap.gapH8,
              // Row(
              //   children: List.generate(5, (index) {
              //     return const Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 4),
              //       child: Icon(Icons.star, color: AppColor.selectedStarRatingColor),
              //     );
              //   }),
              // ),
            ],
            Gap.gapH32,
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getButtonColor(status),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  _getButtonText(status),
                  style: AppTextStyle.sfProW60016.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Gap.gapH24,
          ],
        ),
      ),
    );
  }

  Widget _infoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.sfProW40014),
        Gap.gapH8,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColor.fieldBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(value, style: AppTextStyle.sfProW40014),
        ),
      ],
    );
  }

  Widget _descriptionBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.fieldBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: AppTextStyle.sfProW40014),
    );
  }

  Widget _buildStatusChip(String status) {
    Color background;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'pending':
        background = AppColor.statusPendingBackground;
        textColor = AppColor.statusPendingText;
        break;
      case 'accepted':
        background = AppColor.statusAcceptedBackground;
        textColor = AppColor.statusAcceptedText;
        break;
      case 'completed':
      default:
        background = AppColor.statusCompletedBackground;
        textColor = AppColor.statusCompletedText;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status[0].toUpperCase() + status.substring(1),
        style: TextStyle(
          fontFamily: 'SFPro',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  String _getButtonText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Cancel';
      case 'accepted':
        return 'Okay';
      case 'completed':
      default:
        return 'Okay';
    }
  }

  Color _getButtonColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColor.cancelButtonColor;
      case 'accepted':
      case 'completed':
      default:
        return AppColor.mainBlue;
    }
  }
}
