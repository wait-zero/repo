// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueueStatusImpl _$$QueueStatusImplFromJson(Map<String, dynamic> json) =>
    _$QueueStatusImpl(
      officeId: (json['officeId'] as num).toInt(),
      totalWaitingCount: (json['totalWaitingCount'] as num).toInt(),
      estimatedWaitMinutes: (json['estimatedWaitMinutes'] as num).toInt(),
      congestionLevel: json['congestionLevel'] as String,
      activeWindows: (json['activeWindows'] as num).toInt(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((e) => TaskStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$QueueStatusImplToJson(_$QueueStatusImpl instance) =>
    <String, dynamic>{
      'officeId': instance.officeId,
      'totalWaitingCount': instance.totalWaitingCount,
      'estimatedWaitMinutes': instance.estimatedWaitMinutes,
      'congestionLevel': instance.congestionLevel,
      'activeWindows': instance.activeWindows,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'tasks': instance.tasks,
    };

_$TaskStatusImpl _$$TaskStatusImplFromJson(Map<String, dynamic> json) =>
    _$TaskStatusImpl(
      taskNo: json['taskNo'] as String?,
      taskName: json['taskName'] as String?,
      waitingCount: (json['waitingCount'] as num).toInt(),
      callNumber: json['callNumber'] as String?,
      callCounterNo: json['callCounterNo'] as String?,
    );

Map<String, dynamic> _$$TaskStatusImplToJson(_$TaskStatusImpl instance) =>
    <String, dynamic>{
      'taskNo': instance.taskNo,
      'taskName': instance.taskName,
      'waitingCount': instance.waitingCount,
      'callNumber': instance.callNumber,
      'callCounterNo': instance.callCounterNo,
    };
