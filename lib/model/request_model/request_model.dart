import 'package:dart_mappable/dart_mappable.dart';
import 'package:halaqat_wasl_main_app/model/charity_model/charity_model.dart';
import 'package:halaqat_wasl_main_app/model/complaint_model/complaint_model.dart';
import 'package:halaqat_wasl_main_app/model/driver_model/driver_model.dart';
import 'package:halaqat_wasl_main_app/model/hospital_model/hospital_model.dart';
import 'package:halaqat_wasl_main_app/model/user_model/user_model.dart';
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
    required this.destinationLat,
    required this.destinationLong,
    required this.requestDate,
    required this.status,
    this.note,
    this.user,
    this.charity,
    this.driver,
    this.hospital,
    this.complaint,
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

  

  @MappableField(key: 'destination_lat')
  final double destinationLat;

  @MappableField(key: 'destination_long')
  final double destinationLong;

  @MappableField(key: 'request_date')
  final DateTime requestDate;

  late final String status;

  final String? note;

  // Nested models for joined tables
  final UserModel? user;
  final CharityModel? charity;
  final DriverModel? driver;
  final HospitalModel? hospital;
  final ComplaintModel? complaint;
}
