import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_trend.freezed.dart';
part 'queue_trend.g.dart';

@freezed
class QueueTrendResponse with _$QueueTrendResponse {
  const factory QueueTrendResponse({
    required int officeId,
    required List<TrendDataPoint> dataPoints,
  }) = _QueueTrendResponse;

  factory QueueTrendResponse.fromJson(Map<String, dynamic> json) =>
      _$QueueTrendResponseFromJson(json);
}

@freezed
class TrendDataPoint with _$TrendDataPoint {
  const factory TrendDataPoint({
    required int dayOfWeek,
    required String dayLabel,
    required int hourOfDay,
    required double averageWaitingCount,
  }) = _TrendDataPoint;

  factory TrendDataPoint.fromJson(Map<String, dynamic> json) =>
      _$TrendDataPointFromJson(json);
}
