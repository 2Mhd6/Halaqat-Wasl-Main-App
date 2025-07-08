import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_main_app/repo/request/driver_repo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:halaqat_wasl_main_app/model/request_model/request_model.dart';
import 'package:halaqat_wasl_main_app/model/complaint_model/complaint_model.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_main_app/ui/requests/bloc/request_details_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:halaqat_wasl_main_app/ui/requests/widgets/request_details_widgets.dart';

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

  RequestDetailsScreen({
    super.key,
    required this.request,
    required this.complaint,
  });

  final TextEditingController _complaintController = TextEditingController();

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
        final isWithin2Hours = true;
        //     request.requestDate.difference(DateTime.now()).inMinutes <= 120;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.appBackgroundColor,
            elevation: 0,
            centerTitle: false,
            leading: const BackButton(color: Colors.black),
            title: Text(
              'request_details_screen.request_details'.tr(),
              style: AppTextStyle.sfProBold20,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'request_details_screen.request_number'.tr(),
                  style: AppTextStyle.sfProW40014,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '#${request.requestId.toUpperCase().substring(0, 5)}', //Displays the first 5 digits of the order number along with the chip color depending on the status
                      style: AppTextStyle.sfProBold16,
                    ),
                    buildStatusChip(status),
                  ],
                ),
                Gap.gapH16,
                infoItem(
                  'request_details_screen.pickup'.tr(),
                  'King Abdulaziz Road',
                ),
                Gap.gapH16,
                infoItem(
                  'request_details_screen.hospital_name'.tr(),
                  'Alnahdi Pharmacy, Riyadh',
                ),
                Gap.gapH16,
                infoItem(
                  'request_details_screen.dare_time'.tr(),
                  _formatDate(request.requestDate),
                ),
                Gap.gapH16,
                infoItem(
                  'request_details_screen.additional_notes'.tr(),
                  request.note ?? 'No notes',
                ),
                Gap.gapH16,

                //Driver name is not displayed in pending and cancelled statuses.
                if (status != 'pending' && status != 'cancelled')
                  FutureBuilder<String?>(
                    //Wait for the driver name to be fetched from Supabase
                    future: DriverRepo.getDriverNameById(
                      request.driverId ?? '',
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return const SizedBox();
                      final driverName = snapshot.data ?? 'No driver assigned';
                      return infoItem(
                        'request_details_screen.driver_info'.tr(),
                        driverName,
                      );
                    },
                  ),

                // Completed status -> The complaint box appears with the appropriate button
                if (status == 'completed') ...[
                  Gap.gapH24,
                  Text(
                    'request_details_screen.complaint_description'.tr(),
                    style: AppTextStyle.sfProBold16,
                  ),
                  Gap.gapH8,
                  buildComplaintBox(
                    context: context,
                    status: complaintStatus,
                    controller: _complaintController,
                  ),
                  if (complaintStatus == ComplaintStatus.waitingResponse ||
                      complaintStatus == ComplaintStatus.responded) ...[
                    Gap.gapH24,
                    Text(
                      'request_details_screen.response'.tr(),
                      style: AppTextStyle.sfProBold16,
                    ),
                    Gap.gapH8,
                    complaintStatus == ComplaintStatus.waitingResponse
                        ? waitingResponseIcon()
                        : descriptionBox(complaint?.response ?? ''),
                  ],
                  Gap.gapH32,
                  // Status button SubmitComplaint & Okay
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
                                  SubmitComplaint(
                                    _complaintController.text.trim(),
                                  ),
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
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _makePhoneCall('0561577826'),
                          icon: const Icon(
                            Icons.phone,
                            color: AppColors.mainBlue,
                          ),
                          label: Text(
                            'request_details_screen.call'.tr(),
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
                          label: Text(
                            'request_details_screen.message'.tr(),
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
                      child: Text('Okay', style: AppTextStyle.sfProW60016),
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
                        context.read<RequestDetailsBloc>().add(CancelRequest());
                        Navigator.of(context).pop(true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cancelButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'request_details_screen.cancel'.tr(),
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
                      child: Text('Okay', style: AppTextStyle.sfProW60016),
                    ),
                  ),
                ],

                Gap.gapH24,
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}pm ${dateTime.day}-${dateTime.month}-${dateTime.year}';
  }

  bool _getMainButtonEnabled(ComplaintStatus status) {
    return status == ComplaintStatus.writing ||
        status == ComplaintStatus.waitingResponse ||
        status == ComplaintStatus.responded;
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) await launchUrl(url);
  }

  void _openWhatsAppChat(String phoneNumber) async {
    final Uri url = Uri.parse('https://wa.me/$phoneNumber');
    if (await canLaunchUrl(url)) await launchUrl(url);
  }
}
