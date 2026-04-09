// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AiClassifyResult _$AiClassifyResultFromJson(Map<String, dynamic> json) {
  return _AiClassifyResult.fromJson(json);
}

/// @nodoc
mixin _$AiClassifyResult {
  String get category => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;

  /// Serializes this AiClassifyResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiClassifyResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiClassifyResultCopyWith<AiClassifyResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiClassifyResultCopyWith<$Res> {
  factory $AiClassifyResultCopyWith(
    AiClassifyResult value,
    $Res Function(AiClassifyResult) then,
  ) = _$AiClassifyResultCopyWithImpl<$Res, AiClassifyResult>;
  @useResult
  $Res call({String category, double confidence, String summary});
}

/// @nodoc
class _$AiClassifyResultCopyWithImpl<$Res, $Val extends AiClassifyResult>
    implements $AiClassifyResultCopyWith<$Res> {
  _$AiClassifyResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiClassifyResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? confidence = null,
    Object? summary = null,
  }) {
    return _then(
      _value.copyWith(
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AiClassifyResultImplCopyWith<$Res>
    implements $AiClassifyResultCopyWith<$Res> {
  factory _$$AiClassifyResultImplCopyWith(
    _$AiClassifyResultImpl value,
    $Res Function(_$AiClassifyResultImpl) then,
  ) = __$$AiClassifyResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String category, double confidence, String summary});
}

/// @nodoc
class __$$AiClassifyResultImplCopyWithImpl<$Res>
    extends _$AiClassifyResultCopyWithImpl<$Res, _$AiClassifyResultImpl>
    implements _$$AiClassifyResultImplCopyWith<$Res> {
  __$$AiClassifyResultImplCopyWithImpl(
    _$AiClassifyResultImpl _value,
    $Res Function(_$AiClassifyResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiClassifyResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? confidence = null,
    Object? summary = null,
  }) {
    return _then(
      _$AiClassifyResultImpl(
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiClassifyResultImpl implements _AiClassifyResult {
  const _$AiClassifyResultImpl({
    required this.category,
    required this.confidence,
    required this.summary,
  });

  factory _$AiClassifyResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiClassifyResultImplFromJson(json);

  @override
  final String category;
  @override
  final double confidence;
  @override
  final String summary;

  @override
  String toString() {
    return 'AiClassifyResult(category: $category, confidence: $confidence, summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiClassifyResultImpl &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, category, confidence, summary);

  /// Create a copy of AiClassifyResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiClassifyResultImplCopyWith<_$AiClassifyResultImpl> get copyWith =>
      __$$AiClassifyResultImplCopyWithImpl<_$AiClassifyResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AiClassifyResultImplToJson(this);
  }
}

abstract class _AiClassifyResult implements AiClassifyResult {
  const factory _AiClassifyResult({
    required final String category,
    required final double confidence,
    required final String summary,
  }) = _$AiClassifyResultImpl;

  factory _AiClassifyResult.fromJson(Map<String, dynamic> json) =
      _$AiClassifyResultImpl.fromJson;

  @override
  String get category;
  @override
  double get confidence;
  @override
  String get summary;

  /// Create a copy of AiClassifyResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiClassifyResultImplCopyWith<_$AiClassifyResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AiSummarizeResult _$AiSummarizeResultFromJson(Map<String, dynamic> json) {
  return _AiSummarizeResult.fromJson(json);
}

/// @nodoc
mixin _$AiSummarizeResult {
  String get summary => throw _privateConstructorUsedError;

  /// Serializes this AiSummarizeResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiSummarizeResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiSummarizeResultCopyWith<AiSummarizeResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiSummarizeResultCopyWith<$Res> {
  factory $AiSummarizeResultCopyWith(
    AiSummarizeResult value,
    $Res Function(AiSummarizeResult) then,
  ) = _$AiSummarizeResultCopyWithImpl<$Res, AiSummarizeResult>;
  @useResult
  $Res call({String summary});
}

/// @nodoc
class _$AiSummarizeResultCopyWithImpl<$Res, $Val extends AiSummarizeResult>
    implements $AiSummarizeResultCopyWith<$Res> {
  _$AiSummarizeResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiSummarizeResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? summary = null}) {
    return _then(
      _value.copyWith(
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AiSummarizeResultImplCopyWith<$Res>
    implements $AiSummarizeResultCopyWith<$Res> {
  factory _$$AiSummarizeResultImplCopyWith(
    _$AiSummarizeResultImpl value,
    $Res Function(_$AiSummarizeResultImpl) then,
  ) = __$$AiSummarizeResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String summary});
}

/// @nodoc
class __$$AiSummarizeResultImplCopyWithImpl<$Res>
    extends _$AiSummarizeResultCopyWithImpl<$Res, _$AiSummarizeResultImpl>
    implements _$$AiSummarizeResultImplCopyWith<$Res> {
  __$$AiSummarizeResultImplCopyWithImpl(
    _$AiSummarizeResultImpl _value,
    $Res Function(_$AiSummarizeResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiSummarizeResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? summary = null}) {
    return _then(
      _$AiSummarizeResultImpl(
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiSummarizeResultImpl implements _AiSummarizeResult {
  const _$AiSummarizeResultImpl({required this.summary});

  factory _$AiSummarizeResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiSummarizeResultImplFromJson(json);

  @override
  final String summary;

  @override
  String toString() {
    return 'AiSummarizeResult(summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiSummarizeResultImpl &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, summary);

  /// Create a copy of AiSummarizeResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiSummarizeResultImplCopyWith<_$AiSummarizeResultImpl> get copyWith =>
      __$$AiSummarizeResultImplCopyWithImpl<_$AiSummarizeResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AiSummarizeResultImplToJson(this);
  }
}

abstract class _AiSummarizeResult implements AiSummarizeResult {
  const factory _AiSummarizeResult({required final String summary}) =
      _$AiSummarizeResultImpl;

  factory _AiSummarizeResult.fromJson(Map<String, dynamic> json) =
      _$AiSummarizeResultImpl.fromJson;

  @override
  String get summary;

  /// Create a copy of AiSummarizeResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiSummarizeResultImplCopyWith<_$AiSummarizeResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
