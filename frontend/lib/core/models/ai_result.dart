import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_result.freezed.dart';
part 'ai_result.g.dart';

@freezed
class AiClassifyResult with _$AiClassifyResult {
  const factory AiClassifyResult({
    required String category,
    required double confidence,
    required String summary,
  }) = _AiClassifyResult;

  factory AiClassifyResult.fromJson(Map<String, dynamic> json) =>
      _$AiClassifyResultFromJson(json);
}

@freezed
class AiSummarizeResult with _$AiSummarizeResult {
  const factory AiSummarizeResult({
    required String summary,
  }) = _AiSummarizeResult;

  factory AiSummarizeResult.fromJson(Map<String, dynamic> json) =>
      _$AiSummarizeResultFromJson(json);
}
