import 'package:easy_localization/easy_localization.dart';

String formatDateTime(DateTime dateTime) {
  final datePart = DateFormat('EEE, MMM d, yyyy').format(dateTime);
  final timePart = DateFormat('h:mm a').format(dateTime);
  return '$datePart & $timePart';
}

String formattedRequest(DateTime data) {
  return DateFormat('dd/MM/yyyy - hh:mm a').format(data.add(Duration(hours: 3)));
  // return '${data.hour}:${data.minute.toString().padLeft(2, '0')}pm ${data.day}-${data.month}-${data.year}';
}
