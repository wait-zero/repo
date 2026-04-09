import 'package:freezed_annotation/freezed_annotation.dart';
import 'queue_status.dart';

part 'office.freezed.dart';
part 'office.g.dart';

@freezed
class Office with _$Office {
  const factory Office({
    required int id,
    required String name,
    required String address,
    double? latitude,
    double? longitude,
    String? phone,
    String? operatingHours,
  }) = _Office;

  factory Office.fromJson(Map<String, dynamic> json) =>
      _$OfficeFromJson(json);
}

@freezed
class OfficeDetail with _$OfficeDetail {
  const factory OfficeDetail({
    required int id,
    required String name,
    required String address,
    String? detailAddress,
    double? latitude,
    double? longitude,
    String? phone,
    String? operatingHours,
    String? regionCode,
    String? nightOperation,
    String? weekendOperation,
    QueueStatus? queueStatus,
  }) = _OfficeDetail;

  factory OfficeDetail.fromJson(Map<String, dynamic> json) =>
      _$OfficeDetailFromJson(json);
}
