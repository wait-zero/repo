import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_status.freezed.dart';
part 'queue_status.g.dart';

@freezed
class QueueStatus with _$QueueStatus {
  const factory QueueStatus({
    required int officeId,
    required int waitingCount,
    required int estimatedWaitMinutes,
    required String congestionLevel,
    required int activeWindows,
    required DateTime updatedAt,
  }) = _QueueStatus;

  factory QueueStatus.fromJson(Map<String, dynamic> json) =>
      _$QueueStatusFromJson(json);
}
