import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/api_constants.dart';
import '../models/auth_response.dart';
import '../network/dio_client.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(dioProvider));
});

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<AuthResponse> login(String phone, String password) async {
    final response = await _dio.post(
      ApiConstants.authLogin,
      data: {'phone': phone, 'password': password},
    );
    final result = extractData(
      response.data as Map<String, dynamic>,
      (json) => AuthResponse.fromJson(json as Map<String, dynamic>),
    );
    if (result == null) {
      throw Exception(response.data['message'] ?? '로그인에 실패했습니다.');
    }
    return result;
  }

  Future<AuthResponse> signup(
      String name, String phone, String password) async {
    final response = await _dio.post(
      ApiConstants.authSignup,
      data: {'name': name, 'phone': phone, 'password': password},
    );
    final result = extractData(
      response.data as Map<String, dynamic>,
      (json) => AuthResponse.fromJson(json as Map<String, dynamic>),
    );
    if (result == null) {
      throw Exception(response.data['message'] ?? '회원가입에 실패했습니다.');
    }
    return result;
  }

  Future<AuthResponse?> getMe(String token) async {
    try {
      final response = await _dio.get(
        ApiConstants.authMe,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return extractData(
        response.data as Map<String, dynamic>,
        (json) => AuthResponse.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      return null;
    }
  }
}
