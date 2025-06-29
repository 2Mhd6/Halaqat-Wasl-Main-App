import 'package:flutter/material.dart';
import '../../../theme/app_text_style.dart';
import '../../../theme/app_color.dart';

class RequestInfoCard extends StatelessWidget {
  final String requestId; //#Req-001
  final String pickup;
  final String destination;
  final String time;
  final String status; //Order status based on Manager App and Driver App

  const RequestInfoCard({
    Key? key,
    required this.requestId,
    required this.pickup,
    required this.destination,
    required this.time,
    required this.status,
  }) : super(key: key);
  //Color for status
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColor.statusPendingBackground;
      case 'accepted':
        return AppColor.statusAcceptedBackground;
      case 'completed':
        return AppColor.statusCompletedBackground;
      case 'cancelled':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade300;
    }
  }

  //Color for text status
  Color getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColor.statusPendingText;
      case 'accepted':
        return AppColor.statusAcceptedText;
      case 'completed':
        return AppColor.statusCompletedText;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  //Color for request number Completed and Camcelled
  Color getRequestIdColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppColor.requestIdCompleted;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  //Card size and color
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                //Brief information for each request
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        requestId.toUpperCase(),
                        style: AppTextStyle.sfProBold16.copyWith(
                          color: getRequestIdColor(status),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: getStatusColor(status),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          status,
                          style: AppTextStyle.sfProW60012.copyWith(
                            color: getStatusTextColor(status),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.my_location, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(pickup, style: AppTextStyle.sfProW40014),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          destination,
                          style: AppTextStyle.sfProW40014,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    time,
                    style: AppTextStyle.sfProW60012.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                SizedBox(height: 16),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
