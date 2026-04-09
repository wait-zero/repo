import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_status.freezed.dart';
part 'queue_status.g.dart';

@freezed
class QueueStatus with _$QueueStatus {
  const factory QueueStatus({
    required int officeId,
    required int totalWaitingCount,
    required int estimatedWaitMinutes,
    required String congestionLevel,
    required int activeWindows,
    required DateTime updatedAt,
    List<TaskStatus>? tasks,
  }) = _QueueStatus;

  factory QueueStatus.fromJson(Map<String, dynamic> json) =>
      _$QueueStatusFromJson(json);
}

@freezed
class TaskStatus with _$TaskStatus {
  const factory TaskStatus({
    String? taskNo,
    String? taskName,
    required int waitingCount,
    String? callNumber,
    String? callCounterNo,
  }) = _TaskStatus;

  factory TaskStatus.fromJson(Map<String, dynamic> json) =>
      _$TaskStatusFromJson(json);
}
