import 'package:dart_mappable/dart_mappable.dart';

part 'hospital_model.mapper.dart';

@MappableClass()
class HospitalModel with HospitalModelMappable {
  HospitalModel({
    required this.hospitalId,
    required this.hospitalName,
    required this.hospitalLat,
    required this.hospitalLong,
  });

  @MappableField(key: 'hospital_id')
  final String hospitalId;

  @MappableField(key: 'hospital_name')
  final String hospitalName;

  @MappableField(key: 'hospital_lat')
  final double hospitalLat;

  @MappableField(key: 'hospital_long')
  final double hospitalLong;
}
