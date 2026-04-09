import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/api_constants.dart';
import '../models/pre_registration.dart';
import '../network/dio_client.dart';

final preRegistrationRepositoryProvider =
    Provider<PreRegistrationRepository>((ref) {
  return PreRegistrationRepository(ref.watch(dioProvider));
});

class PreRegistrationRepository {
  final Dio _dio;

  PreRegistrationRepository(this._dio);

  Future<PreRegistration> create(PreRegistrationRequest request) async {
    final response = await _dio.post(
      ApiConstants.preRegistrations,
      data: request.toJson(),
    );
    return PreRegistration.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }

  Future<PreRegistration> getById(int id) async {
    final response = await _dio.get(ApiConstants.preRegistrationDetail(id));
    return PreRegistration.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }

  Future<List<PreRegistration>> getByUserId(int userId) async {
    final response =
        await _dio.get(ApiConstants.preRegistrationsByUser(userId));
    final data = response.data;
    if (data['success'] == true && data['data'] != null) {
      return (data['data'] as List)
          .map((e) => PreRegistration.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<PreRegistration> updateStatus(int id, String status) async {
    final response = await _dio.patch(
      ApiConstants.preRegistrationStatus(id),
      data: {'status': status},
    );
    return PreRegistration.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }
}
