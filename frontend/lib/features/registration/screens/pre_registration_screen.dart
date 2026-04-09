import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/models/category.dart';
import '../../../core/models/pre_registration.dart';
import '../../../core/repositories/pre_registration_repository.dart';
import '../../auth/providers/auth_providers.dart';
import '../providers/registration_providers.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/error_widget.dart';

class PreRegistrationScreen extends ConsumerStatefulWidget {
  final int? officeId;

  const PreRegistrationScreen({super.key, this.officeId});

  @override
  ConsumerState<PreRegistrationScreen> createState() =>
      _PreRegistrationScreenState();
}

class _PreRegistrationScreenState
    extends ConsumerState<PreRegistrationScreen> {
  int _currentStep = 0;
  Category? _selectedCategory;
  DateTime _visitDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay? _visitTime;
  final _contentController = TextEditingController();
  String? _voiceText;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('선 정보 입력'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: categoriesAsync.when(
        loading: () => const LoadingWidget(),
        error: (error, _) => AppErrorWidget(
          message: '카테고리를 불러올 수 없습니다.',
          onRetry: () => ref.invalidate(categoriesProvider),
        ),
        data: (categories) {
          return Stepper(
            currentStep: _currentStep,
            onStepContinue: () => _onStepContinue(categories),
            onStepCancel: _onStepCancel,
            controlsBuilder: (context, details) {
              return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    if (_currentStep < 2)
                      FilledButton(
                        onPressed: details.onStepContinue,
                        child: const Text('다음'),
                      )
                    else
                      FilledButton(
                        onPressed: _isSubmitting ? null : details.onStepContinue,
                        child: _isSubmitting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('제출'),
                      ),
                    const SizedBox(width: 8),
                    if (_currentStep > 0)
                      TextButton(
                        onPressed: details.onStepCancel,
                        child: const Text('이전'),
                      ),
                  ],
                ),
              );
            },
            steps: [
              // Step 1: 카테고리 선택
              Step(
                title: const Text('카테고리 선택'),
                isActive: _currentStep >= 0,
                state: _currentStep > 0
                    ? StepState.complete
                    : StepState.indexed,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioGroup<int>(
                      groupValue: _selectedCategory?.id ?? -1,
                      onChanged: (value) {
                        final cat = categories.firstWhere((c) => c.id == value);
                        setState(() => _selectedCategory = cat);
                      },
                      child: Column(
                        children: categories.map((cat) => ListTile(
                              leading: Radio<int>(value: cat.id),
                              title: Text(cat.name),
                              subtitle: cat.description != null
                                  ? Text(cat.description!)
                                  : null,
                              onTap: () {
                                setState(() => _selectedCategory = cat);
                              },
                            )).toList(),
                      ),
                    ),
                    if (_selectedCategory != null &&
                        _selectedCategory!.requiredDocuments.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Card(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withValues(alpha: 0.3),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '필요 서류',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              ..._selectedCategory!.requiredDocuments
                                  .map((doc) => Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.check_circle,
                                                size: 16),
                                            const SizedBox(width: 4),
                                            Text(doc),
                                          ],
                                        ),
                                      )),
                              if (_selectedCategory!
                                      .estimatedProcessMinutes !=
                                  null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  '예상 처리 시간: ${_selectedCategory!.estimatedProcessMinutes}분',
                                  style:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Step 2: 상세 입력
              Step(
                title: const Text('상세 입력'),
                isActive: _currentStep >= 1,
                state: _currentStep > 1
                    ? StepState.complete
                    : StepState.indexed,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 방문 날짜
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('방문 예정일'),
                      subtitle: Text(
                          DateFormat('yyyy-MM-dd').format(_visitDate)),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _visitDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now()
                              .add(const Duration(days: 30)),
                        );
                        if (date != null) {
                          setState(() => _visitDate = date);
                        }
                      },
                    ),

                    // 방문 시간
                    ListTile(
                      leading: const Icon(Icons.access_time),
                      title: const Text('방문 예정 시간 (선택)'),
                      subtitle: Text(_visitTime != null
                          ? _visitTime!.format(context)
                          : '미정'),
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime:
                              _visitTime ?? const TimeOfDay(hour: 10, minute: 0),
                        );
                        if (time != null) {
                          setState(() => _visitTime = time);
                        }
                      },
                    ),

                    const SizedBox(height: 12),

                    // 민원 내용
                    TextField(
                      controller: _contentController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: '민원 내용 (선택)',
                        hintText: '방문 목적을 간략히 적어주세요',
                        alignLabelWithHint: true,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // 음성 입력 버튼
                    OutlinedButton.icon(
                      onPressed: () async {
                        final result = await context.push<Map<String, dynamic>>(
                            '/voice-input');
                        if (result != null) {
                          setState(() {
                            _voiceText = result['voiceText'] as String?;
                            if (result['content'] != null) {
                              _contentController.text =
                                  result['content'] as String;
                            }
                            if (result['categoryName'] != null) {
                              final catName =
                                  result['categoryName'] as String;
                              final match = categories
                                  .where((c) => c.name == catName);
                              if (match.isNotEmpty) {
                                _selectedCategory = match.first;
                              }
                            }
                          });
                        }
                      },
                      icon: const Icon(Icons.mic),
                      label: Text(
                          _voiceText != null ? '음성 입력 완료' : '음성으로 입력'),
                    ),
                  ],
                ),
              ),

              // Step 3: 확인
              Step(
                title: const Text('확인'),
                isActive: _currentStep >= 2,
                content: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ConfirmRow(
                          label: '카테고리',
                          value: _selectedCategory?.name ?? '-',
                        ),
                        _ConfirmRow(
                          label: '방문 예정일',
                          value: DateFormat('yyyy-MM-dd')
                              .format(_visitDate),
                        ),
                        _ConfirmRow(
                          label: '방문 시간',
                          value: _visitTime?.format(context) ?? '미정',
                        ),
                        if (_contentController.text.isNotEmpty)
                          _ConfirmRow(
                            label: '민원 내용',
                            value: _contentController.text,
                          ),
                        if (_voiceText != null)
                          _ConfirmRow(
                            label: '음성 입력',
                            value: _voiceText!,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onStepContinue(List<Category> categories) {
    if (_currentStep == 0) {
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('카테고리를 선택해주세요.')),
        );
        return;
      }
    }
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      _submit();
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  Future<void> _submit() async {
    if (widget.officeId == null || _selectedCategory == null) return;

    setState(() => _isSubmitting = true);
    try {
      final userId = ref.read(currentUserIdProvider);
      if (userId == null) return;

      final repo = ref.read(preRegistrationRepositoryProvider);
      final request = PreRegistrationRequest(
        userId: userId,
        officeId: widget.officeId!,
        categoryId: _selectedCategory!.id,
        content: _contentController.text.isEmpty
            ? null
            : _contentController.text,
        voiceText: _voiceText,
        visitDate: DateFormat('yyyy-MM-dd').format(_visitDate),
        visitTime: _visitTime != null
            ? '${_visitTime!.hour.toString().padLeft(2, '0')}:${_visitTime!.minute.toString().padLeft(2, '0')}'
            : null,
      );
      await repo.create(request);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('선 정보가 등록되었습니다.')),
        );
        ref.invalidate(myRegistrationsProvider);
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('등록 실패: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}

class _ConfirmRow extends StatelessWidget {
  final String label;
  final String value;

  const _ConfirmRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ),
          Expanded(
            child: Text(value,
                style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
