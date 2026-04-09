// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'office.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Office _$OfficeFromJson(Map<String, dynamic> json) {
  return _Office.fromJson(json);
}

/// @nodoc
mixin _$Office {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get operatingHours => throw _privateConstructorUsedError;

  /// Serializes this Office to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Office
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OfficeCopyWith<Office> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfficeCopyWith<$Res> {
  factory $OfficeCopyWith(Office value, $Res Function(Office) then) =
      _$OfficeCopyWithImpl<$Res, Office>;
  @useResult
  $Res call({
    int id,
    String name,
    String address,
    double? latitude,
    double? longitude,
    String? phone,
    String? operatingHours,
  });
}

/// @nodoc
class _$OfficeCopyWithImpl<$Res, $Val extends Office>
    implements $OfficeCopyWith<$Res> {
  _$OfficeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Office
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? phone = freezed,
    Object? operatingHours = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            operatingHours: freezed == operatingHours
                ? _value.operatingHours
                : operatingHours // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OfficeImplCopyWith<$Res> implements $OfficeCopyWith<$Res> {
  factory _$$OfficeImplCopyWith(
    _$OfficeImpl value,
    $Res Function(_$OfficeImpl) then,
  ) = __$$OfficeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String address,
    double? latitude,
    double? longitude,
    String? phone,
    String? operatingHours,
  });
}

