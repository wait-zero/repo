// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PreRegistrationImpl _$$PreRegistrationImplFromJson(
  Map<String, dynamic> json,
) => _$PreRegistrationImpl(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  officeId: (json['officeId'] as num).toInt(),
  officeName: json['officeName'] as String,
  categoryId: (json['categoryId'] as num).toInt(),
  categoryName: json['categoryName'] as String,
  content: json['content'] as String?,
  voiceText: json['voiceText'] as String?,
  aiSummary: json['aiSummary'] as String?,
  status: json['status'] as String,
  visitDate: json['visitDate'] as String,
  visitTime: json['visitTime'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$PreRegistrationImplToJson(
  _$PreRegistrationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'officeId': instance.officeId,
  'officeName': instance.officeName,
  'categoryId': instance.categoryId,
  'categoryName': instance.categoryName,
  'content': instance.content,
  'voiceText': instance.voiceText,
  'aiSummary': instance.aiSummary,
  'status': instance.status,
  'visitDate': instance.visitDate,
  'visitTime': instance.visitTime,
  'createdAt': instance.createdAt.toIso8601String(),
};

_$PreRegistrationRequestImpl _$$PreRegistrationRequestImplFromJson(
  Map<String, dynamic> json,
) => _$PreRegistrationRequestImpl(
  userId: (json['userId'] as num).toInt(),
  officeId: (json['officeId'] as num).toInt(),
  categoryId: (json['categoryId'] as num).toInt(),
  content: json['content'] as String?,
  voiceText: json['voiceText'] as String?,
  visitDate: json['visitDate'] as String,
  visitTime: json['visitTime'] as String?,
);

Map<String, dynamic> _$$PreRegistrationRequestImplToJson(
  _$PreRegistrationRequestImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'officeId': instance.officeId,
  'categoryId': instance.categoryId,
  'content': instance.content,
  'voiceText': instance.voiceText,
  'visitDate': instance.visitDate,
  'visitTime': instance.visitTime,
};
