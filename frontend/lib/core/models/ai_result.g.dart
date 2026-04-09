// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AiClassifyResultImpl _$$AiClassifyResultImplFromJson(
  Map<String, dynamic> json,
) => _$AiClassifyResultImpl(
  category: json['category'] as String,
  confidence: (json['confidence'] as num).toDouble(),
  summary: json['summary'] as String,
);

Map<String, dynamic> _$$AiClassifyResultImplToJson(
  _$AiClassifyResultImpl instance,
) => <String, dynamic>{
  'category': instance.category,
  'confidence': instance.confidence,
  'summary': instance.summary,
};

_$AiSummarizeResultImpl _$$AiSummarizeResultImplFromJson(
  Map<String, dynamic> json,
) => _$AiSummarizeResultImpl(summary: json['summary'] as String);

Map<String, dynamic> _$$AiSummarizeResultImplToJson(
  _$AiSummarizeResultImpl instance,
) => <String, dynamic>{'summary': instance.summary};
