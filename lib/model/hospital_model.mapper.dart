/*

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'hospital_model.dart';

class HospitalModelMapper extends ClassMapperBase<HospitalModel> {
  HospitalModelMapper._();

  static HospitalModelMapper? _instance;
  static HospitalModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HospitalModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HospitalModel';

  static int _$hospitalId(HospitalModel v) => v.hospitalId;
  static const Field<HospitalModel, int> _f$hospitalId =
      Field('hospitalId', _$hospitalId, key: r'hospital_id');
  static String _$fullName(HospitalModel v) => v.fullName;
  static const Field<HospitalModel, String> _f$fullName =
      Field('fullName', _$fullName, key: r'full_name');
  static double _$charityLat(HospitalModel v) => v.charityLat;
  static const Field<HospitalModel, double> _f$charityLat =
      Field('charityLat', _$charityLat, key: r'charity_lat');
  static double _$charityLong(HospitalModel v) => v.charityLong;
  static const Field<HospitalModel, double> _f$charityLong =
      Field('charityLong', _$charityLong, key: r'charity_long');

  @override
  final MappableFields<HospitalModel> fields = const {
    #hospitalId: _f$hospitalId,
    #fullName: _f$fullName,
    #charityLat: _f$charityLat,
    #charityLong: _f$charityLong,
  };

  static HospitalModel _instantiate(DecodingData data) {
    return HospitalModel(
        hospitalId: data.dec(_f$hospitalId),
        fullName: data.dec(_f$fullName),
        charityLat: data.dec(_f$charityLat),
        charityLong: data.dec(_f$charityLong));
  }

  @override
  final Function instantiate = _instantiate;

  static HospitalModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HospitalModel>(map);
  }

  static HospitalModel fromJson(String json) {
    return ensureInitialized().decodeJson<HospitalModel>(json);
  }
}

mixin HospitalModelMappable {
  String toJson() {
    return HospitalModelMapper.ensureInitialized()
        .encodeJson<HospitalModel>(this as HospitalModel);
  }

  Map<String, dynamic> toMap() {
    return HospitalModelMapper.ensureInitialized()
        .encodeMap<HospitalModel>(this as HospitalModel);
  }

  HospitalModelCopyWith<HospitalModel, HospitalModel, HospitalModel>
      get copyWith => _HospitalModelCopyWithImpl<HospitalModel, HospitalModel>(
          this as HospitalModel, $identity, $identity);
  @override
  String toString() {
    return HospitalModelMapper.ensureInitialized()
        .stringifyValue(this as HospitalModel);
  }

  @override
  bool operator ==(Object other) {
    return HospitalModelMapper.ensureInitialized()
        .equalsValue(this as HospitalModel, other);
  }

  @override
  int get hashCode {
    return HospitalModelMapper.ensureInitialized()
        .hashValue(this as HospitalModel);
  }
}

extension HospitalModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HospitalModel, $Out> {
  HospitalModelCopyWith<$R, HospitalModel, $Out> get $asHospitalModel =>
      $base.as((v, t, t2) => _HospitalModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HospitalModelCopyWith<$R, $In extends HospitalModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? hospitalId,
      String? fullName,
      double? charityLat,
      double? charityLong});
  HospitalModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HospitalModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HospitalModel, $Out>
    implements HospitalModelCopyWith<$R, HospitalModel, $Out> {
  _HospitalModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HospitalModel> $mapper =
      HospitalModelMapper.ensureInitialized();
  @override
  $R call(
          {int? hospitalId,
          String? fullName,
          double? charityLat,
          double? charityLong}) =>
      $apply(FieldCopyWithData({
        if (hospitalId != null) #hospitalId: hospitalId,
        if (fullName != null) #fullName: fullName,
        if (charityLat != null) #charityLat: charityLat,
        if (charityLong != null) #charityLong: charityLong
      }));
  @override
  HospitalModel $make(CopyWithData data) => HospitalModel(
      hospitalId: data.get(#hospitalId, or: $value.hospitalId),
      fullName: data.get(#fullName, or: $value.fullName),
      charityLat: data.get(#charityLat, or: $value.charityLat),
      charityLong: data.get(#charityLong, or: $value.charityLong));

  @override
  HospitalModelCopyWith<$R2, HospitalModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _HospitalModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

*/
