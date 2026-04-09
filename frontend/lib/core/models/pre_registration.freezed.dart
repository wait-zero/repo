// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pre_registration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PreRegistration _$PreRegistrationFromJson(Map<String, dynamic> json) {
  return _PreRegistration.fromJson(json);
}

/// @nodoc
mixin _$PreRegistration {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  int get officeId => throw _privateConstructorUsedError;
  String get officeName => throw _privateConstructorUsedError;
  int get categoryId => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get voiceText => throw _privateConstructorUsedError;
  String? get aiSummary => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get visitDate => throw _privateConstructorUsedError;
  String? get visitTime => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PreRegistration to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PreRegistration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PreRegistrationCopyWith<PreRegistration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreRegistrationCopyWith<$Res> {
  factory $PreRegistrationCopyWith(
    PreRegistration value,
    $Res Function(PreRegistration) then,
  ) = _$PreRegistrationCopyWithImpl<$Res, PreRegistration>;
  @useResult
  $Res call({
    int id,
    int userId,
    int officeId,
    String officeName,
    int categoryId,
    String categoryName,
    String? content,
    String? voiceText,
    String? aiSummary,
    String status,
    String visitDate,
    String? visitTime,
    DateTime createdAt,
  });
}

/// @nodoc
class _$PreRegistrationCopyWithImpl<$Res, $Val extends PreRegistration>
    implements $PreRegistrationCopyWith<$Res> {
  _$PreRegistrationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PreRegistration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? officeId = null,
    Object? officeName = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? content = freezed,
    Object? voiceText = freezed,
    Object? aiSummary = freezed,
    Object? status = null,
    Object? visitDate = null,
    Object? visitTime = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            officeId: null == officeId
                ? _value.officeId
                : officeId // ignore: cast_nullable_to_non_nullable
                      as int,
            officeName: null == officeName
                ? _value.officeName
                : officeName // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
            voiceText: freezed == voiceText
                ? _value.voiceText
                : voiceText // ignore: cast_nullable_to_non_nullable
                      as String?,
            aiSummary: freezed == aiSummary
                ? _value.aiSummary
                : aiSummary // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            visitDate: null == visitDate
                ? _value.visitDate
                : visitDate // ignore: cast_nullable_to_non_nullable
                      as String,
            visitTime: freezed == visitTime
                ? _value.visitTime
                : visitTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PreRegistrationImplCopyWith<$Res>
    implements $PreRegistrationCopyWith<$Res> {
  factory _$$PreRegistrationImplCopyWith(
    _$PreRegistrationImpl value,
    $Res Function(_$PreRegistrationImpl) then,
  ) = __$$PreRegistrationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int userId,
    int officeId,
    String officeName,
    int categoryId,
    String categoryName,
    String? content,
    String? voiceText,
    String? aiSummary,
    String status,
    String visitDate,
    String? visitTime,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$PreRegistrationImplCopyWithImpl<$Res>
    extends _$PreRegistrationCopyWithImpl<$Res, _$PreRegistrationImpl>
    implements _$$PreRegistrationImplCopyWith<$Res> {
  __$$PreRegistrationImplCopyWithImpl(
    _$PreRegistrationImpl _value,
    $Res Function(_$PreRegistrationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PreRegistration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? officeId = null,
    Object? officeName = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? content = freezed,
    Object? voiceText = freezed,
    Object? aiSummary = freezed,
    Object? status = null,
    Object? visitDate = null,
    Object? visitTime = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$PreRegistrationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        officeId: null == officeId
            ? _value.officeId
            : officeId // ignore: cast_nullable_to_non_nullable
                  as int,
        officeName: null == officeName
            ? _value.officeName
            : officeName // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
        voiceText: freezed == voiceText
            ? _value.voiceText
            : voiceText // ignore: cast_nullable_to_non_nullable
                  as String?,
        aiSummary: freezed == aiSummary
            ? _value.aiSummary
            : aiSummary // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        visitDate: null == visitDate
            ? _value.visitDate
            : visitDate // ignore: cast_nullable_to_non_nullable
                  as String,
        visitTime: freezed == visitTime
            ? _value.visitTime
            : visitTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PreRegistrationImpl implements _PreRegistration {
  const _$PreRegistrationImpl({
    required this.id,
    required this.userId,
    required this.officeId,
    required this.officeName,
    required this.categoryId,
    required this.categoryName,
    this.content,
    this.voiceText,
    this.aiSummary,
    required this.status,
    required this.visitDate,
    this.visitTime,
    required this.createdAt,
  });

  factory _$PreRegistrationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PreRegistrationImplFromJson(json);

  @override
  final int id;
  @override
  final int userId;
  @override
  final int officeId;
  @override
  final String officeName;
  @override
  final int categoryId;
  @override
  final String categoryName;
  @override
  final String? content;
  @override
  final String? voiceText;
  @override
  final String? aiSummary;
  @override
  final String status;
  @override
  final String visitDate;
  @override
  final String? visitTime;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'PreRegistration(id: $id, userId: $userId, officeId: $officeId, officeName: $officeName, categoryId: $categoryId, categoryName: $categoryName, content: $content, voiceText: $voiceText, aiSummary: $aiSummary, status: $status, visitDate: $visitDate, visitTime: $visitTime, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreRegistrationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.officeId, officeId) ||
                other.officeId == officeId) &&
            (identical(other.officeName, officeName) ||
                other.officeName == officeName) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.voiceText, voiceText) ||
                other.voiceText == voiceText) &&
            (identical(other.aiSummary, aiSummary) ||
                other.aiSummary == aiSummary) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.visitDate, visitDate) ||
                other.visitDate == visitDate) &&
            (identical(other.visitTime, visitTime) ||
                other.visitTime == visitTime) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    officeId,
    officeName,
    categoryId,
    categoryName,
    content,
    voiceText,
    aiSummary,
    status,
    visitDate,
    visitTime,
    createdAt,
  );

  /// Create a copy of PreRegistration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PreRegistrationImplCopyWith<_$PreRegistrationImpl> get copyWith =>
      __$$PreRegistrationImplCopyWithImpl<_$PreRegistrationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PreRegistrationImplToJson(this);
  }
}

