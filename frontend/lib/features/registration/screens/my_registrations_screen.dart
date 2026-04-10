import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/repositories/pre_registration_repository.dart';
import '../providers/registration_providers.dart';
import '../widgets/registration_card.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../../shared/widgets/empty_widget.dart';

class MyRegistrationsScreen extends ConsumerWidget {
  const MyRegistrationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationsAsync = ref.watch(myRegistrationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('내 신청'),
      ),
      body: registrationsAsync.when(
        loading: () => const LoadingWidget(),
        error: (error, _) => AppErrorWidget(
          message: '신청 목록을 불러올 수 없습니다.',
          onRetry: () => ref.invalidate(myRegistrationsProvider),
        ),
        data: (registrations) {
          if (registrations.isEmpty) {
            return const EmptyWidget(
              message: '등록된 신청이 없습니다.\n민원실에서 선 정보를 입력해보세요.',
              icon: Icons.list_alt_outlined,
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(myRegistrationsProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: registrations.length,
              itemBuilder: (context, index) {
                final reg = registrations[index];
                return RegistrationCard(
                  registration: reg,
                  onTap: () => _showDetail(context, ref, reg),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showDetail(BuildContext context, WidgetRef ref, dynamic reg) {
    final statusColor =
        AppConstants.statusColors[reg.status] ?? Colors.grey;
    final statusLabel =
        AppConstants.statusLabels[reg.status] ?? reg.status;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.5,
          maxChildSize: 0.8,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '신청 상세',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          statusLabel,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _DetailRow(label: '민원실', value: reg.officeName),
                  _DetailRow(label: '업무', value: reg.taskName ?? '업무 미지정'),
                  _DetailRow(label: '방문 예정일', value: reg.visitDate),
                  if (reg.visitTime != null)
                    _DetailRow(label: '방문 시간', value: reg.visitTime!),
                  if (reg.content != null)
                    _DetailRow(label: '민원 내용', value: reg.content!),
                  if (reg.voiceText != null)
                    _DetailRow(label: '음성 원문', value: reg.voiceText!),
                  if (reg.aiSummary != null)
                    _DetailRow(label: 'AI 요약', value: reg.aiSummary!),
                  const SizedBox(height: 24),
                  if (reg.status == 'PENDING' ||
                      reg.status == 'CONFIRMED')
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                        ),
                        onPressed: () async {
                          final repo =
                              ref.read(preRegistrationRepositoryProvider);
                          await repo.updateStatus(reg.id, 'CANCELLED');
                          ref.invalidate(myRegistrationsProvider);
                          if (context.mounted) Navigator.pop(context);
                        },
                        child: const Text('신청 취소'),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
