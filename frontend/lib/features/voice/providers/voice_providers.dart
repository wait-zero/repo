import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/ai_result.dart';
import '../../../core/repositories/ai_repository.dart';

final aiClassifyProvider =
    FutureProvider.family<AiClassifyResult, String>((ref, text) async {
  final repo = ref.watch(aiRepositoryProvider);
  return repo.classify(text);
});