abstract class _PreRegistration implements PreRegistration {
  const factory _PreRegistration({
    required final int id,
    required final int userId,
    required final int officeId,
    required final String officeName,
    required final int categoryId,
    required final String categoryName,
    final String? content,
    final String? voiceText,
    final String? aiSummary,
    required final String status,
    required final String visitDate,
    final String? visitTime,
    required final DateTime createdAt,
  }) = _$PreRegistrationImpl;

  factory _PreRegistration.fromJson(Map<String, dynamic> json) =
      _$PreRegistrationImpl.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  int get officeId;
  @override
  String get officeName;
  @override
  int get categoryId;
  @override
  String get categoryName;
  @override
  String? get content;
  @override
  String? get voiceText;
  @override
  String? get aiSummary;
  @override
  String get status;
  @override
  String get visitDate;
  @override
  String? get visitTime;
  @override
  DateTime get createdAt;

  /// Create a copy of PreRegistration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PreRegistrationImplCopyWith<_$PreRegistrationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PreRegistrationRequest _$PreRegistrationRequestFromJson(
  Map<String, dynamic> json,
) {
  return _PreRegistrationRequest.fromJson(json);
}

/// @nodoc
mixin _$PreRegistrationRequest {
  int get userId => throw _privateConstructorUsedError;
  int get officeId => throw _privateConstructorUsedError;
  int get categoryId => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get voiceText => throw _privateConstructorUsedError;
  String get visitDate => throw _privateConstructorUsedError;
  String? get visitTime => throw _privateConstructorUsedError;

  /// Serializes this PreRegistrationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PreRegistrationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PreRegistrationRequestCopyWith<PreRegistrationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreRegistrationRequestCopyWith<$Res> {
  factory $PreRegistrationRequestCopyWith(
    PreRegistrationRequest value,
    $Res Function(PreRegistrationRequest) then,
  ) = _$PreRegistrationRequestCopyWithImpl<$Res, PreRegistrationRequest>;
  @useResult
  $Res call({
    int userId,
    int officeId,
    int categoryId,
    String? content,
    String? voiceText,
    String visitDate,
    String? visitTime,
  });
}

/// @nodoc
class _$PreRegistrationRequestCopyWithImpl<
  $Res,
  $Val extends PreRegistrationRequest
