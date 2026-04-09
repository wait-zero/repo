import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/queue_trend.dart';
import '../../../core/repositories/queue_history_repository.dart';

final officeTrendProvider =
    FutureProvider.family<QueueTrendResponse, int>((ref, officeId) async {
  final repo = ref.watch(queueHistoryRepositoryProvider);
  return repo.getTrends(officeId);
});
