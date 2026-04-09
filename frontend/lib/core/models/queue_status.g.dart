// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueueStatusImpl _$$QueueStatusImplFromJson(Map<String, dynamic> json) =>
    _$QueueStatusImpl(
      officeId: (json['officeId'] as num).toInt(),
      waitingCount: (json['waitingCount'] as num).toInt(),
      estimatedWaitMinutes: (json['estimatedWaitMinutes'] as num).toInt(),
      congestionLevel: json['congestionLevel'] as String,
      activeWindows: (json['activeWindows'] as num).toInt(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$QueueStatusImplToJson(_$QueueStatusImpl instance) =>
    <String, dynamic>{
      'officeId': instance.officeId,
      'waitingCount': instance.waitingCount,
      'estimatedWaitMinutes': instance.estimatedWaitMinutes,
      'congestionLevel': instance.congestionLevel,
      'activeWindows': instance.activeWindows,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