>
    implements $PreRegistrationRequestCopyWith<$Res> {
  _$PreRegistrationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PreRegistrationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? officeId = null,
    Object? categoryId = null,
    Object? content = freezed,
    Object? voiceText = freezed,
    Object? visitDate = null,
    Object? visitTime = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            officeId: null == officeId
                ? _value.officeId
                : officeId // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
            voiceText: freezed == voiceText
                ? _value.voiceText
                : voiceText // ignore: cast_nullable_to_non_nullable
                      as String?,
            visitDate: null == visitDate
                ? _value.visitDate
                : visitDate // ignore: cast_nullable_to_non_nullable
                      as String,
            visitTime: freezed == visitTime
                ? _value.visitTime
                : visitTime // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PreRegistrationRequestImplCopyWith<$Res>
    implements $PreRegistrationRequestCopyWith<$Res> {
  factory _$$PreRegistrationRequestImplCopyWith(
    _$PreRegistrationRequestImpl value,
    $Res Function(_$PreRegistrationRequestImpl) then,
  ) = __$$PreRegistrationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int userId,
    int officeId,
    int categoryId,
    String? content,
    String? voiceText,
    String visitDate,
    String? visitTime,
  });
}

/// @nodoc
class __$$PreRegistrationRequestImplCopyWithImpl<$Res>
    extends
        _$PreRegistrationRequestCopyWithImpl<$Res, _$PreRegistrationRequestImpl>
    implements _$$PreRegistrationRequestImplCopyWith<$Res> {
  __$$PreRegistrationRequestImplCopyWithImpl(
    _$PreRegistrationRequestImpl _value,
    $Res Function(_$PreRegistrationRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PreRegistrationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? officeId = null,
    Object? categoryId = null,
    Object? content = freezed,
    Object? voiceText = freezed,
    Object? visitDate = null,
    Object? visitTime = freezed,
  }) {
    return _then(
      _$PreRegistrationRequestImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        officeId: null == officeId
            ? _value.officeId
            : officeId // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
        voiceText: freezed == voiceText
            ? _value.voiceText
            : voiceText // ignore: cast_nullable_to_non_nullable
                  as String?,
        visitDate: null == visitDate
            ? _value.visitDate
            : visitDate // ignore: cast_nullable_to_non_nullable
                  as String,
        visitTime: freezed == visitTime
            ? _value.visitTime
            : visitTime // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PreRegistrationRequestImpl implements _PreRegistrationRequest {
  const _$PreRegistrationRequestImpl({
    required this.userId,
    required this.officeId,
    required this.categoryId,
    this.content,
    this.voiceText,
    required this.visitDate,
    this.visitTime,
  });

  factory _$PreRegistrationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PreRegistrationRequestImplFromJson(json);

  @override
  final int userId;
  @override
  final int officeId;
  @override
  final int categoryId;
  @override
  final String? content;
  @override
  final String? voiceText;
  @override
  final String visitDate;
  @override
  final String? visitTime;

  @override
  String toString() {
    return 'PreRegistrationRequest(userId: $userId, officeId: $officeId, categoryId: $categoryId, content: $content, voiceText: $voiceText, visitDate: $visitDate, visitTime: $visitTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreRegistrationRequestImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.officeId, officeId) ||
                other.officeId == officeId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.voiceText, voiceText) ||
                other.voiceText == voiceText) &&
            (identical(other.visitDate, visitDate) ||
                other.visitDate == visitDate) &&
            (identical(other.visitTime, visitTime) ||
                other.visitTime == visitTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    officeId,
    categoryId,
    content,
    voiceText,
    visitDate,
    visitTime,
  );

  /// Create a copy of PreRegistrationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PreRegistrationRequestImplCopyWith<_$PreRegistrationRequestImpl>
  get copyWith =>
      __$$PreRegistrationRequestImplCopyWithImpl<_$PreRegistrationRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PreRegistrationRequestImplToJson(this);
  }
}

abstract class _PreRegistrationRequest implements PreRegistrationRequest {
  const factory _PreRegistrationRequest({
    required final int userId,
    required final int officeId,
    required final int categoryId,
    final String? content,
    final String? voiceText,
    required final String visitDate,
    final String? visitTime,
  }) = _$PreRegistrationRequestImpl;

  factory _PreRegistrationRequest.fromJson(Map<String, dynamic> json) =
      _$PreRegistrationRequestImpl.fromJson;

  @override
  int get userId;
  @override
  int get officeId;
  @override
  int get categoryId;
  @override
  String? get content;
  @override
  String? get voiceText;
  @override
  String get visitDate;
  @override
  String? get visitTime;

  /// Create a copy of PreRegistrationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PreRegistrationRequestImplCopyWith<_$PreRegistrationRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
