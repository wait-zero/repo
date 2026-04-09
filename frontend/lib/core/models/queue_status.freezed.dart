// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QueueStatus _$QueueStatusFromJson(Map<String, dynamic> json) {
  return _QueueStatus.fromJson(json);
}

/// @nodoc
mixin _$QueueStatus {
  int get officeId => throw _privateConstructorUsedError;
  int get waitingCount => throw _privateConstructorUsedError;
  int get estimatedWaitMinutes => throw _privateConstructorUsedError;
  String get congestionLevel => throw _privateConstructorUsedError;
  int get activeWindows => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this QueueStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueueStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueStatusCopyWith<QueueStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueStatusCopyWith<$Res> {
  factory $QueueStatusCopyWith(
    QueueStatus value,
    $Res Function(QueueStatus) then,
  ) = _$QueueStatusCopyWithImpl<$Res, QueueStatus>;
  @useResult
  $Res call({
    int officeId,
    int waitingCount,
    int estimatedWaitMinutes,
    String congestionLevel,
    int activeWindows,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$QueueStatusCopyWithImpl<$Res, $Val extends QueueStatus>
    implements $QueueStatusCopyWith<$Res> {
  _$QueueStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? officeId = null,
    Object? waitingCount = null,
    Object? estimatedWaitMinutes = null,
    Object? congestionLevel = null,
    Object? activeWindows = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            officeId: null == officeId
                ? _value.officeId
                : officeId // ignore: cast_nullable_to_non_nullable
                      as int,
            waitingCount: null == waitingCount
                ? _value.waitingCount
                : waitingCount // ignore: cast_nullable_to_non_nullable
                      as int,
            estimatedWaitMinutes: null == estimatedWaitMinutes
                ? _value.estimatedWaitMinutes
                : estimatedWaitMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            congestionLevel: null == congestionLevel
                ? _value.congestionLevel
                : congestionLevel // ignore: cast_nullable_to_non_nullable
                      as String,
            activeWindows: null == activeWindows
                ? _value.activeWindows
                : activeWindows // ignore: cast_nullable_to_non_nullable
                      as int,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QueueStatusImplCopyWith<$Res>
    implements $QueueStatusCopyWith<$Res> {
  factory _$$QueueStatusImplCopyWith(
    _$QueueStatusImpl value,
    $Res Function(_$QueueStatusImpl) then,
  ) = __$$QueueStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int officeId,
    int waitingCount,
    int estimatedWaitMinutes,
    String congestionLevel,
    int activeWindows,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$QueueStatusImplCopyWithImpl<$Res>
    extends _$QueueStatusCopyWithImpl<$Res, _$QueueStatusImpl>
    implements _$$QueueStatusImplCopyWith<$Res> {
  __$$QueueStatusImplCopyWithImpl(
    _$QueueStatusImpl _value,
    $Res Function(_$QueueStatusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? officeId = null,
    Object? waitingCount = null,
    Object? estimatedWaitMinutes = null,
    Object? congestionLevel = null,
    Object? activeWindows = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$QueueStatusImpl(
        officeId: null == officeId
            ? _value.officeId
            : officeId // ignore: cast_nullable_to_non_nullable
                  as int,
        waitingCount: null == waitingCount
            ? _value.waitingCount
            : waitingCount // ignore: cast_nullable_to_non_nullable
                  as int,
        estimatedWaitMinutes: null == estimatedWaitMinutes
            ? _value.estimatedWaitMinutes
            : estimatedWaitMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        congestionLevel: null == congestionLevel
            ? _value.congestionLevel
            : congestionLevel // ignore: cast_nullable_to_non_nullable
                  as String,
        activeWindows: null == activeWindows
            ? _value.activeWindows
            : activeWindows // ignore: cast_nullable_to_non_nullable
                  as int,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueStatusImpl implements _QueueStatus {
  const _$QueueStatusImpl({
    required this.officeId,
    required this.waitingCount,
    required this.estimatedWaitMinutes,
    required this.congestionLevel,
    required this.activeWindows,
    required this.updatedAt,
  });

  factory _$QueueStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueStatusImplFromJson(json);

  @override
  final int officeId;
  @override
  final int waitingCount;
  @override
  final int estimatedWaitMinutes;
  @override
  final String congestionLevel;
  @override
  final int activeWindows;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'QueueStatus(officeId: $officeId, waitingCount: $waitingCount, estimatedWaitMinutes: $estimatedWaitMinutes, congestionLevel: $congestionLevel, activeWindows: $activeWindows, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueStatusImpl &&
            (identical(other.officeId, officeId) ||
                other.officeId == officeId) &&
            (identical(other.waitingCount, waitingCount) ||
                other.waitingCount == waitingCount) &&
            (identical(other.estimatedWaitMinutes, estimatedWaitMinutes) ||
                other.estimatedWaitMinutes == estimatedWaitMinutes) &&
            (identical(other.congestionLevel, congestionLevel) ||
                other.congestionLevel == congestionLevel) &&
            (identical(other.activeWindows, activeWindows) ||
                other.activeWindows == activeWindows) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    officeId,
    waitingCount,
    estimatedWaitMinutes,
    congestionLevel,
    activeWindows,
    updatedAt,
  );

  /// Create a copy of QueueStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueStatusImplCopyWith<_$QueueStatusImpl> get copyWith =>
      __$$QueueStatusImplCopyWithImpl<_$QueueStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueStatusImplToJson(this);
  }
}

abstract class _QueueStatus implements QueueStatus {
  const factory _QueueStatus({
    required final int officeId,
    required final int waitingCount,
    required final int estimatedWaitMinutes,
    required final String congestionLevel,
    required final int activeWindows,
    required final DateTime updatedAt,
  }) = _$QueueStatusImpl;

  factory _QueueStatus.fromJson(Map<String, dynamic> json) =
      _$QueueStatusImpl.fromJson;

  @override
  int get officeId;
  @override
  int get waitingCount;
  @override
  int get estimatedWaitMinutes;
  @override
  String get congestionLevel;
  @override
  int get activeWindows;
  @override
  DateTime get updatedAt;

  /// Create a copy of QueueStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueStatusImplCopyWith<_$QueueStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
