// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OfficeImpl _$$OfficeImplFromJson(Map<String, dynamic> json) => _$OfficeImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  address: json['address'] as String,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  phone: json['phone'] as String?,
  operatingHours: json['operatingHours'] as String?,
);

Map<String, dynamic> _$$OfficeImplToJson(_$OfficeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'phone': instance.phone,
      'operatingHours': instance.operatingHours,
    };

_$OfficeDetailImpl _$$OfficeDetailImplFromJson(Map<String, dynamic> json) =>
    _$OfficeDetailImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      address: json['address'] as String,
      detailAddress: json['detailAddress'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      phone: json['phone'] as String?,
      operatingHours: json['operatingHours'] as String?,
      regionCode: json['regionCode'] as String?,
      nightOperation: json['nightOperation'] as String?,
      weekendOperation: json['weekendOperation'] as String?,
      queueStatus: json['queueStatus'] == null
          ? null
          : QueueStatus.fromJson(json['queueStatus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OfficeDetailImplToJson(_$OfficeDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'detailAddress': instance.detailAddress,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'phone': instance.phone,
      'operatingHours': instance.operatingHours,
      'regionCode': instance.regionCode,
      'nightOperation': instance.nightOperation,
      'weekendOperation': instance.weekendOperation,
      'queueStatus': instance.queueStatus,
    };
