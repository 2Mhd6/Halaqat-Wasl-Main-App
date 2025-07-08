import 'package:dart_mappable/dart_mappable.dart';

part 'request_model.mapper.dart';

@MappableClass()
class RequestModel with RequestModelMappable {
  RequestModel({
    required this.requestId,
    required this.userId,
    required this.charityId,
    required this.hospitalId,
    required this.complaintId,
    required this.driverId,
    required this.pickupLat,
    required this.pickupLong,
    required this.pickUpReadableAddress,
    required this.destinationLat,
    required this.destinationLong,
    required this.destinationReadableAddress,
    required this.requestDate,
    required this.status,
    this.note,
  });

  @MappableField(key: 'request_id')
  final String requestId;

  @MappableField(key: 'user_id')
  final String userId;

  @MappableField(key: 'charity_id')
  final String? charityId;

  @MappableField(key: 'hospital_id')
  final String hospitalId;

  @MappableField(key: 'complaint_id')
  final String? complaintId;

  @MappableField(key: 'driver_id')
  final String? driverId;

  @MappableField(key: 'pick_up_lat')
  final double pickupLat;

  @MappableField(key: 'pick_up_long')
  final double pickupLong;

  @MappableField(key: 'pick_up_readable_address')
  final String pickUpReadableAddress;

  @MappableField(key: 'destination_lat')
  final double destinationLat;

  @MappableField(key: 'destination_long')
  final double destinationLong;

  @MappableField(key: 'destination_readable_address')
  final String destinationReadableAddress;

  @MappableField(key: 'request_date')
  final DateTime requestDate;

  String status;

  final String? note;
}