/// @nodoc
class __$$OfficeImplCopyWithImpl<$Res>
    extends _$OfficeCopyWithImpl<$Res, _$OfficeImpl>
    implements _$$OfficeImplCopyWith<$Res> {
  __$$OfficeImplCopyWithImpl(
    _$OfficeImpl _value,
    $Res Function(_$OfficeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Office
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? phone = freezed,
    Object? operatingHours = freezed,
  }) {
    return _then(
      _$OfficeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        operatingHours: freezed == operatingHours
            ? _value.operatingHours
            : operatingHours // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OfficeImpl implements _Office {
  const _$OfficeImpl({
    required this.id,
    required this.name,
    required this.address,
    this.latitude,
    this.longitude,
    this.phone,
    this.operatingHours,
  });

  factory _$OfficeImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfficeImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String address;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? phone;
  @override
  final String? operatingHours;

  @override
  String toString() {
    return 'Office(id: $id, name: $name, address: $address, latitude: $latitude, longitude: $longitude, phone: $phone, operatingHours: $operatingHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfficeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.operatingHours, operatingHours) ||
                other.operatingHours == operatingHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    address,
    latitude,
    longitude,
    phone,
    operatingHours,
  );

  /// Create a copy of Office
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfficeImplCopyWith<_$OfficeImpl> get copyWith =>
      __$$OfficeImplCopyWithImpl<_$OfficeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfficeImplToJson(this);
  }
}

abstract class _Office implements Office {
  const factory _Office({
    required final int id,
    required final String name,
    required final String address,
    final double? latitude,
    final double? longitude,
    final String? phone,
    final String? operatingHours,
  }) = _$OfficeImpl;

  factory _Office.fromJson(Map<String, dynamic> json) = _$OfficeImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get address;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String? get phone;
  @override
  String? get operatingHours;

  /// Create a copy of Office
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfficeImplCopyWith<_$OfficeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OfficeDetail _$OfficeDetailFromJson(Map<String, dynamic> json) {
  return _OfficeDetail.fromJson(json);
}

/// @nodoc
mixin _$OfficeDetail {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String? get detailAddress => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get operatingHours => throw _privateConstructorUsedError;
  String? get regionCode => throw _privateConstructorUsedError;
  String? get nightOperation => throw _privateConstructorUsedError;
  String? get weekendOperation => throw _privateConstructorUsedError;
  QueueStatus? get queueStatus => throw _privateConstructorUsedError;

  /// Serializes this OfficeDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OfficeDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OfficeDetailCopyWith<OfficeDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfficeDetailCopyWith<$Res> {
  factory $OfficeDetailCopyWith(
    OfficeDetail value,
    $Res Function(OfficeDetail) then,
  ) = _$OfficeDetailCopyWithImpl<$Res, OfficeDetail>;
  @useResult
  $Res call({
    int id,
    String name,
    String address,
    String? detailAddress,
    double? latitude,
    double? longitude,
    String? phone,
    String? operatingHours,
    String? regionCode,
    String? nightOperation,
    String? weekendOperation,
    QueueStatus? queueStatus,
  });

  $QueueStatusCopyWith<$Res>? get queueStatus;
}

/// @nodoc
class _$OfficeDetailCopyWithImpl<$Res, $Val extends OfficeDetail>
    implements $OfficeDetailCopyWith<$Res> {
  _$OfficeDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OfficeDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? detailAddress = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? phone = freezed,
    Object? operatingHours = freezed,
    Object? regionCode = freezed,
    Object? nightOperation = freezed,
    Object? weekendOperation = freezed,
    Object? queueStatus = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            detailAddress: freezed == detailAddress
                ? _value.detailAddress
                : detailAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            operatingHours: freezed == operatingHours
                ? _value.operatingHours
                : operatingHours // ignore: cast_nullable_to_non_nullable
                      as String?,
            regionCode: freezed == regionCode
                ? _value.regionCode
                : regionCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            nightOperation: freezed == nightOperation
                ? _value.nightOperation
                : nightOperation // ignore: cast_nullable_to_non_nullable
                      as String?,
            weekendOperation: freezed == weekendOperation
                ? _value.weekendOperation
                : weekendOperation // ignore: cast_nullable_to_non_nullable
                      as String?,
            queueStatus: freezed == queueStatus
                ? _value.queueStatus
                : queueStatus // ignore: cast_nullable_to_non_nullable
                      as QueueStatus?,
          )
          as $Val,
    );
  }

  /// Create a copy of OfficeDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QueueStatusCopyWith<$Res>? get queueStatus {
    if (_value.queueStatus == null) {
      return null;
    }

    return $QueueStatusCopyWith<$Res>(_value.queueStatus!, (value) {
      return _then(_value.copyWith(queueStatus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OfficeDetailImplCopyWith<$Res>
    implements $OfficeDetailCopyWith<$Res> {
  factory _$$OfficeDetailImplCopyWith(
    _$OfficeDetailImpl value,
    $Res Function(_$OfficeDetailImpl) then,
  ) = __$$OfficeDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String address,
    String? detailAddress,
    double? latitude,
    double? longitude,
    String? phone,
    String? operatingHours,
    String? regionCode,
    String? nightOperation,
    String? weekendOperation,
    QueueStatus? queueStatus,
  });

  @override
  $QueueStatusCopyWith<$Res>? get queueStatus;
}

/// @nodoc
class __$$OfficeDetailImplCopyWithImpl<$Res>
    extends _$OfficeDetailCopyWithImpl<$Res, _$OfficeDetailImpl>
    implements _$$OfficeDetailImplCopyWith<$Res> {
  __$$OfficeDetailImplCopyWithImpl(
    _$OfficeDetailImpl _value,
    $Res Function(_$OfficeDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OfficeDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? detailAddress = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? phone = freezed,
    Object? operatingHours = freezed,
    Object? regionCode = freezed,
    Object? nightOperation = freezed,
    Object? weekendOperation = freezed,
    Object? queueStatus = freezed,
  }) {
    return _then(
      _$OfficeDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        detailAddress: freezed == detailAddress
            ? _value.detailAddress
            : detailAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        operatingHours: freezed == operatingHours
            ? _value.operatingHours
            : operatingHours // ignore: cast_nullable_to_non_nullable
                  as String?,
        regionCode: freezed == regionCode
            ? _value.regionCode
            : regionCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        nightOperation: freezed == nightOperation
            ? _value.nightOperation
            : nightOperation // ignore: cast_nullable_to_non_nullable
                  as String?,
        weekendOperation: freezed == weekendOperation
            ? _value.weekendOperation
            : weekendOperation // ignore: cast_nullable_to_non_nullable
                  as String?,
        queueStatus: freezed == queueStatus
            ? _value.queueStatus
            : queueStatus // ignore: cast_nullable_to_non_nullable
                  as QueueStatus?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OfficeDetailImpl implements _OfficeDetail {
  const _$OfficeDetailImpl({
    required this.id,
    required this.name,
    required this.address,
    this.detailAddress,
    this.latitude,
    this.longitude,
    this.phone,
    this.operatingHours,
    this.regionCode,
    this.nightOperation,
    this.weekendOperation,
    this.queueStatus,
  });

  factory _$OfficeDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfficeDetailImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String address;
  @override
  final String? detailAddress;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? phone;
  @override
  final String? operatingHours;
  @override
  final String? regionCode;
  @override
  final String? nightOperation;
  @override
  final String? weekendOperation;
  @override
  final QueueStatus? queueStatus;

  @override
  String toString() {
    return 'OfficeDetail(id: $id, name: $name, address: $address, detailAddress: $detailAddress, latitude: $latitude, longitude: $longitude, phone: $phone, operatingHours: $operatingHours, regionCode: $regionCode, nightOperation: $nightOperation, weekendOperation: $weekendOperation, queueStatus: $queueStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfficeDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.detailAddress, detailAddress) ||
                other.detailAddress == detailAddress) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.operatingHours, operatingHours) ||
                other.operatingHours == operatingHours) &&
            (identical(other.regionCode, regionCode) ||
                other.regionCode == regionCode) &&
            (identical(other.nightOperation, nightOperation) ||
                other.nightOperation == nightOperation) &&
            (identical(other.weekendOperation, weekendOperation) ||
                other.weekendOperation == weekendOperation) &&
            (identical(other.queueStatus, queueStatus) ||
                other.queueStatus == queueStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    address,
    detailAddress,
    latitude,
    longitude,
    phone,
    operatingHours,
    regionCode,
    nightOperation,
    weekendOperation,
    queueStatus,
  );

  /// Create a copy of OfficeDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfficeDetailImplCopyWith<_$OfficeDetailImpl> get copyWith =>
      __$$OfficeDetailImplCopyWithImpl<_$OfficeDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfficeDetailImplToJson(this);
  }
}

abstract class _OfficeDetail implements OfficeDetail {
  const factory _OfficeDetail({
    required final int id,
    required final String name,
    required final String address,
    final String? detailAddress,
    final double? latitude,
    final double? longitude,
    final String? phone,
    final String? operatingHours,
    final String? regionCode,
    final String? nightOperation,
    final String? weekendOperation,
    final QueueStatus? queueStatus,
  }) = _$OfficeDetailImpl;

  factory _OfficeDetail.fromJson(Map<String, dynamic> json) =
      _$OfficeDetailImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get address;
  @override
  String? get detailAddress;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String? get phone;
  @override
  String? get operatingHours;
  @override
  String? get regionCode;
  @override
  String? get nightOperation;
  @override
  String? get weekendOperation;
  @override
  QueueStatus? get queueStatus;

  /// Create a copy of OfficeDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfficeDetailImplCopyWith<_$OfficeDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
