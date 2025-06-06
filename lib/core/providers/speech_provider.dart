import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list_technical_test/core/services/speech_service.dart';

part 'speech_provider.g.dart';

@riverpod
class SpeechNotifier extends _$SpeechNotifier {
  @override
  SpeechService build() {
    return SpeechService();
  }

  Future<bool> startListening({
    required Function(String text) onResult,
    required Function() onListeningComplete,
  }) async {
    return await state.startListening(
      onResult: onResult,
      onListeningComplete: onListeningComplete,
    );
  }

  Future<void> stopListening() async {
    await state.stopListening();
  }

  bool get isListening => state.isListening;
}
