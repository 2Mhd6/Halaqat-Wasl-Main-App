// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'complaint_model.dart';

class ComplaintModelMapper extends ClassMapperBase<ComplaintModel> {
  ComplaintModelMapper._();

  static ComplaintModelMapper? _instance;
  static ComplaintModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ComplaintModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ComplaintModel';

  static String _$complaintId(ComplaintModel v) => v.complaintId;
  static const Field<ComplaintModel, String> _f$complaintId =
      Field('complaintId', _$complaintId, key: r'complaint_id');
  static String? _$userId(ComplaintModel v) => v.userId;
  static const Field<ComplaintModel, String> _f$userId =
      Field('userId', _$userId, key: r'user_id');
  static String? _$charityId(ComplaintModel v) => v.charityId;
  static const Field<ComplaintModel, String> _f$charityId =
      Field('charityId', _$charityId, key: r'charity_id');
  static String? _$requestId(ComplaintModel v) => v.requestId;
  static const Field<ComplaintModel, String> _f$requestId =
      Field('requestId', _$requestId, key: r'request_id');
  static String? _$driverId(ComplaintModel v) => v.driverId;
  static const Field<ComplaintModel, String> _f$driverId =
      Field('driverId', _$driverId, key: r'driver_id');
  static String? _$hospitalId(ComplaintModel v) => v.hospitalId;
  static const Field<ComplaintModel, String> _f$hospitalId =
      Field('hospitalId', _$hospitalId, key: r'hospital_id');
  static String _$complaint(ComplaintModel v) => v.complaint;
  static const Field<ComplaintModel, String> _f$complaint =
      Field('complaint', _$complaint);
  static String _$response(ComplaintModel v) => v.response;
  static const Field<ComplaintModel, String> _f$response =
      Field('response', _$response);
  static bool _$isActive(ComplaintModel v) => v.isActive;
  static const Field<ComplaintModel, bool> _f$isActive =
      Field('isActive', _$isActive, key: r'is_active');

  @override
  final MappableFields<ComplaintModel> fields = const {
    #complaintId: _f$complaintId,
    #userId: _f$userId,
    #charityId: _f$charityId,
    #requestId: _f$requestId,
    #driverId: _f$driverId,
    #hospitalId: _f$hospitalId,
    #complaint: _f$complaint,
    #response: _f$response,
    #isActive: _f$isActive,
  };

  static ComplaintModel _instantiate(DecodingData data) {
    return ComplaintModel(
        complaintId: data.dec(_f$complaintId),
        userId: data.dec(_f$userId),
        charityId: data.dec(_f$charityId),
        requestId: data.dec(_f$requestId),
        driverId: data.dec(_f$driverId),
        hospitalId: data.dec(_f$hospitalId),
        complaint: data.dec(_f$complaint),
        response: data.dec(_f$response),
        isActive: data.dec(_f$isActive));
  }

  @override
  final Function instantiate = _instantiate;

  static ComplaintModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ComplaintModel>(map);
  }

  static ComplaintModel fromJson(String json) {
    return ensureInitialized().decodeJson<ComplaintModel>(json);
  }
}

mixin ComplaintModelMappable {
  String toJson() {
    return ComplaintModelMapper.ensureInitialized()
        .encodeJson<ComplaintModel>(this as ComplaintModel);
  }

  Map<String, dynamic> toMap() {
    return ComplaintModelMapper.ensureInitialized()
        .encodeMap<ComplaintModel>(this as ComplaintModel);
  }

  ComplaintModelCopyWith<ComplaintModel, ComplaintModel, ComplaintModel>
      get copyWith =>
          _ComplaintModelCopyWithImpl<ComplaintModel, ComplaintModel>(
              this as ComplaintModel, $identity, $identity);
  @override
  String toString() {
    return ComplaintModelMapper.ensureInitialized()
        .stringifyValue(this as ComplaintModel);
  }

  @override
  bool operator ==(Object other) {
    return ComplaintModelMapper.ensureInitialized()
        .equalsValue(this as ComplaintModel, other);
  }

  @override
  int get hashCode {
    return ComplaintModelMapper.ensureInitialized()
        .hashValue(this as ComplaintModel);
  }
}

extension ComplaintModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ComplaintModel, $Out> {
  ComplaintModelCopyWith<$R, ComplaintModel, $Out> get $asComplaintModel =>
      $base.as((v, t, t2) => _ComplaintModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ComplaintModelCopyWith<$R, $In extends ComplaintModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? complaintId,
      String? userId,
      String? charityId,
      String? requestId,
      String? driverId,
      String? hospitalId,
      String? complaint,
      String? response,
      bool? isActive});
  ComplaintModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ComplaintModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ComplaintModel, $Out>
    implements ComplaintModelCopyWith<$R, ComplaintModel, $Out> {
  _ComplaintModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ComplaintModel> $mapper =
      ComplaintModelMapper.ensureInitialized();
  @override
  $R call(
          {String? complaintId,
          Object? userId = $none,
          Object? charityId = $none,
          Object? requestId = $none,
          Object? driverId = $none,
          Object? hospitalId = $none,
          String? complaint,
          String? response,
          bool? isActive}) =>
      $apply(FieldCopyWithData({
        if (complaintId != null) #complaintId: complaintId,
        if (userId != $none) #userId: userId,
        if (charityId != $none) #charityId: charityId,
        if (requestId != $none) #requestId: requestId,
        if (driverId != $none) #driverId: driverId,
        if (hospitalId != $none) #hospitalId: hospitalId,
        if (complaint != null) #complaint: complaint,
        if (response != null) #response: response,
        if (isActive != null) #isActive: isActive
      }));
  @override
  ComplaintModel $make(CopyWithData data) => ComplaintModel(
      complaintId: data.get(#complaintId, or: $value.complaintId),
      userId: data.get(#userId, or: $value.userId),
      charityId: data.get(#charityId, or: $value.charityId),
      requestId: data.get(#requestId, or: $value.requestId),
      driverId: data.get(#driverId, or: $value.driverId),
      hospitalId: data.get(#hospitalId, or: $value.hospitalId),
      complaint: data.get(#complaint, or: $value.complaint),
      response: data.get(#response, or: $value.response),
      isActive: data.get(#isActive, or: $value.isActive));

  @override
  ComplaintModelCopyWith<$R2, ComplaintModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ComplaintModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
