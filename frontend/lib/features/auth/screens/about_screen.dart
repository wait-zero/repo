import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('앱 정보'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Icon(
              Icons.access_time_filled,
              size: 80,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'WaitZero',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'v1.0.0',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '민원실 대기 시간, 이제 0으로',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '서비스 소개',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'WaitZero는 전국 민원실의 실시간 대기 현황을 제공하고, '
                      'AI 기반 민원 분류와 음성 입력으로 민원 접수를 간편하게 만드는 서비스입니다.\n\n'
                      '요일별/시간대별 혼잡도 추세 분석으로 가장 한적한 시간에 '
                      '방문할 수 있도록 도와드립니다.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  _InfoTile(
                    icon: Icons.emoji_events_outlined,
                    title: '출품전',
                    subtitle: '2026 전국 통합데이터 활용 공모전 (주제 6번)',
                  ),
                  const Divider(height: 1),
                  _InfoTile(
                    icon: Icons.storage_outlined,
                    title: '데이터 출처',
                    subtitle: '공공데이터포털 민원실 정보 API',
                  ),
                  const Divider(height: 1),
                  _InfoTile(
                    icon: Icons.smart_toy_outlined,
                    title: 'AI 엔진',
                    subtitle: 'Claude API (민원 분류 및 요약)',
                  ),
                  const Divider(height: 1),
                  _InfoTile(
                    icon: Icons.code_outlined,
                    title: '기술 스택',
                    subtitle: 'Flutter + Spring Boot + MySQL',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  _InfoTile(
                    icon: Icons.group_outlined,
                    title: '개발',
                    subtitle: 'Team WaitZero',
                  ),
                  const Divider(height: 1),
                  _InfoTile(
                    icon: Icons.copyright_outlined,
                    title: '저작권',
                    subtitle: '© 2026 WaitZero. All rights reserved.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
