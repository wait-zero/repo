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
  int get totalWaitingCount => throw _privateConstructorUsedError;
  int get estimatedWaitMinutes => throw _privateConstructorUsedError;
  String get congestionLevel => throw _privateConstructorUsedError;
  int get activeWindows => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<TaskStatus>? get tasks => throw _privateConstructorUsedError;

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
    int totalWaitingCount,
    int estimatedWaitMinutes,
    String congestionLevel,
    int activeWindows,
    DateTime updatedAt,
    List<TaskStatus>? tasks,
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
    Object? totalWaitingCount = null,
    Object? estimatedWaitMinutes = null,
    Object? congestionLevel = null,
    Object? activeWindows = null,
    Object? updatedAt = null,
    Object? tasks = freezed,
  }) {
    return _then(
      _value.copyWith(
            officeId: null == officeId
                ? _value.officeId
                : officeId // ignore: cast_nullable_to_non_nullable
                      as int,
            totalWaitingCount: null == totalWaitingCount
                ? _value.totalWaitingCount
                : totalWaitingCount // ignore: cast_nullable_to_non_nullable
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
            tasks: freezed == tasks
                ? _value.tasks
                : tasks // ignore: cast_nullable_to_non_nullable
                      as List<TaskStatus>?,
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
    int totalWaitingCount,
    int estimatedWaitMinutes,
    String congestionLevel,
    int activeWindows,
    DateTime updatedAt,
    List<TaskStatus>? tasks,
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
    Object? totalWaitingCount = null,
    Object? estimatedWaitMinutes = null,
    Object? congestionLevel = null,
    Object? activeWindows = null,
    Object? updatedAt = null,
    Object? tasks = freezed,
  }) {
    return _then(
      _$QueueStatusImpl(
        officeId: null == officeId
            ? _value.officeId
            : officeId // ignore: cast_nullable_to_non_nullable
                  as int,
        totalWaitingCount: null == totalWaitingCount
            ? _value.totalWaitingCount
            : totalWaitingCount // ignore: cast_nullable_to_non_nullable
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
        tasks: freezed == tasks
            ? _value._tasks
            : tasks // ignore: cast_nullable_to_non_nullable
                  as List<TaskStatus>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueStatusImpl implements _QueueStatus {
  const _$QueueStatusImpl({
    required this.officeId,
    required this.totalWaitingCount,
    required this.estimatedWaitMinutes,
    required this.congestionLevel,
    required this.activeWindows,
    required this.updatedAt,
    final List<TaskStatus>? tasks,
  }) : _tasks = tasks;

  factory _$QueueStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueStatusImplFromJson(json);

  @override
  final int officeId;
  @override
  final int totalWaitingCount;
  @override
  final int estimatedWaitMinutes;
  @override
  final String congestionLevel;
  @override
  final int activeWindows;
  @override
  final DateTime updatedAt;
  final List<TaskStatus>? _tasks;
  @override
  List<TaskStatus>? get tasks {
    final value = _tasks;
    if (value == null) return null;
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'QueueStatus(officeId: $officeId, totalWaitingCount: $totalWaitingCount, estimatedWaitMinutes: $estimatedWaitMinutes, congestionLevel: $congestionLevel, activeWindows: $activeWindows, updatedAt: $updatedAt, tasks: $tasks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueStatusImpl &&
            (identical(other.officeId, officeId) ||
                other.officeId == officeId) &&
            (identical(other.totalWaitingCount, totalWaitingCount) ||
                other.totalWaitingCount == totalWaitingCount) &&
            (identical(other.estimatedWaitMinutes, estimatedWaitMinutes) ||
                other.estimatedWaitMinutes == estimatedWaitMinutes) &&
            (identical(other.congestionLevel, congestionLevel) ||
                other.congestionLevel == congestionLevel) &&
            (identical(other.activeWindows, activeWindows) ||
                other.activeWindows == activeWindows) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._tasks, _tasks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    officeId,
    totalWaitingCount,
    estimatedWaitMinutes,
    congestionLevel,
    activeWindows,
    updatedAt,
    const DeepCollectionEquality().hash(_tasks),
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
    required final int totalWaitingCount,
    required final int estimatedWaitMinutes,
    required final String congestionLevel,
    required final int activeWindows,
    required final DateTime updatedAt,
    final List<TaskStatus>? tasks,
  }) = _$QueueStatusImpl;

  factory _QueueStatus.fromJson(Map<String, dynamic> json) =
      _$QueueStatusImpl.fromJson;

  @override
  int get officeId;
  @override
  int get totalWaitingCount;
  @override
  int get estimatedWaitMinutes;
  @override
  String get congestionLevel;
  @override
  int get activeWindows;
  @override
  DateTime get updatedAt;
  @override
  List<TaskStatus>? get tasks;

  /// Create a copy of QueueStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueStatusImplCopyWith<_$QueueStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskStatus _$TaskStatusFromJson(Map<String, dynamic> json) {
  return _TaskStatus.fromJson(json);
}

/// @nodoc
mixin _$TaskStatus {
  String? get taskNo => throw _privateConstructorUsedError;
  String? get taskName => throw _privateConstructorUsedError;
  int get waitingCount => throw _privateConstructorUsedError;
  String? get callNumber => throw _privateConstructorUsedError;
  String? get callCounterNo => throw _privateConstructorUsedError;

  /// Serializes this TaskStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskStatusCopyWith<TaskStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskStatusCopyWith<$Res> {
  factory $TaskStatusCopyWith(
    TaskStatus value,
    $Res Function(TaskStatus) then,
  ) = _$TaskStatusCopyWithImpl<$Res, TaskStatus>;
  @useResult
  $Res call({
    String? taskNo,
    String? taskName,
    int waitingCount,
    String? callNumber,
    String? callCounterNo,
  });
}

/// @nodoc
class _$TaskStatusCopyWithImpl<$Res, $Val extends TaskStatus>
    implements $TaskStatusCopyWith<$Res> {
  _$TaskStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskNo = freezed,
    Object? taskName = freezed,
    Object? waitingCount = null,
    Object? callNumber = freezed,
    Object? callCounterNo = freezed,
  }) {
    return _then(
      _value.copyWith(
            taskNo: freezed == taskNo
                ? _value.taskNo
                : taskNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            taskName: freezed == taskName
                ? _value.taskName
                : taskName // ignore: cast_nullable_to_non_nullable
                      as String?,
            waitingCount: null == waitingCount
                ? _value.waitingCount
                : waitingCount // ignore: cast_nullable_to_non_nullable
                      as int,
            callNumber: freezed == callNumber
                ? _value.callNumber
                : callNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            callCounterNo: freezed == callCounterNo
                ? _value.callCounterNo
                : callCounterNo // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TaskStatusImplCopyWith<$Res>
    implements $TaskStatusCopyWith<$Res> {
  factory _$$TaskStatusImplCopyWith(
    _$TaskStatusImpl value,
    $Res Function(_$TaskStatusImpl) then,
  ) = __$$TaskStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? taskNo,
    String? taskName,
    int waitingCount,
    String? callNumber,
    String? callCounterNo,
  });
}

/// @nodoc
class __$$TaskStatusImplCopyWithImpl<$Res>
    extends _$TaskStatusCopyWithImpl<$Res, _$TaskStatusImpl>
    implements _$$TaskStatusImplCopyWith<$Res> {
  __$$TaskStatusImplCopyWithImpl(
    _$TaskStatusImpl _value,
    $Res Function(_$TaskStatusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskNo = freezed,
    Object? taskName = freezed,
    Object? waitingCount = null,
    Object? callNumber = freezed,
    Object? callCounterNo = freezed,
  }) {
    return _then(
      _$TaskStatusImpl(
        taskNo: freezed == taskNo
            ? _value.taskNo
            : taskNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        taskName: freezed == taskName
            ? _value.taskName
            : taskName // ignore: cast_nullable_to_non_nullable
                  as String?,
        waitingCount: null == waitingCount
            ? _value.waitingCount
            : waitingCount // ignore: cast_nullable_to_non_nullable
                  as int,
        callNumber: freezed == callNumber
            ? _value.callNumber
            : callNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        callCounterNo: freezed == callCounterNo
            ? _value.callCounterNo
            : callCounterNo // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskStatusImpl implements _TaskStatus {
  const _$TaskStatusImpl({
    this.taskNo,
    this.taskName,
    required this.waitingCount,
    this.callNumber,
    this.callCounterNo,
  });

  factory _$TaskStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskStatusImplFromJson(json);

  @override
  final String? taskNo;
  @override
  final String? taskName;
  @override
  final int waitingCount;
  @override
  final String? callNumber;
  @override
  final String? callCounterNo;

  @override
  String toString() {
    return 'TaskStatus(taskNo: $taskNo, taskName: $taskName, waitingCount: $waitingCount, callNumber: $callNumber, callCounterNo: $callCounterNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskStatusImpl &&
            (identical(other.taskNo, taskNo) || other.taskNo == taskNo) &&
            (identical(other.taskName, taskName) ||
                other.taskName == taskName) &&
            (identical(other.waitingCount, waitingCount) ||
                other.waitingCount == waitingCount) &&
            (identical(other.callNumber, callNumber) ||
                other.callNumber == callNumber) &&
            (identical(other.callCounterNo, callCounterNo) ||
                other.callCounterNo == callCounterNo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    taskNo,
    taskName,
    waitingCount,
    callNumber,
    callCounterNo,
  );

  /// Create a copy of TaskStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskStatusImplCopyWith<_$TaskStatusImpl> get copyWith =>
      __$$TaskStatusImplCopyWithImpl<_$TaskStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskStatusImplToJson(this);
  }
}

abstract class _TaskStatus implements TaskStatus {
  const factory _TaskStatus({
    final String? taskNo,
    final String? taskName,
    required final int waitingCount,
    final String? callNumber,
    final String? callCounterNo,
  }) = _$TaskStatusImpl;

  factory _TaskStatus.fromJson(Map<String, dynamic> json) =
      _$TaskStatusImpl.fromJson;

  @override
  String? get taskNo;
  @override
  String? get taskName;
  @override
  int get waitingCount;
  @override
  String? get callNumber;
  @override
  String? get callCounterNo;

  /// Create a copy of TaskStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskStatusImplCopyWith<_$TaskStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
