import 'package:flutter/material.dart';
import 'package:halaqat_wasl_main_app/theme/app_color.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';

enum ComplaintStatus { writing, submitted, waitingResponse, responded }

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //change for test
    final status = ComplaintStatus.responded;

    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
            const Text(
              'Complaint Description',
              style: AppTextStyle.sfProBold16,
            ),
            Gap.gapH8,
            if (status == ComplaintStatus.writing ||
                status == ComplaintStatus.submitted ||
                status == ComplaintStatus.waitingResponse ||
                status == ComplaintStatus.responded)
              _complaintBox(status),
            Gap.gapH24,
            if (status == ComplaintStatus.waitingResponse ||
                status == ComplaintStatus.responded)
              const Text('Response', style: AppTextStyle.sfProBold16),
            if (status == ComplaintStatus.waitingResponse) _waitingResponse(),
            if (status == ComplaintStatus.responded)
              _responseBox(
                'We\'re sorry that happened to you and will try our best to make it happened again',
              ),
            Gap.gapH32,
            _bottomButton(status),
            Gap.gapH24,
          ],
        ),
      ),
    );
  }

  Widget _complaintBox(ComplaintStatus status) {
    final bool isEnabled = status == ComplaintStatus.writing;
    final String text = status == ComplaintStatus.writing
        ? ''
        : 'I swear I will never work with you again';

    return TextFormField(
      initialValue: text,
      enabled: isEnabled,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: 'Let us know what happened',
        filled: true,
        fillColor: AppColor.fieldBackground,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      style: AppTextStyle.sfProW40014,
    );
  }

  Widget _responseBox(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.fieldBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: AppTextStyle.sfProW40014),
    );
  }

  Widget _waitingResponse() {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: AppColor.fieldBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(child: Icon(Icons.access_time, size: 36)),
    );
  }

  Widget _bottomButton(ComplaintStatus status) {
    switch (status) {
      case ComplaintStatus.writing:
        return _mainButton(
          'Submit Complaint',
          AppColor.disabledButtonColor,
          false,
        );
      case ComplaintStatus.submitted:
        return _mainButton('Submit Complaint', AppColor.mainBlue, true);
      case ComplaintStatus.waitingResponse:
      case ComplaintStatus.responded:
        return _mainButton('Okay', AppColor.mainBlue, true);
    }
  }

  Widget _mainButton(String text, Color color, bool enabled) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: enabled ? () {} : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          disabledBackgroundColor: AppColor.disabledButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(text, style: AppTextStyle.sfProW60016),
      ),
    );
  }
}
