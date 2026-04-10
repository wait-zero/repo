import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../core/repositories/ai_repository.dart';
import '../../../core/models/ai_result.dart';

class VoiceInputScreen extends ConsumerStatefulWidget {
  const VoiceInputScreen({super.key});

  @override
  ConsumerState<VoiceInputScreen> createState() => _VoiceInputScreenState();
}

class _VoiceInputScreenState extends ConsumerState<VoiceInputScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _speechAvailable = false;
  String _recognizedText = '';
  final _editController = TextEditingController();
  AiClassifyResult? _classifyResult;
  bool _isClassifying = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _speechAvailable = await _speech.initialize(
      onError: (error) {
        setState(() => _isListening = false);
      },
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          setState(() => _isListening = false);
        }
      },
    );
    setState(() {});
  }

  void _startListening() async {
    if (!_speechAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('음성 인식을 사용할 수 없습니다.')),
      );
      return;
    }
    setState(() {
      _isListening = true;
      _recognizedText = '';
    });
    await _speech.listen(
      onResult: (result) {
        setState(() {
          _recognizedText = result.recognizedWords;
          if (result.finalResult) {
            _editController.text = _recognizedText;
            _isListening = false;
          }
        });
      },
      localeId: 'ko_KR',
      listenOptions: stt.SpeechListenOptions(
        listenMode: stt.ListenMode.dictation,
      ),
    );
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() {
      _isListening = false;
      _editController.text = _recognizedText;
    });
  }

  Future<void> _classify() async {
    final text = _editController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('분류할 텍스트를 입력해주세요.')),
      );
      return;
    }

    setState(() => _isClassifying = true);
    try {
      final repo = ref.read(aiRepositoryProvider);
      final result = await repo.classify(text);
      setState(() => _classifyResult = result);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('AI 분류에 실패했습니다. 수동으로 카테고리를 선택해주세요.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isClassifying = false);
    }
  }

  @override
  void dispose() {
    _editController.dispose();
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('음성 입력'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),

            // 마이크 버튼
            GestureDetector(
              onTap: _isListening ? _stopListening : _startListening,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _isListening ? 120 : 100,
                height: _isListening ? 120 : 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isListening
                      ? Colors.red
                      : Theme.of(context).colorScheme.primary,
                  boxShadow: _isListening
                      ? [
                          BoxShadow(
                            color: Colors.red.withValues(alpha: 0.4),
                            blurRadius: 20,
                            spreadRadius: 5,
                          )
                        ]
                      : null,
                ),
                child: Icon(
                  _isListening ? Icons.stop : Icons.mic,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _isListening ? '듣고 있습니다...' : '탭하여 음성 입력',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),

            const SizedBox(height: 24),

            // 인식된 텍스트
            if (_recognizedText.isNotEmpty && _isListening)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _recognizedText,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),

            const Spacer(),

            // 텍스트 편집
            TextField(
              controller: _editController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: '인식된 텍스트 (편집 가능)',
                hintText: '음성 인식 결과가 여기에 표시됩니다',
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 12),

            // AI 분류 버튼
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _isClassifying ? null : _classify,
                icon: _isClassifying
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.auto_awesome),
                label: const Text('AI 분류'),
              ),
            ),

            // AI 분류 결과
            if (_classifyResult != null) ...[
              const SizedBox(height: 12),
              Card(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withValues(alpha: 0.3),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI 분류 결과',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('카테고리: '),
                          Text(
                            _classifyResult!.category,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('신뢰도: '),
                          Text(
                            '${(_classifyResult!.confidence * 100).toStringAsFixed(0)}%',
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('요약: '),
                          Expanded(child: Text(_classifyResult!.summary)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 16),

            // 적용 버튼
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _editController.text.trim().isEmpty
                    ? null
                    : () {
                        context.pop(<String, dynamic>{
                          'voiceText': _editController.text.trim(),
                          'content': _classifyResult?.summary ??
                              _editController.text.trim(),
                          'taskName': _classifyResult?.category,
                        });
                      },
                child: const Text('적용'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
