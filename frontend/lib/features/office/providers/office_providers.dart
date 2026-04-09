import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/office.dart';
import '../../../core/models/queue_status.dart';
import '../../../core/repositories/office_repository.dart';
import '../../../core/repositories/queue_status_repository.dart';

final officeListProvider = FutureProvider<List<Office>>((ref) async {
  final repo = ref.watch(officeRepositoryProvider);
  return repo.getOffices();
});

final officeDetailProvider =
    FutureProvider.family<OfficeDetail, int>((ref, id) async {
  final repo = ref.watch(officeRepositoryProvider);
  return repo.getOfficeDetail(id);
});

final queueStatusProvider =
    FutureProvider.family<QueueStatus?, int>((ref, officeId) async {
  final repo = ref.watch(queueStatusRepositoryProvider);
  return repo.getStatus(officeId);
});
