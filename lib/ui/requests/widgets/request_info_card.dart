import 'package:flutter/material.dart';
import '../../../theme/app_text_style.dart';
import '../../../theme/app_color.dart';

class RequestInfoCard extends StatelessWidget {
  final String requestId;
  final String pickup;
  final String destination;
  final String time;
  final String status;

  const RequestInfoCard({
    Key? key,
    required this.requestId,
    required this.pickup,
    required this.destination,
    required this.time,
    required this.status,
  }) : super(key: key);

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColor.statusPendingBackground;
      case 'accepted':
        return AppColor.statusAcceptedBackground;
      case 'completed':
        return AppColor.statusCompletedBackground;
      default:
        return Colors.grey.shade300;
    }
  }

  Color getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColor.statusPendingText;
      case 'accepted':
        return AppColor.statusAcceptedText;
      case 'completed':
        return AppColor.statusCompletedText;
      default:
        return Colors.grey;
    }
  }

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    requestId.toUpperCase(),
                    style: AppTextStyle.sfProBold16,
                  ),
                  const SizedBox(height: 4),
                  Text(pickup, style: AppTextStyle.sfProW40014),
                  const SizedBox(height: 4),
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
              children: [
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
                const SizedBox(height: 16),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
