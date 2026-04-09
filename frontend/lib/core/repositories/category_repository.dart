import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/api_constants.dart';
import '../models/category.dart';
import '../network/dio_client.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepository(ref.watch(dioProvider));
});

class CategoryRepository {
  final Dio _dio;

  CategoryRepository(this._dio);

  Future<List<Category>> getCategories() async {
    final response = await _dio.get(ApiConstants.categories);
    final data = response.data;
    if (data['success'] == true && data['data'] != null) {
      return (data['data'] as List)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<Category> getCategory(int id) async {
    final response = await _dio.get(ApiConstants.categoryDetail(id));
    return Category.fromJson(response.data['data'] as Map<String, dynamic>);
  }
}
