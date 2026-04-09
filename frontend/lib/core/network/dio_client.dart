import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/api_constants.dart';
import '../../features/auth/providers/auth_providers.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final token = ref.read(authTokenProvider);
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      handler.next(options);
    },
  ));

  dio.interceptors.add(
    LogInterceptor(requestBody: true, responseBody: true),
  );

  return dio;
});

/// API 응답에서 data 필드를 추출하는 헬퍼
T? extractData<T>(
  Map<String, dynamic> json,
  T Function(dynamic) fromJson,
) {
  if (json['success'] == true && json['data'] != null) {
    return fromJson(json['data']);
  }
  return null;
}

List<T> extractDataList<T>(
  Map<String, dynamic> json,
  T Function(Map<String, dynamic>) fromJson,
) {
  if (json['success'] == true && json['data'] != null) {
    return (json['data'] as List).map((e) => fromJson(e as Map<String, dynamic>)).toList();
  }
  return [];
}
