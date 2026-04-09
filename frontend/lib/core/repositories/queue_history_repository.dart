import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/api_constants.dart';
import '../models/queue_trend.dart';
import '../network/dio_client.dart';

final queueHistoryRepositoryProvider =
    Provider<QueueHistoryRepository>((ref) {
  return QueueHistoryRepository(ref.watch(dioProvider));
});

class QueueHistoryRepository {
  final Dio _dio;

  QueueHistoryRepository(this._dio);

  Future<QueueTrendResponse> getTrends(int officeId) async {
    final response = await _dio.get(ApiConstants.queueTrends(officeId));
    final data = response.data as Map<String, dynamic>;
    if (data['success'] == true && data['data'] != null) {
      return QueueTrendResponse.fromJson(
          data['data'] as Map<String, dynamic>);
    }
    throw Exception(data['message'] ?? '추세 데이터를 불러올 수 없습니다.');
  }
}
