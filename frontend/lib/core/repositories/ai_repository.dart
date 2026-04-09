import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/api_constants.dart';
import '../models/ai_result.dart';
import '../network/dio_client.dart';

final aiRepositoryProvider = Provider<AiRepository>((ref) {
  return AiRepository(ref.watch(dioProvider));
});

class AiRepository {
  final Dio _dio;

  AiRepository(this._dio);

  Future<AiClassifyResult> classify(String text) async {
    final response = await _dio.post(
      ApiConstants.aiClassify,
      data: {'text': text},
    );
    return AiClassifyResult.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }

  Future<AiSummarizeResult> summarize(String text) async {
    final response = await _dio.post(
      ApiConstants.aiSummarize,
      data: {'text': text},
    );
    return AiSummarizeResult.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }
}
