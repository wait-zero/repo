import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/api_constants.dart';
import '../models/office.dart';
import '../network/dio_client.dart';

final officeRepositoryProvider = Provider<OfficeRepository>((ref) {
  return OfficeRepository(ref.watch(dioProvider));
});

class OfficeRepository {
  final Dio _dio;

  OfficeRepository(this._dio);

  Future<List<Office>> getOffices({String? keyword, String? region}) async {
    final queryParams = <String, dynamic>{};
    if (keyword != null && keyword.isNotEmpty) queryParams['keyword'] = keyword;
    if (region != null && region.isNotEmpty) queryParams['region'] = region;

    final response = await _dio.get(
      ApiConstants.offices,
      queryParameters: queryParams,
    );
    final data = response.data;
    if (data['success'] == true && data['data'] != null) {
      return (data['data'] as List)
          .map((e) => Office.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<OfficeDetail> getOfficeDetail(int id) async {
    final response = await _dio.get(ApiConstants.officeDetail(id));
    return OfficeDetail.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  Future<List<Office>> getNearbyOffices(
    double lat,
    double lng, {
    double radius = 5,
  }) async {
    final response = await _dio.get(
      ApiConstants.nearbyOffices,
      queryParameters: {'lat': lat, 'lng': lng, 'radius': radius},
    );
    final data = response.data;
    if (data['success'] == true && data['data'] != null) {
      return (data['data'] as List)
          .map((e) => Office.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}
