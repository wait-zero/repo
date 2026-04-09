import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/office_providers.dart';
import '../widgets/office_card.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../../shared/widgets/empty_widget.dart';

class OfficeListScreen extends ConsumerWidget {
  const OfficeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final officesAsync = ref.watch(officeListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('민원실 목록'),
      ),
      body: officesAsync.when(
        loading: () => const LoadingWidget(),
        error: (error, _) => AppErrorWidget(
          message: '민원실 목록을 불러올 수 없습니다.',
          onRetry: () => ref.invalidate(officeListProvider),
        ),
        data: (offices) {
          if (offices.isEmpty) {
            return const EmptyWidget(
              message: '등록된 민원실이 없습니다.',
              icon: Icons.business_outlined,
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(officeListProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: offices.length,
              itemBuilder: (context, index) {
                return OfficeCard(
                  office: offices[index],
                  onTap: () {
                    context.go('/offices/${offices[index].id}');
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
