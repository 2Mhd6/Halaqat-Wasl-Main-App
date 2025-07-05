import 'package:easy_localization/easy_localization.dart';

String formatDateTime(DateTime dateTime) {
  final datePart = DateFormat('EEE, MMM d, yyyy').format(dateTime); 
  final timePart = DateFormat('h:mm a').format(dateTime);         
  return '$datePart & $timePart';
}