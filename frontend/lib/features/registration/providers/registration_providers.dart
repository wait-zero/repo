import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/models/category.dart';
import '../../../core/models/pre_registration.dart';
import '../../../core/repositories/category_repository.dart';
import '../../../core/repositories/pre_registration_repository.dart';

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final repo = ref.watch(categoryRepositoryProvider);
  return repo.getCategories();
});

final myRegistrationsProvider =
    FutureProvider<List<PreRegistration>>((ref) async {
  final repo = ref.watch(preRegistrationRepositoryProvider);
  return repo.getByUserId(AppConstants.defaultUserId);
});
