// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_trend.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QueueTrendResponse _$QueueTrendResponseFromJson(Map<String, dynamic> json) {
  return _QueueTrendResponse.fromJson(json);
}

/// @nodoc
mixin _$QueueTrendResponse {
  int get officeId => throw _privateConstructorUsedError;
  List<TrendDataPoint> get dataPoints => throw _privateConstructorUsedError;

  /// Serializes this QueueTrendResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueueTrendResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueTrendResponseCopyWith<QueueTrendResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueTrendResponseCopyWith<$Res> {
  factory $QueueTrendResponseCopyWith(
    QueueTrendResponse value,
    $Res Function(QueueTrendResponse) then,
  ) = _$QueueTrendResponseCopyWithImpl<$Res, QueueTrendResponse>;
  @useResult
  $Res call({int officeId, List<TrendDataPoint> dataPoints});
}

/// @nodoc
class _$QueueTrendResponseCopyWithImpl<$Res, $Val extends QueueTrendResponse>
    implements $QueueTrendResponseCopyWith<$Res> {
  _$QueueTrendResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueTrendResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? officeId = null, Object? dataPoints = null}) {
    return _then(
      _value.copyWith(
            officeId: null == officeId
                ? _value.officeId
                : officeId // ignore: cast_nullable_to_non_nullable
                      as int,
            dataPoints: null == dataPoints
                ? _value.dataPoints
                : dataPoints // ignore: cast_nullable_to_non_nullable
                      as List<TrendDataPoint>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QueueTrendResponseImplCopyWith<$Res>
    implements $QueueTrendResponseCopyWith<$Res> {
  factory _$$QueueTrendResponseImplCopyWith(
    _$QueueTrendResponseImpl value,
    $Res Function(_$QueueTrendResponseImpl) then,
  ) = __$$QueueTrendResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int officeId, List<TrendDataPoint> dataPoints});
}

/// @nodoc
class __$$QueueTrendResponseImplCopyWithImpl<$Res>
    extends _$QueueTrendResponseCopyWithImpl<$Res, _$QueueTrendResponseImpl>
    implements _$$QueueTrendResponseImplCopyWith<$Res> {
  __$$QueueTrendResponseImplCopyWithImpl(
    _$QueueTrendResponseImpl _value,
    $Res Function(_$QueueTrendResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueTrendResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? officeId = null, Object? dataPoints = null}) {
    return _then(
      _$QueueTrendResponseImpl(
        officeId: null == officeId
            ? _value.officeId
            : officeId // ignore: cast_nullable_to_non_nullable
                  as int,
        dataPoints: null == dataPoints
            ? _value._dataPoints
            : dataPoints // ignore: cast_nullable_to_non_nullable
                  as List<TrendDataPoint>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueTrendResponseImpl implements _QueueTrendResponse {
  const _$QueueTrendResponseImpl({
    required this.officeId,
    required final List<TrendDataPoint> dataPoints,
  }) : _dataPoints = dataPoints;

  factory _$QueueTrendResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueTrendResponseImplFromJson(json);

  @override
  final int officeId;
  final List<TrendDataPoint> _dataPoints;
  @override
  List<TrendDataPoint> get dataPoints {
    if (_dataPoints is EqualUnmodifiableListView) return _dataPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dataPoints);
  }

  @override
  String toString() {
    return 'QueueTrendResponse(officeId: $officeId, dataPoints: $dataPoints)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueTrendResponseImpl &&
            (identical(other.officeId, officeId) ||
                other.officeId == officeId) &&
            const DeepCollectionEquality().equals(
              other._dataPoints,
              _dataPoints,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    officeId,
    const DeepCollectionEquality().hash(_dataPoints),
  );

  /// Create a copy of QueueTrendResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueTrendResponseImplCopyWith<_$QueueTrendResponseImpl> get copyWith =>
      __$$QueueTrendResponseImplCopyWithImpl<_$QueueTrendResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueTrendResponseImplToJson(this);
  }
}

abstract class _QueueTrendResponse implements QueueTrendResponse {
  const factory _QueueTrendResponse({
    required final int officeId,
    required final List<TrendDataPoint> dataPoints,
  }) = _$QueueTrendResponseImpl;

  factory _QueueTrendResponse.fromJson(Map<String, dynamic> json) =
      _$QueueTrendResponseImpl.fromJson;

  @override
  int get officeId;
  @override
  List<TrendDataPoint> get dataPoints;

  /// Create a copy of QueueTrendResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueTrendResponseImplCopyWith<_$QueueTrendResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TrendDataPoint _$TrendDataPointFromJson(Map<String, dynamic> json) {
  return _TrendDataPoint.fromJson(json);
}

/// @nodoc
mixin _$TrendDataPoint {
  int get dayOfWeek => throw _privateConstructorUsedError;
  String get dayLabel => throw _privateConstructorUsedError;
  int get hourOfDay => throw _privateConstructorUsedError;
  double get averageWaitingCount => throw _privateConstructorUsedError;

  /// Serializes this TrendDataPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrendDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrendDataPointCopyWith<TrendDataPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrendDataPointCopyWith<$Res> {
  factory $TrendDataPointCopyWith(
    TrendDataPoint value,
    $Res Function(TrendDataPoint) then,
  ) = _$TrendDataPointCopyWithImpl<$Res, TrendDataPoint>;
  @useResult
  $Res call({
    int dayOfWeek,
    String dayLabel,
    int hourOfDay,
    double averageWaitingCount,
  });
}

/// @nodoc
class _$TrendDataPointCopyWithImpl<$Res, $Val extends TrendDataPoint>
    implements $TrendDataPointCopyWith<$Res> {
  _$TrendDataPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrendDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayOfWeek = null,
    Object? dayLabel = null,
    Object? hourOfDay = null,
    Object? averageWaitingCount = null,
  }) {
    return _then(
      _value.copyWith(
            dayOfWeek: null == dayOfWeek
                ? _value.dayOfWeek
                : dayOfWeek // ignore: cast_nullable_to_non_nullable
                      as int,
            dayLabel: null == dayLabel
                ? _value.dayLabel
                : dayLabel // ignore: cast_nullable_to_non_nullable
                      as String,
            hourOfDay: null == hourOfDay
                ? _value.hourOfDay
                : hourOfDay // ignore: cast_nullable_to_non_nullable
                      as int,
            averageWaitingCount: null == averageWaitingCount
                ? _value.averageWaitingCount
                : averageWaitingCount // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TrendDataPointImplCopyWith<$Res>
    implements $TrendDataPointCopyWith<$Res> {
  factory _$$TrendDataPointImplCopyWith(
    _$TrendDataPointImpl value,
    $Res Function(_$TrendDataPointImpl) then,
  ) = __$$TrendDataPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int dayOfWeek,
    String dayLabel,
    int hourOfDay,
    double averageWaitingCount,
  });
}

/// @nodoc
class __$$TrendDataPointImplCopyWithImpl<$Res>
    extends _$TrendDataPointCopyWithImpl<$Res, _$TrendDataPointImpl>
    implements _$$TrendDataPointImplCopyWith<$Res> {
  __$$TrendDataPointImplCopyWithImpl(
    _$TrendDataPointImpl _value,
    $Res Function(_$TrendDataPointImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrendDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayOfWeek = null,
    Object? dayLabel = null,
    Object? hourOfDay = null,
    Object? averageWaitingCount = null,
  }) {
    return _then(
      _$TrendDataPointImpl(
        dayOfWeek: null == dayOfWeek
            ? _value.dayOfWeek
            : dayOfWeek // ignore: cast_nullable_to_non_nullable
                  as int,
        dayLabel: null == dayLabel
            ? _value.dayLabel
            : dayLabel // ignore: cast_nullable_to_non_nullable
                  as String,
        hourOfDay: null == hourOfDay
            ? _value.hourOfDay
            : hourOfDay // ignore: cast_nullable_to_non_nullable
                  as int,
        averageWaitingCount: null == averageWaitingCount
            ? _value.averageWaitingCount
            : averageWaitingCount // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TrendDataPointImpl implements _TrendDataPoint {
  const _$TrendDataPointImpl({
    required this.dayOfWeek,
    required this.dayLabel,
    required this.hourOfDay,
    required this.averageWaitingCount,
  });

  factory _$TrendDataPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrendDataPointImplFromJson(json);

  @override
  final int dayOfWeek;
  @override
  final String dayLabel;
  @override
  final int hourOfDay;
  @override
  final double averageWaitingCount;

  @override
  String toString() {
    return 'TrendDataPoint(dayOfWeek: $dayOfWeek, dayLabel: $dayLabel, hourOfDay: $hourOfDay, averageWaitingCount: $averageWaitingCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrendDataPointImpl &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.dayLabel, dayLabel) ||
                other.dayLabel == dayLabel) &&
            (identical(other.hourOfDay, hourOfDay) ||
                other.hourOfDay == hourOfDay) &&
            (identical(other.averageWaitingCount, averageWaitingCount) ||
                other.averageWaitingCount == averageWaitingCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    dayOfWeek,
    dayLabel,
    hourOfDay,
    averageWaitingCount,
  );

  /// Create a copy of TrendDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrendDataPointImplCopyWith<_$TrendDataPointImpl> get copyWith =>
      __$$TrendDataPointImplCopyWithImpl<_$TrendDataPointImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TrendDataPointImplToJson(this);
  }
}

abstract class _TrendDataPoint implements TrendDataPoint {
  const factory _TrendDataPoint({
    required final int dayOfWeek,
    required final String dayLabel,
    required final int hourOfDay,
    required final double averageWaitingCount,
  }) = _$TrendDataPointImpl;

  factory _TrendDataPoint.fromJson(Map<String, dynamic> json) =
      _$TrendDataPointImpl.fromJson;

  @override
  int get dayOfWeek;
  @override
  String get dayLabel;
  @override
  int get hourOfDay;
  @override
  double get averageWaitingCount;

  /// Create a copy of TrendDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrendDataPointImplCopyWith<_$TrendDataPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
