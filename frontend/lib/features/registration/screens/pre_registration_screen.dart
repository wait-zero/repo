import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/models/pre_registration.dart';
import '../../../core/models/queue_status.dart';
import '../../../core/repositories/pre_registration_repository.dart';
import '../../auth/providers/auth_providers.dart';
import '../../office/providers/office_providers.dart';
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
  String? _selectedTaskName;
  DateTime _visitDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay? _visitTime;
  final _contentController = TextEditingController();
  final _customTaskController = TextEditingController();
  String? _voiceText;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _contentController.dispose();
    _customTaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.officeId == null) {
      return const Scaffold(body: Center(child: Text('민원실 정보가 없습니다.')));
    }

    final officeAsync = ref.watch(officeDetailProvider(widget.officeId!));

    return Scaffold(
      appBar: AppBar(
        title: const Text('선 정보 입력'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: officeAsync.when(
        loading: () => const LoadingWidget(),
        error: (error, _) => AppErrorWidget(
          message: '민원실 정보를 불러올 수 없습니다.',
          onRetry: () =>
              ref.invalidate(officeDetailProvider(widget.officeId!)),
        ),
        data: (office) {
          final tasks = office.queueStatus?.tasks ?? <TaskStatus>[];

          return Stepper(
            currentStep: _currentStep,
            onStepContinue: () => _onStepContinue(tasks),
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
                        onPressed:
                            _isSubmitting ? null : details.onStepContinue,
                        child: _isSubmitting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
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
              // Step 1: 업무 선택
              Step(
                title: const Text('업무 선택'),
                isActive: _currentStep >= 0,
                state: _currentStep > 0
                    ? StepState.complete
                    : StepState.indexed,
                content: _buildTaskSelection(tasks),
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
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('방문 예정일'),
                      subtitle:
                          Text(DateFormat('yyyy-MM-dd').format(_visitDate)),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _visitDate,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 30)),
                        );
                        if (date != null) {
                          setState(() => _visitDate = date);
                        }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.access_time),
                      title: const Text('방문 예정 시간 (선택)'),
                      subtitle: Text(_visitTime != null
                          ? _visitTime!.format(context)
                          : '미정'),
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: _visitTime ??
                              const TimeOfDay(hour: 10, minute: 0),
                        );
                        if (time != null) {
                          setState(() => _visitTime = time);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
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
                    OutlinedButton.icon(
                      onPressed: () async {
                        final result =
                            await context.push<Map<String, dynamic>>(
                                '/voice-input');
                        if (result != null) {
                          setState(() {
                            _voiceText = result['voiceText'] as String?;
                            if (result['content'] != null) {
                              _contentController.text =
                                  result['content'] as String;
                            }
                            // 음성 분류 결과로 업무명 추정 (참고용)
                            if (result['taskName'] != null &&
                                _selectedTaskName == null) {
                              _selectedTaskName = result['taskName'] as String;
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
                          label: '업무',
                          value: _selectedTaskName ?? '-',
                        ),
                        _ConfirmRow(
                          label: '방문 예정일',
                          value:
                              DateFormat('yyyy-MM-dd').format(_visitDate),
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

  /// 해당 민원실의 실시간 업무 목록 + 직접 입력 옵션
  Widget _buildTaskSelection(List<TaskStatus> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (tasks.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              '실시간 업무 목록을 불러올 수 없습니다. 직접 입력해주세요.',
              style: TextStyle(color: Colors.grey[600]),
            ),
          )
        else
          ...tasks
              .where((t) => t.taskName != null && t.taskName!.isNotEmpty)
              .map((t) => RadioListTile<String>(
                    value: t.taskName!,
                    groupValue: _selectedTaskName,
                    onChanged: (value) {
                      setState(() {
                        _selectedTaskName = value;
                        _customTaskController.clear();
                      });
                    },
                    title: Text(t.taskName!),
                    subtitle: Text('대기 ${t.waitingCount}명'),
                    dense: true,
                  )),
        const Divider(),
        TextField(
          controller: _customTaskController,
          decoration: const InputDecoration(
            labelText: '직접 입력',
            hintText: '목록에 없는 업무는 직접 입력해주세요',
            prefixIcon: Icon(Icons.edit),
          ),
          onChanged: (value) {
            setState(() {
              _selectedTaskName = value.isEmpty ? null : value;
            });
          },
        ),
      ],
    );
  }

  void _onStepContinue(List<TaskStatus> tasks) {
    if (_currentStep == 0) {
      if (_selectedTaskName == null || _selectedTaskName!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('업무를 선택하거나 입력해주세요.')),
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
    if (widget.officeId == null || _selectedTaskName == null) return;

    setState(() => _isSubmitting = true);
    try {
      final userId = ref.read(currentUserIdProvider);
      if (userId == null) return;

      final repo = ref.read(preRegistrationRepositoryProvider);
      final request = PreRegistrationRequest(
        userId: userId,
        officeId: widget.officeId!,
        taskName: _selectedTaskName,
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
