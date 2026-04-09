import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class CongestionBadge extends StatelessWidget {
  final String level;
  final bool showIcon;

  const CongestionBadge({
    super.key,
    required this.level,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppConstants.congestionColor(level);
    final label = AppConstants.congestionLabels[level] ?? level;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(Icons.circle, size: 8, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
