import 'package:freezed_annotation/freezed_annotation.dart';

part 'pre_registration.freezed.dart';
part 'pre_registration.g.dart';

@freezed
class PreRegistration with _$PreRegistration {
  const factory PreRegistration({
    required int id,
    required int userId,
    required int officeId,
    required String officeName,
    String? taskName,
    String? content,
    String? voiceText,
    String? aiSummary,
    required String status,
    required String visitDate,
    String? visitTime,
    required DateTime createdAt,
  }) = _PreRegistration;

  factory PreRegistration.fromJson(Map<String, dynamic> json) =>
      _$PreRegistrationFromJson(json);
}

@freezed
class PreRegistrationRequest with _$PreRegistrationRequest {
  const factory PreRegistrationRequest({
    required int userId,
    required int officeId,
    String? taskName,
    String? content,
    String? voiceText,
    required String visitDate,
    String? visitTime,
  }) = _PreRegistrationRequest;

  factory PreRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$PreRegistrationRequestFromJson(json);
}
