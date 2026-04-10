import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/pre_registration.dart';
import '../../../core/repositories/pre_registration_repository.dart';
import '../../auth/providers/auth_providers.dart';

final myRegistrationsProvider =
    FutureProvider<List<PreRegistration>>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return [];

  final repo = ref.watch(preRegistrationRepositoryProvider);
  return repo.getMyRegistrations();
});
