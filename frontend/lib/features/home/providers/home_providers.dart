import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/office.dart';
import '../../../core/repositories/office_repository.dart';

final officeSearchQueryProvider = StateProvider<String>((ref) => '');

final officeSearchResultProvider = FutureProvider<List<Office>>((ref) async {
  final query = ref.watch(officeSearchQueryProvider);
  final repo = ref.watch(officeRepositoryProvider);
  return repo.getOffices(keyword: query.isEmpty ? null : query);
});

final nearbyOfficesProvider =
    FutureProvider.family<List<Office>, ({double lat, double lng})>(
  (ref, location) async {
    final repo = ref.watch(officeRepositoryProvider);
    return repo.getNearbyOffices(location.lat, location.lng);
  },
);
