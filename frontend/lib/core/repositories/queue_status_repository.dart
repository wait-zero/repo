import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/api_constants.dart';
import '../models/queue_status.dart';
import '../network/dio_client.dart';

final queueStatusRepositoryProvider = Provider<QueueStatusRepository>((ref) {
  return QueueStatusRepository(ref.watch(dioProvider));
});

class QueueStatusRepository {
  final Dio _dio;

  QueueStatusRepository(this._dio);

  Future<QueueStatus?> getStatus(int officeId) async {
    final response = await _dio.get(ApiConstants.queueStatus(officeId));
    final data = response.data;
    if (data['success'] == true && data['data'] != null) {
      return QueueStatus.fromJson(data['data'] as Map<String, dynamic>);
    }
    return null;
  }
}
