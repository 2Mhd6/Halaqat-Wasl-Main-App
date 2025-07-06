import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:halaqat_wasl_main_app/model/request_model/request_model.dart';
import 'package:halaqat_wasl_main_app/model/complaint_model/complaint_model.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_main_app/ui/requests/bloc/request_details_bloc.dart';

enum ComplaintStatus {
  //Represents each case of complaint
  writing,
  submitted,
  waitingResponse,
  responded,
  writingButEmpty,
}

class RequestDetailsScreen extends StatelessWidget {
  final RequestModel request;
  final ComplaintModel? complaint;

  const RequestDetailsScreen({
    super.key,
    required this.request,
    required this.complaint,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestDetailsBloc, RequestDetailsState>(
      //Every time the Bloc state changes, the screen is rebuilt
      builder: (context, state) {
        ComplaintStatus complaintStatus;

        if (state is ComplaintWriting) {
          complaintStatus = ComplaintStatus.writing;
        } else if (state is ComplaintSubmitted) {
          complaintStatus = ComplaintStatus.submitted;
        } else if (state is ComplaintWaitingResponse) {
          complaintStatus = ComplaintStatus.waitingResponse;
        } else if (state is ComplaintResponded) {
          complaintStatus = ComplaintStatus.responded;
        } else if (state is ComplaintWritingButEmpty) {
          complaintStatus = ComplaintStatus.writingButEmpty;
        } else {
          complaintStatus = ComplaintStatus.writingButEmpty;
        }

        final status = request.status
            .toLowerCase(); //status variable for request status
        // final isWithin2Hours =
        //     request.requestDate.difference(DateTime.now()).inMinutes <= 120;
        final isWithin2Hours = true;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.appBackgroundColor,
            elevation: 0,
            centerTitle: false,
            leading: const BackButton(color: Colors.black),
            title: const Text(
              'Request Details',
              style: AppTextStyle.sfProBold20,
            ),
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
                    Text(
                      '#${request.requestId.toUpperCase().substring(0, 5)}', //Displays the first 5 digits of the order number along with the chip color depending on the status
                      style: AppTextStyle.sfProBold16,
                    ),
                    _buildStatusChip(status),
                  ],
                ),
                Gap.gapH16,
                _infoItem('Pick Up', 'King Abdulaziz Road'),
                Gap.gapH16,
                _infoItem('Destination', 'Alnahdi Pharmacy, Riyadh'),
                Gap.gapH16,
                _infoItem('Date & Time', _formatDate(request.requestDate)),
                Gap.gapH16,
                _infoItem('Additional Notes', request.note ?? 'No notes'),
                Gap.gapH16,
                //Driver name is not displayed in pending and cancelled statuses.
                if (status != 'pending' && status != 'cancelled')
                  _infoItem(
                    'Driver Name',
                    request.driverId ?? 'No driver assigned',
                  ),

                // Completed status -> The complaint box appears with the appropriate button
                if (status == 'completed') ...[
                  Gap.gapH24,
                  const Text(
                    'Complaint Description',
                    style: AppTextStyle.sfProBold16,
                  ),
                  Gap.gapH8,
                  _buildComplaintBox(context, complaintStatus),
                  //This section is only displayed if the complaint is pending or has been responded to.
                  if (complaintStatus == ComplaintStatus.waitingResponse ||
                      complaintStatus == ComplaintStatus.responded) ...[
                    Gap.gapH24,
                    const Text('Response', style: AppTextStyle.sfProBold16),
                    Gap.gapH8,
                    if (complaintStatus == ComplaintStatus.waitingResponse)
                      _waitingResponse()
                    else
                      _descriptionBox(
                        complaint?.response ?? '',
                      ), //Always receives a text, even if there is no reply so as not to cause a crash or show a white screen.
                  ],
                  Gap.gapH32,
                  // 🔵 زر "Submit Complaint" أو "Okay"
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _getMainButtonEnabled(complaintStatus)
                          ? () {
                              if (complaintStatus ==
                                  ComplaintStatus.responded) {
                                Navigator.of(
                                  context,
                                ).pop(); //The user only exits the page after reading the response.
                              } else if (complaintStatus ==
                                  ComplaintStatus.writing) {
                                context.read<RequestDetailsBloc>().add(
                                  SubmitComplaint(), //The user writes a complaint, presses the button to send it to the BloC until the status changes.
                                );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getMainButtonEnabled(complaintStatus)
                            ? AppColors.mainBlue
                            : AppColors.disabledButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      //The text inside the button changes depending on the state.
                      child: Text(
                        (complaintStatus == ComplaintStatus.responded ||
                                complaintStatus ==
                                    ComplaintStatus.waitingResponse)
                            ? 'Okay'
                            : 'Submit Complaint',
                        style: AppTextStyle.sfProW60016.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Gap.gapH24,
                ],

                // Accepted status -> The request is accepted and there are less than or equal to two hours remaining until the request deadline.
                if (status == 'accepted' && isWithin2Hours) ...[
                  Gap.gapH24,
                  Row(
                    //If the driver is nearby, the user can call him or send him a message on WhatsApp.
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _makePhoneCall('0561577826'),
                          icon: const Icon(
                            Icons.phone,
                            color: AppColors.mainBlue,
                          ),
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
                          onPressed: () => _openWhatsAppChat('966561577826'),
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
                  Gap.gapH24,
                  // If more than two hours remain, the Okay button will appear.
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Okay',
                        style: AppTextStyle.sfProW60016,
                      ),
                    ),
                  ),
                ],

                // Pending status -> Waiting Accepted from ManagerApp
                if (status == 'pending') ...[
                  Gap.gapH32,
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<RequestDetailsBloc>().add(
                          CancelRequest(),
                        ); //When the button is pressed, a CancelRequest event is sent to the Bloc to change the state to cancelled.
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cancelButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: AppTextStyle.sfProW60016,
                      ),
                    ),
                  ),
                ],
                //Cancel status
                if (status == 'cancelled' || state is RequestCancelled) ...[
                  Gap.gapH32,
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      child: const Text(
                        'Okay',
                        style: AppTextStyle.sfProW60016,
                      ),
                    ),
                  ),
                ],

                Gap.gapH24,

                Gap.gapH24,
              ],
            ),
          ),
        );
      },
    );
  }

  // Enable it only if the condition is: ComplaintWriting or ComplaintWritingButEmpty
  Widget _buildComplaintBox(BuildContext context, ComplaintStatus status) {
    final bool isEditable =
        status == ComplaintStatus.writing ||
        status == ComplaintStatus.writingButEmpty;

    return TextFormField(
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
        hintText: 'Let us know what happened',
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

  // descriptionBox for response from ManagerApp
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

  // Status Chip
  Widget _buildStatusChip(String status) {
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
        (status.isNotEmpty)
            ? status[0].toUpperCase() + status.substring(1)
            : '',
        style: TextStyle(
          fontFamily: 'SFPro',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  // Widget to display address and data
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
            color: AppColors.fieldBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(value, style: AppTextStyle.sfProW40014),
        ),
      ],
    );
  }

  // Icon waiting
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

  // Format Date
  String _formatDate(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}pm ${dateTime.day}-${dateTime.month}-${dateTime.year}';
  }

  //Enable complaint button by status
  bool _getMainButtonEnabled(ComplaintStatus status) {
    return status == ComplaintStatus.writing ||
        status == ComplaintStatus.waitingResponse ||
        status == ComplaintStatus.responded;
  }

  //url_launcher package
  // Calling -> Convert the number to a link, check if this link can be played, if so, open the calling app
  void _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  // WhatsApp massage -> Takes the phone number as a String and opens a WhatsApp conversation with it, building a WhatsApp link using the WhatsApp API
  void _openWhatsAppChat(String phoneNumber) async {
    final Uri url = Uri.parse('https://wa.me/$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
