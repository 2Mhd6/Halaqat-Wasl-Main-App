// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'driver_model.dart';

class DriverNotificationMapper extends ClassMapperBase<DriverNotification> {
  DriverNotificationMapper._();

  static DriverNotificationMapper? _instance;
  static DriverNotificationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DriverNotificationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DriverNotification';

  static String _$driverId(DriverNotification v) => v.driverId;
  static const Field<DriverNotification, String> _f$driverId =
      Field('driverId', _$driverId, key: r'driver_id');
  static String _$charityId(DriverNotification v) => v.charityId;
  static const Field<DriverNotification, String> _f$charityId =
      Field('charityId', _$charityId, key: r'charity_id');
  static String? _$notificationId(DriverNotification v) => v.notificationId;
  static const Field<DriverNotification, String> _f$notificationId =
      Field('notificationId', _$notificationId, key: r'notification_id');
  static String _$fullName(DriverNotification v) => v.fullName;
  static const Field<DriverNotification, String> _f$fullName =
      Field('fullName', _$fullName, key: r'full_name');
  static String _$role(DriverNotification v) => v.role;
  static const Field<DriverNotification, String> _f$role =
      Field('role', _$role);
  static String _$status(DriverNotification v) => v.status;
  static const Field<DriverNotification, String> _f$status =
      Field('status', _$status);
  static int _$totalServices(DriverNotification v) => v.totalServices;
  static const Field<DriverNotification, int> _f$totalServices =
      Field('totalServices', _$totalServices, key: r'total_services');

  @override
  final MappableFields<DriverNotification> fields = const {
    #driverId: _f$driverId,
    #charityId: _f$charityId,
    #notificationId: _f$notificationId,
    #fullName: _f$fullName,
    #role: _f$role,
    #status: _f$status,
    #totalServices: _f$totalServices,
  };

  static DriverNotification _instantiate(DecodingData data) {
    return DriverNotification(
        driverId: data.dec(_f$driverId),
        charityId: data.dec(_f$charityId),
        notificationId: data.dec(_f$notificationId),
        fullName: data.dec(_f$fullName),
        role: data.dec(_f$role),
        status: data.dec(_f$status),
        totalServices: data.dec(_f$totalServices));
  }

  @override
  final Function instantiate = _instantiate;

  static DriverNotification fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DriverNotification>(map);
  }

  static DriverNotification fromJson(String json) {
    return ensureInitialized().decodeJson<DriverNotification>(json);
  }
}

mixin DriverNotificationMappable {
  String toJson() {
    return DriverNotificationMapper.ensureInitialized()
        .encodeJson<DriverNotification>(this as DriverNotification);
  }

  Map<String, dynamic> toMap() {
    return DriverNotificationMapper.ensureInitialized()
        .encodeMap<DriverNotification>(this as DriverNotification);
  }

  DriverNotificationCopyWith<DriverNotification, DriverNotification,
          DriverNotification>
      get copyWith => _DriverNotificationCopyWithImpl<DriverNotification,
          DriverNotification>(this as DriverNotification, $identity, $identity);
  @override
  String toString() {
    return DriverNotificationMapper.ensureInitialized()
        .stringifyValue(this as DriverNotification);
  }

  @override
  bool operator ==(Object other) {
    return DriverNotificationMapper.ensureInitialized()
        .equalsValue(this as DriverNotification, other);
  }

  @override
  int get hashCode {
    return DriverNotificationMapper.ensureInitialized()
        .hashValue(this as DriverNotification);
  }
}

extension DriverNotificationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DriverNotification, $Out> {
  DriverNotificationCopyWith<$R, DriverNotification, $Out>
      get $asDriverNotification => $base.as(
          (v, t, t2) => _DriverNotificationCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DriverNotificationCopyWith<$R, $In extends DriverNotification,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? driverId,
      String? charityId,
      String? notificationId,
      String? fullName,
      String? role,
      String? status,
      int? totalServices});
  DriverNotificationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DriverNotificationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DriverNotification, $Out>
    implements DriverNotificationCopyWith<$R, DriverNotification, $Out> {
  _DriverNotificationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DriverNotification> $mapper =
      DriverNotificationMapper.ensureInitialized();
  @override
  $R call(
          {String? driverId,
          String? charityId,
          Object? notificationId = $none,
          String? fullName,
          String? role,
          String? status,
          int? totalServices}) =>
      $apply(FieldCopyWithData({
        if (driverId != null) #driverId: driverId,
        if (charityId != null) #charityId: charityId,
        if (notificationId != $none) #notificationId: notificationId,
        if (fullName != null) #fullName: fullName,
        if (role != null) #role: role,
        if (status != null) #status: status,
        if (totalServices != null) #totalServices: totalServices
      }));
  @override
  DriverNotification $make(CopyWithData data) => DriverNotification(
      driverId: data.get(#driverId, or: $value.driverId),
      charityId: data.get(#charityId, or: $value.charityId),
      notificationId: data.get(#notificationId, or: $value.notificationId),
      fullName: data.get(#fullName, or: $value.fullName),
      role: data.get(#role, or: $value.role),
      status: data.get(#status, or: $value.status),
      totalServices: data.get(#totalServices, or: $value.totalServices));

  @override
  DriverNotificationCopyWith<$R2, DriverNotification, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DriverNotificationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
