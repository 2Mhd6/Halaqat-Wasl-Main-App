// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'request_model.dart';

class RequestModelMapper extends ClassMapperBase<RequestModel> {
  RequestModelMapper._();

  static RequestModelMapper? _instance;
  static RequestModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RequestModelMapper._());
      UserModelMapper.ensureInitialized();
      CharityModelMapper.ensureInitialized();
      DriverModelMapper.ensureInitialized();
      HospitalModelMapper.ensureInitialized();
      ComplaintModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RequestModel';

  static String _$requestId(RequestModel v) => v.requestId;
  static const Field<RequestModel, String> _f$requestId =
      Field('requestId', _$requestId, key: r'request_id');
  static String _$userId(RequestModel v) => v.userId;
  static const Field<RequestModel, String> _f$userId =
      Field('userId', _$userId, key: r'user_id');
  static String? _$charityId(RequestModel v) => v.charityId;
  static const Field<RequestModel, String> _f$charityId =
      Field('charityId', _$charityId, key: r'charity_id');
  static String _$hospitalId(RequestModel v) => v.hospitalId;
  static const Field<RequestModel, String> _f$hospitalId =
      Field('hospitalId', _$hospitalId, key: r'hospital_id');
  static String? _$complaintId(RequestModel v) => v.complaintId;
  static const Field<RequestModel, String> _f$complaintId =
      Field('complaintId', _$complaintId, key: r'complaint_id');
  static String? _$driverId(RequestModel v) => v.driverId;
  static const Field<RequestModel, String> _f$driverId =
      Field('driverId', _$driverId, key: r'driver_id');
  static double _$pickupLat(RequestModel v) => v.pickupLat;
  static const Field<RequestModel, double> _f$pickupLat =
      Field('pickupLat', _$pickupLat, key: r'pick_up_lat');
  static double _$pickupLong(RequestModel v) => v.pickupLong;
  static const Field<RequestModel, double> _f$pickupLong =
      Field('pickupLong', _$pickupLong, key: r'pick_up_long');
  static double _$destinationLat(RequestModel v) => v.destinationLat;
  static const Field<RequestModel, double> _f$destinationLat =
      Field('destinationLat', _$destinationLat, key: r'destination_lat');
  static double _$destinationLong(RequestModel v) => v.destinationLong;
  static const Field<RequestModel, double> _f$destinationLong =
      Field('destinationLong', _$destinationLong, key: r'destination_long');
  static DateTime _$requestDate(RequestModel v) => v.requestDate;
  static const Field<RequestModel, DateTime> _f$requestDate =
      Field('requestDate', _$requestDate, key: r'request_date');
  static String _$status(RequestModel v) => v.status;
  static const Field<RequestModel, String> _f$status =
      Field('status', _$status);
  static String? _$note(RequestModel v) => v.note;
  static const Field<RequestModel, String> _f$note =
      Field('note', _$note, opt: true);
  static UserModel? _$user(RequestModel v) => v.user;
  static const Field<RequestModel, UserModel> _f$user =
      Field('user', _$user, opt: true);
  static CharityModel? _$charity(RequestModel v) => v.charity;
  static const Field<RequestModel, CharityModel> _f$charity =
      Field('charity', _$charity, opt: true);
  static DriverModel? _$driver(RequestModel v) => v.driver;
  static const Field<RequestModel, DriverModel> _f$driver =
      Field('driver', _$driver, opt: true);
  static HospitalModel? _$hospital(RequestModel v) => v.hospital;
  static const Field<RequestModel, HospitalModel> _f$hospital =
      Field('hospital', _$hospital, opt: true);
  static ComplaintModel? _$complaint(RequestModel v) => v.complaint;
  static const Field<RequestModel, ComplaintModel> _f$complaint =
      Field('complaint', _$complaint, opt: true);

  @override
  final MappableFields<RequestModel> fields = const {
    #requestId: _f$requestId,
    #userId: _f$userId,
    #charityId: _f$charityId,
    #hospitalId: _f$hospitalId,
    #complaintId: _f$complaintId,
    #driverId: _f$driverId,
    #pickupLat: _f$pickupLat,
    #pickupLong: _f$pickupLong,
    #destinationLat: _f$destinationLat,
    #destinationLong: _f$destinationLong,
    #requestDate: _f$requestDate,
    #status: _f$status,
    #note: _f$note,
    #user: _f$user,
    #charity: _f$charity,
    #driver: _f$driver,
    #hospital: _f$hospital,
    #complaint: _f$complaint,
  };

  static RequestModel _instantiate(DecodingData data) {
    return RequestModel(
        requestId: data.dec(_f$requestId),
        userId: data.dec(_f$userId),
        charityId: data.dec(_f$charityId),
        hospitalId: data.dec(_f$hospitalId),
        complaintId: data.dec(_f$complaintId),
        driverId: data.dec(_f$driverId),
        pickupLat: data.dec(_f$pickupLat),
        pickupLong: data.dec(_f$pickupLong),
        destinationLat: data.dec(_f$destinationLat),
        destinationLong: data.dec(_f$destinationLong),
        requestDate: data.dec(_f$requestDate),
        status: data.dec(_f$status),
        note: data.dec(_f$note),
        user: data.dec(_f$user),
        charity: data.dec(_f$charity),
        driver: data.dec(_f$driver),
        hospital: data.dec(_f$hospital),
        complaint: data.dec(_f$complaint));
  }

  @override
  final Function instantiate = _instantiate;

  static RequestModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RequestModel>(map);
  }

  static RequestModel fromJson(String json) {
    return ensureInitialized().decodeJson<RequestModel>(json);
  }
}

