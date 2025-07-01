// lib/models/request_model.dart
class RequestModel {
  final String id;
  final String status;
  final String pickup;
  final String destination;
  final String dateTime;
  final String notes;
  final String driverName;

  RequestModel({
    required this.id,
    required this.status,
    required this.pickup,
    required this.destination,
    required this.dateTime,
    required this.notes,
    required this.driverName,
  });
}
