// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_trend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueueTrendResponseImpl _$$QueueTrendResponseImplFromJson(
  Map<String, dynamic> json,
) => _$QueueTrendResponseImpl(
  officeId: (json['officeId'] as num).toInt(),
  dataPoints: (json['dataPoints'] as List<dynamic>)
      .map((e) => TrendDataPoint.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$QueueTrendResponseImplToJson(
  _$QueueTrendResponseImpl instance,
) => <String, dynamic>{
  'officeId': instance.officeId,
  'dataPoints': instance.dataPoints,
};

_$TrendDataPointImpl _$$TrendDataPointImplFromJson(Map<String, dynamic> json) =>
    _$TrendDataPointImpl(
      dayOfWeek: (json['dayOfWeek'] as num).toInt(),
      dayLabel: json['dayLabel'] as String,
      hourOfDay: (json['hourOfDay'] as num).toInt(),
      averageWaitingCount: (json['averageWaitingCount'] as num).toDouble(),
    );

Map<String, dynamic> _$$TrendDataPointImplToJson(
  _$TrendDataPointImpl instance,
) => <String, dynamic>{
  'dayOfWeek': instance.dayOfWeek,
  'dayLabel': instance.dayLabel,
  'hourOfDay': instance.hourOfDay,
  'averageWaitingCount': instance.averageWaitingCount,
};