mixin RequestModelMappable {
  String toJson() {
    return RequestModelMapper.ensureInitialized()
        .encodeJson<RequestModel>(this as RequestModel);
  }

  Map<String, dynamic> toMap() {
    return RequestModelMapper.ensureInitialized()
        .encodeMap<RequestModel>(this as RequestModel);
  }

  RequestModelCopyWith<RequestModel, RequestModel, RequestModel> get copyWith =>
      _RequestModelCopyWithImpl<RequestModel, RequestModel>(
          this as RequestModel, $identity, $identity);
  @override
  String toString() {
    return RequestModelMapper.ensureInitialized()
        .stringifyValue(this as RequestModel);
  }

  @override
  bool operator ==(Object other) {
    return RequestModelMapper.ensureInitialized()
        .equalsValue(this as RequestModel, other);
  }

  @override
  int get hashCode {
    return RequestModelMapper.ensureInitialized()
        .hashValue(this as RequestModel);
  }
}

extension RequestModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RequestModel, $Out> {
  RequestModelCopyWith<$R, RequestModel, $Out> get $asRequestModel =>
      $base.as((v, t, t2) => _RequestModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RequestModelCopyWith<$R, $In extends RequestModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  UserModelCopyWith<$R, UserModel, UserModel>? get user;
  CharityModelCopyWith<$R, CharityModel, CharityModel>? get charity;
  DriverModelCopyWith<$R, DriverModel, DriverModel>? get driver;
  HospitalModelCopyWith<$R, HospitalModel, HospitalModel>? get hospital;
  ComplaintModelCopyWith<$R, ComplaintModel, ComplaintModel>? get complaint;
  $R call(
      {String? requestId,
      String? userId,
      String? charityId,
      String? hospitalId,
      String? complaintId,
      String? driverId,
      double? pickupLat,
      double? pickupLong,
      double? destinationLat,
      double? destinationLong,
      DateTime? requestDate,
      String? status,
      String? note,
      UserModel? user,
      CharityModel? charity,
      DriverModel? driver,
      HospitalModel? hospital,
      ComplaintModel? complaint});
  RequestModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RequestModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RequestModel, $Out>
    implements RequestModelCopyWith<$R, RequestModel, $Out> {
  _RequestModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RequestModel> $mapper =
      RequestModelMapper.ensureInitialized();
  @override
  UserModelCopyWith<$R, UserModel, UserModel>? get user =>
      $value.user?.copyWith.$chain((v) => call(user: v));
  @override
  CharityModelCopyWith<$R, CharityModel, CharityModel>? get charity =>
      $value.charity?.copyWith.$chain((v) => call(charity: v));
  @override
  DriverModelCopyWith<$R, DriverModel, DriverModel>? get driver =>
      $value.driver?.copyWith.$chain((v) => call(driver: v));
  @override
  HospitalModelCopyWith<$R, HospitalModel, HospitalModel>? get hospital =>
      $value.hospital?.copyWith.$chain((v) => call(hospital: v));
  @override
  ComplaintModelCopyWith<$R, ComplaintModel, ComplaintModel>? get complaint =>
      $value.complaint?.copyWith.$chain((v) => call(complaint: v));
  @override
  $R call(
          {String? requestId,
          String? userId,
          Object? charityId = $none,
          String? hospitalId,
          Object? complaintId = $none,
          Object? driverId = $none,
          double? pickupLat,
          double? pickupLong,
          double? destinationLat,
          double? destinationLong,
          DateTime? requestDate,
          String? status,
          Object? note = $none,
          Object? user = $none,
          Object? charity = $none,
          Object? driver = $none,
          Object? hospital = $none,
          Object? complaint = $none}) =>
      $apply(FieldCopyWithData({
        if (requestId != null) #requestId: requestId,
        if (userId != null) #userId: userId,
        if (charityId != $none) #charityId: charityId,
        if (hospitalId != null) #hospitalId: hospitalId,
        if (complaintId != $none) #complaintId: complaintId,
        if (driverId != $none) #driverId: driverId,
        if (pickupLat != null) #pickupLat: pickupLat,
        if (pickupLong != null) #pickupLong: pickupLong,
        if (destinationLat != null) #destinationLat: destinationLat,
        if (destinationLong != null) #destinationLong: destinationLong,
        if (requestDate != null) #requestDate: requestDate,
        if (status != null) #status: status,
        if (note != $none) #note: note,
        if (user != $none) #user: user,
        if (charity != $none) #charity: charity,
        if (driver != $none) #driver: driver,
        if (hospital != $none) #hospital: hospital,
        if (complaint != $none) #complaint: complaint
      }));
  @override
  RequestModel $make(CopyWithData data) => RequestModel(
      requestId: data.get(#requestId, or: $value.requestId),
      userId: data.get(#userId, or: $value.userId),
      charityId: data.get(#charityId, or: $value.charityId),
      hospitalId: data.get(#hospitalId, or: $value.hospitalId),
      complaintId: data.get(#complaintId, or: $value.complaintId),
      driverId: data.get(#driverId, or: $value.driverId),
      pickupLat: data.get(#pickupLat, or: $value.pickupLat),
      pickupLong: data.get(#pickupLong, or: $value.pickupLong),
      destinationLat: data.get(#destinationLat, or: $value.destinationLat),
      destinationLong: data.get(#destinationLong, or: $value.destinationLong),
      requestDate: data.get(#requestDate, or: $value.requestDate),
      status: data.get(#status, or: $value.status),
      note: data.get(#note, or: $value.note),
      user: data.get(#user, or: $value.user),
      charity: data.get(#charity, or: $value.charity),
      driver: data.get(#driver, or: $value.driver),
      hospital: data.get(#hospital, or: $value.hospital),
      complaint: data.get(#complaint, or: $value.complaint));

  @override
  RequestModelCopyWith<$R2, RequestModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RequestModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
