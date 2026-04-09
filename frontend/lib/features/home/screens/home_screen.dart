import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/home_providers.dart';
import '../../office/widgets/office_card.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/error_widget.dart';
import '../../../shared/widgets/empty_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final officesAsync = ref.watch(officeSearchResultProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.access_time_filled),
            SizedBox(width: 8),
            Text(
              'WaitZero',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 검색바
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              controller: _searchController,
              hintText: '민원실 이름 또는 주소로 검색',
              leading: const Icon(Icons.search),
              trailing: [
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      ref.read(officeSearchQueryProvider.notifier).state = '';
                    },
                  ),
              ],
              onChanged: (value) {
                ref.read(officeSearchQueryProvider.notifier).state = value;
              },
            ),
          ),

          // 민원실 리스트
          Expanded(
            child: officesAsync.when(
              loading: () => const LoadingWidget(),
              error: (error, _) => AppErrorWidget(
                message: '민원실 목록을 불러올 수 없습니다.',
                onRetry: () => ref.invalidate(officeSearchResultProvider),
              ),
              data: (offices) {
                if (offices.isEmpty) {
                  return const EmptyWidget(
                    message: '검색 결과가 없습니다.',
                    icon: Icons.search_off,
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(officeSearchResultProvider);
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
          ),
        ],
      ),
    );
  }
}
