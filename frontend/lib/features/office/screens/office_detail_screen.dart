import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/office_providers.dart';
import '../widgets/queue_status_card.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/error_widget.dart';

class OfficeDetailScreen extends ConsumerWidget {
  final int officeId;

  const OfficeDetailScreen({super.key, required this.officeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(officeDetailProvider(officeId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('민원실 상세'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/offices'),
        ),
      ),
      body: detailAsync.when(
        loading: () => const LoadingWidget(),
        error: (error, _) => AppErrorWidget(
          message: '민원실 정보를 불러올 수 없습니다.',
          onRetry: () => ref.invalidate(officeDetailProvider(officeId)),
        ),
        data: (detail) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(officeDetailProvider(officeId));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 기본 정보 카드
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          _InfoRow(
                            icon: Icons.location_on_outlined,
                            text: detail.address,
                            subText: detail.detailAddress,
                          ),
                          if (detail.phone != null) ...[
                            const SizedBox(height: 8),
                            _InfoRow(
                              icon: Icons.phone_outlined,
                              text: detail.phone!,
                              onTap: () => launchUrl(
                                Uri.parse('tel:${detail.phone}'),
                              ),
                            ),
                          ],
                          if (detail.operatingHours != null) ...[
                            const SizedBox(height: 8),
                            _InfoRow(
                              icon: Icons.access_time_outlined,
                              text: detail.operatingHours!,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 대기 현황 카드
                  if (detail.queueStatus != null)
                    QueueStatusCard(status: detail.queueStatus!)
                  else
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            '대기 현황 정보가 없습니다.',
                            style:
                                Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),

                  // 지도 연결 버튼
                  if (detail.latitude != null && detail.longitude != null)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          final url =
                              'https://maps.google.com/?q=${detail.latitude},${detail.longitude}';
                          launchUrl(Uri.parse(url),
                              mode: LaunchMode.externalApplication);
                        },
                        icon: const Icon(Icons.map_outlined),
                        label: const Text('지도에서 보기'),
                      ),
                    ),

                  const SizedBox(height: 12),

                  // 선 정보 입력 버튼
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        context.push('/pre-register?officeId=$officeId');
                      },
                      icon: const Icon(Icons.edit_note),
                      label: const Text('선 정보 입력'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? subText;
  final VoidCallback? onTap;

  const _InfoRow({
    required this.icon,
    required this.text,
    this.subText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: onTap != null
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                ),
                if (subText != null)
                  Text(
                    subText!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[500],
                        ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
