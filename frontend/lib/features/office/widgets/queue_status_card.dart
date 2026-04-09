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
                    label: '총 대기',
                    value: '${status.totalWaitingCount}명',
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

            // 업무별 대기현황
            if (status.tasks != null && status.tasks!.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              Text(
                '업무별 대기 현황',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              ...status.tasks!
                  .where((t) => t.taskName != null && t.taskName!.isNotEmpty)
                  .map((task) => _TaskRow(task: task)),
            ],
          ],
        ),
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  final TaskStatus task;

  const _TaskRow({required this.task});

  @override
  Widget build(BuildContext context) {
    final hasWaiting = task.waitingCount > 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              task.taskName ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 60,
            child: Text(
              '${task.waitingCount}명',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: hasWaiting ? Colors.red : Colors.green,
                  ),
            ),
          ),
          if (task.callCounterNo != null && task.callCounterNo!.isNotEmpty)
            SizedBox(
              width: 60,
              child: Text(
                '${task.callCounterNo}번',
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ),
        ],
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
