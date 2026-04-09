import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/models/queue_trend.dart';
import '../providers/trend_providers.dart';

enum TrendViewMode { daily, hourly }

class TrendChartWidget extends ConsumerStatefulWidget {
  final int officeId;

  const TrendChartWidget({super.key, required this.officeId});

  @override
  ConsumerState<TrendChartWidget> createState() => _TrendChartWidgetState();
}

class _TrendChartWidgetState extends ConsumerState<TrendChartWidget> {
  TrendViewMode _viewMode = TrendViewMode.daily;
  int _selectedDayOfWeek = 1; // Monday by default

  @override
  Widget build(BuildContext context) {
    final trendAsync = ref.watch(officeTrendProvider(widget.officeId));

    return trendAsync.when(
      loading: () => const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => SizedBox(
        height: 200,
        child: Center(
          child: Text(
            '추세 데이터를 불러올 수 없습니다.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey[600]),
          ),
        ),
      ),
      data: (trendData) {
        if (trendData.dataPoints.isEmpty) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Text(
                '아직 충분한 데이터가 없습니다',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey[600]),
              ),
            ),
          );
        }

        return Column(
          children: [
            // View mode toggle
            SegmentedButton<TrendViewMode>(
              segments: const [
                ButtonSegment(
                  value: TrendViewMode.daily,
                  label: Text('요일별'),
                  icon: Icon(Icons.bar_chart),
                ),
                ButtonSegment(
                  value: TrendViewMode.hourly,
                  label: Text('시간대별'),
                  icon: Icon(Icons.show_chart),
                ),
              ],
              selected: {_viewMode},
              onSelectionChanged: (selected) {
                setState(() => _viewMode = selected.first);
              },
            ),
            const SizedBox(height: 16),
            if (_viewMode == TrendViewMode.hourly) ...[
              _buildDaySelector(trendData),
              const SizedBox(height: 12),
            ],
            SizedBox(
              height: 200,
              child: _viewMode == TrendViewMode.daily
                  ? _buildBarChart(trendData)
                  : _buildLineChart(trendData),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDaySelector(QueueTrendResponse data) {
    // Get unique days from data
    final days = <int, String>{};
    for (final dp in data.dataPoints) {
      days[dp.dayOfWeek] = dp.dayLabel;
    }
    final sortedDays = days.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    // Ensure selected day is valid
    if (!days.containsKey(_selectedDayOfWeek) && sortedDays.isNotEmpty) {
      _selectedDayOfWeek = sortedDays.first.key;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: sortedDays.map((entry) {
          final isSelected = entry.key == _selectedDayOfWeek;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(entry.value),
              selected: isSelected,
              onSelected: (_) {
                setState(() => _selectedDayOfWeek = entry.key);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBarChart(QueueTrendResponse data) {
    // Group by dayOfWeek, average all hours
    final dayAverages = <int, List<double>>{};
    final dayLabels = <int, String>{};
    for (final dp in data.dataPoints) {
      dayAverages.putIfAbsent(dp.dayOfWeek, () => []);
      dayAverages[dp.dayOfWeek]!.add(dp.averageWaitingCount);
      dayLabels[dp.dayOfWeek] = dp.dayLabel;
    }

    final sortedDays = dayAverages.keys.toList()..sort();
    final maxY = dayAverages.values
        .expand((v) => v)
        .fold<double>(0, (prev, e) => max(prev, e));

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: (maxY * 1.2).ceilToDouble(),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final day = sortedDays[group.x];
              final label = dayLabels[day] ?? '';
              return BarTooltipItem(
                '$label\n${rod.toY.toStringAsFixed(1)}명',
                const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= sortedDays.length) {
                  return const SizedBox.shrink();
                }
                final day = sortedDays[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    dayLabels[day] ?? '',
                    style: const TextStyle(fontSize: 11),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(sortedDays.length, (index) {
          final day = sortedDays[index];
          final values = dayAverages[day]!;
          final avg = values.reduce((a, b) => a + b) / values.length;
          final congestionLevel =
              avg <= 5 ? 'LOW' : (avg <= 15 ? 'MEDIUM' : 'HIGH');

          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: avg,
                color: AppConstants.congestionColor(congestionLevel),
                width: 24,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildLineChart(QueueTrendResponse data) {
    // Filter by selected day
    final hourlyData = data.dataPoints
        .where((dp) => dp.dayOfWeek == _selectedDayOfWeek)
        .toList()
      ..sort((a, b) => a.hourOfDay.compareTo(b.hourOfDay));

    if (hourlyData.isEmpty) {
      return Center(
        child: Text(
          '해당 요일의 데이터가 없습니다',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.grey[600]),
        ),
      );
    }

    final maxY = hourlyData
        .map((e) => e.averageWaitingCount)
        .fold<double>(0, (prev, e) => max(prev, e));

    final primaryColor = Theme.of(context).colorScheme.primary;

    return LineChart(
      LineChartData(
        minX: 9,
        maxX: 18,
        minY: 0,
        maxY: (maxY * 1.2).ceilToDouble(),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (spots) {
              return spots.map((spot) {
                return LineTooltipItem(
                  '${spot.x.toInt()}시\n${spot.y.toStringAsFixed(1)}명',
                  const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              }).toList();
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final hour = value.toInt();
                if (hour < 9 || hour > 18) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    '$hour시',
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: hourlyData
                .map((dp) => FlSpot(
                    dp.hourOfDay.toDouble(), dp.averageWaitingCount))
                .toList(),
            isCurved: true,
            curveSmoothness: 0.3,
            color: primaryColor,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: primaryColor,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: primaryColor.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }
}
