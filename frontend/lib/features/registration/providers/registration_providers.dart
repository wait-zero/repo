import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/category.dart';
import '../../../core/models/pre_registration.dart';
import '../../../core/repositories/category_repository.dart';
import '../../../core/repositories/pre_registration_repository.dart';
import '../../auth/providers/auth_providers.dart';

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final repo = ref.watch(categoryRepositoryProvider);
  return repo.getCategories();
});

final myRegistrationsProvider =
    FutureProvider<List<PreRegistration>>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return [];

  final repo = ref.watch(preRegistrationRepositoryProvider);
  return repo.getMyRegistrations();
});
