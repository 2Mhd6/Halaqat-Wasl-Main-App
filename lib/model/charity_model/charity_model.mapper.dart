// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'charity_model.dart';

class CharityModelMapper extends ClassMapperBase<CharityModel> {
  CharityModelMapper._();

  static CharityModelMapper? _instance;
  static CharityModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CharityModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CharityModel';

  static String _$charityId(CharityModel v) => v.charityId;
  static const Field<CharityModel, String> _f$charityId =
      Field('charityId', _$charityId, key: r'charity_id');
  static String? _$charityNumber(CharityModel v) => v.charityNumber;
  static const Field<CharityModel, String> _f$charityNumber =
      Field('charityNumber', _$charityNumber, key: r'charity_number');
  static String _$charityName(CharityModel v) => v.charityName;
  static const Field<CharityModel, String> _f$charityName =
      Field('charityName', _$charityName, key: r'charity_name');
  static String? _$role(CharityModel v) => v.role;
  static const Field<CharityModel, String> _f$role = Field('role', _$role);
  static double _$charityLat(CharityModel v) => v.charityLat;
  static const Field<CharityModel, double> _f$charityLat =
      Field('charityLat', _$charityLat, key: r'charity_lat');
  static double _$charityLang(CharityModel v) => v.charityLang;
  static const Field<CharityModel, double> _f$charityLang =
      Field('charityLang', _$charityLang, key: r'charity_lang');
  static int _$totalServices(CharityModel v) => v.totalServices;
  static const Field<CharityModel, int> _f$totalServices =
      Field('totalServices', _$totalServices, key: r'total_services');

  @override
  final MappableFields<CharityModel> fields = const {
    #charityId: _f$charityId,
    #charityNumber: _f$charityNumber,
    #charityName: _f$charityName,
    #role: _f$role,
    #charityLat: _f$charityLat,
    #charityLang: _f$charityLang,
    #totalServices: _f$totalServices,
  };

  static CharityModel _instantiate(DecodingData data) {
    return CharityModel(
        charityId: data.dec(_f$charityId),
        charityNumber: data.dec(_f$charityNumber),
        charityName: data.dec(_f$charityName),
        role: data.dec(_f$role),
        charityLat: data.dec(_f$charityLat),
        charityLang: data.dec(_f$charityLang),
        totalServices: data.dec(_f$totalServices));
  }

  @override
  final Function instantiate = _instantiate;

  static CharityModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CharityModel>(map);
  }

  static CharityModel fromJson(String json) {
    return ensureInitialized().decodeJson<CharityModel>(json);
  }
}

mixin CharityModelMappable {
  String toJson() {
    return CharityModelMapper.ensureInitialized()
        .encodeJson<CharityModel>(this as CharityModel);
  }

  Map<String, dynamic> toMap() {
    return CharityModelMapper.ensureInitialized()
        .encodeMap<CharityModel>(this as CharityModel);
  }

  CharityModelCopyWith<CharityModel, CharityModel, CharityModel> get copyWith =>
      _CharityModelCopyWithImpl<CharityModel, CharityModel>(
          this as CharityModel, $identity, $identity);
  @override
  String toString() {
    return CharityModelMapper.ensureInitialized()
        .stringifyValue(this as CharityModel);
  }

  @override
  bool operator ==(Object other) {
    return CharityModelMapper.ensureInitialized()
        .equalsValue(this as CharityModel, other);
  }

  @override
  int get hashCode {
    return CharityModelMapper.ensureInitialized()
        .hashValue(this as CharityModel);
  }
}

extension CharityModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CharityModel, $Out> {
  CharityModelCopyWith<$R, CharityModel, $Out> get $asCharityModel =>
      $base.as((v, t, t2) => _CharityModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CharityModelCopyWith<$R, $In extends CharityModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? charityId,
      String? charityNumber,
      String? charityName,
      String? role,
      double? charityLat,
      double? charityLang,
      int? totalServices});
  CharityModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CharityModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CharityModel, $Out>
    implements CharityModelCopyWith<$R, CharityModel, $Out> {
  _CharityModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CharityModel> $mapper =
      CharityModelMapper.ensureInitialized();
  @override
  $R call(
          {String? charityId,
          Object? charityNumber = $none,
          String? charityName,
          Object? role = $none,
          double? charityLat,
          double? charityLang,
          int? totalServices}) =>
      $apply(FieldCopyWithData({
        if (charityId != null) #charityId: charityId,
        if (charityNumber != $none) #charityNumber: charityNumber,
        if (charityName != null) #charityName: charityName,
        if (role != $none) #role: role,
        if (charityLat != null) #charityLat: charityLat,
        if (charityLang != null) #charityLang: charityLang,
        if (totalServices != null) #totalServices: totalServices
      }));
  @override
  CharityModel $make(CopyWithData data) => CharityModel(
      charityId: data.get(#charityId, or: $value.charityId),
      charityNumber: data.get(#charityNumber, or: $value.charityNumber),
      charityName: data.get(#charityName, or: $value.charityName),
      role: data.get(#role, or: $value.role),
      charityLat: data.get(#charityLat, or: $value.charityLat),
      charityLang: data.get(#charityLang, or: $value.charityLang),
      totalServices: data.get(#totalServices, or: $value.totalServices));

  @override
  CharityModelCopyWith<$R2, CharityModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CharityModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
