import 'package:flutter/material.dart';
import '../../../core/models/queue_status.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/congestion_badge.dart';

class QueueStatusCard extends StatelessWidget {
  final QueueStatus status;

  const QueueStatusCard({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final color = AppConstants.congestionColor(status.congestionLevel);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '실시간 대기 현황',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                CongestionBadge(level: status.congestionLevel),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _StatusItem(
                    icon: Icons.people_outline,
                    label: '대기 인원',
                    value: '${status.waitingCount}명',
                    color: color,
                  ),
                ),
                Expanded(
                  child: _StatusItem(
                    icon: Icons.timer_outlined,
                    label: '예상 대기',
                    value: '${status.estimatedWaitMinutes}분',
                    color: color,
                  ),
                ),
                Expanded(
                  child: _StatusItem(
                    icon: Icons.desk_outlined,
                    label: '운영 창구',
                    value: '${status.activeWindows}개',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatusItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }
}
