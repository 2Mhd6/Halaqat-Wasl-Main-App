import 'package:flutter/material.dart';

import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';

enum ComplaintStatus {
  writing,
  submitted,
  waitingResponse,
  responded,
  writingButEmpty,
}

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({
    super.key,
    this.complaintStatus = ComplaintStatus.writingButEmpty,
  });

  final ComplaintStatus complaintStatus;

  @override
  Widget build(BuildContext context) {
    const status =
        'completed'; //Represents the status of the request, and can be changed to:pending، accepted، completed
    final bool isWithin2Hours =
        true; // Call / Message .. temporary (2 hours or less left until your order)

    //backgroundColor and AppBar
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        elevation: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.black),
        title: const Text('Request Details', style: AppTextStyle.sfProBold20),
      ),
      //Allows content to be scrolled vertically
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Request Number', style: AppTextStyle.sfProW40014),
            //The order number is displayed and on the right is a small colored slide representing the status (Pending, Accepted, Completed).
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('#Req-001', style: AppTextStyle.sfProBold16),
                _buildStatusChip(status),
              ],
            ),
            Gap.gapH16,
            //Details Order
            _infoItem('Pick Up', 'King Abdulaziz Road'),
            Gap.gapH16,
            _infoItem('Destination', 'Alnahdi Pharmacy'),
            Gap.gapH16,
            _infoItem('Date & Time', '12:59pm 16 May, 2025'),
            Gap.gapH16,
            _infoItem('Additional Notes', 'I need chair I need ch....'),
            Gap.gapH16,
            _infoItem('Driver Name', 'Osama Abdullah'),
            //The only status in which additional details are displayed is the completed status. The rest of the statuses change the button color and status only
            if (status == 'completed') ...[
              Gap.gapH24,
              const Text(
                'Complaint Description',
                style: AppTextStyle.sfProBold16,
              ),
              Gap.gapH8,
              _buildComplaintBox(complaintStatus),
              if (complaintStatus == ComplaintStatus.waitingResponse ||
                  complaintStatus == ComplaintStatus.responded) ...[
                Gap.gapH24,
                const Text('Response', style: AppTextStyle.sfProBold16),
                Gap.gapH8,
                if (complaintStatus == ComplaintStatus.waitingResponse)
                  _waitingResponse()
                else
                  _descriptionBox(
                    'We\'re sorry that happened to you and will try our best to make it happened again',
                  ),
              ],
            ],
            if (status == 'accepted' && isWithin2Hours) ...[
              //It is a logical condition used inside a column to display two additional buttons only in a certain condition
              Gap.gapH16,
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.phone, color: AppColors.mainBlue),
                      label: const Text(
                        'Call',
                        style: AppTextStyle.sfProW60016,
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.mainBlue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Gap.gapW16,
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.message, size: 20),
                      label: const Text(
                        'Message',
                        style: AppTextStyle.sfProW60016,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            Gap.gapH32,
            SizedBox(
              width: double.infinity,
              height: 48,
              //ElevatedButton based on status
              child: ElevatedButton(
                onPressed: _getMainButtonEnabled(complaintStatus)
                    ? () {}
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getButtonColor(status),
                  disabledBackgroundColor: AppColors.disabledButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  _getButtonText(status),
                  style: AppTextStyle.sfProW60016.copyWith(color: Colors.white),
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
        //widget for style box
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

  //widget for describtion box
  Widget _descriptionBox(String text) {
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

  //Responsible for displaying the complaint description field
  Widget _buildComplaintBox(ComplaintStatus status) {
    final bool isEnabled = status == ComplaintStatus.writing;
    final String text = status == ComplaintStatus.writing
        ? ''
        : 'I swear I will never work with you again';

    return TextFormField(
      initialValue: text,
      enabled: isEnabled, //Can it be modified?
      maxLines: 5, //number lines
      decoration: InputDecoration(
        hintText: 'Let us know what happened', //hint
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

  //To show that the system is "awaiting management response"
  Widget _waitingResponse() {
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

  //widget for switch status, the status slide displays (color and font) based on the status
  Widget _buildStatusChip(String status) {
    Color background;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'pending':
        background = AppColors.statusPendingBackground;
        textColor = AppColors.statusPendingText;
        break;
      case 'accepted':
        background = AppColors.statusAcceptedBackground;
        textColor = AppColors.statusAcceptedText;
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

  //Returns the appropriate text for the button depending on the condition
  String _getButtonText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Cancel';
      case 'accepted':
      case 'completed':
      default:
        return 'Submit Complaint';
    }
  }

  //Returns the appropriate button color
  Color _getButtonColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.cancelButtonColor;
      case 'accepted':
      case 'completed':
      default:
        return AppColors.mainBlue;
    }
  }

  //Determine if the main button should be enabled based on the complaint status
  bool _getMainButtonEnabled(ComplaintStatus status) {
    return status == ComplaintStatus.writing ||
        status == ComplaintStatus.submitted ||
        status == ComplaintStatus.responded ||
        status == ComplaintStatus.waitingResponse;
  }
}
