import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speechToText = SpeechToText();
  bool _isInitialized = false;
  bool _isListening = false;

  Future<bool> initialize() async {
    if (_isInitialized) return true;

    _isInitialized = await _speechToText.initialize(
      onError: (error) {},
      onStatus: (status) {
        if (status == 'listening') {
          _isListening = true;
        } else if (status == 'notListening' || status == 'done') {
          _isListening = false;
        }
      },
    );

    return _isInitialized;
  }

  Future<bool> startListening({
    required Function(String text) onResult,
    required Function() onListeningComplete,
  }) async {
    if (!_isInitialized) {
      _isInitialized = await initialize();
      if (!_isInitialized) {
        return false;
      }
    }

    if (_speechToText.isListening) {
      await _speechToText.stop();
      _isListening = false;
      return false;
    }

    try {
      await _speechToText.listen(
        onResult: (result) {
          if (result.finalResult) {
            onResult(result.recognizedWords);
            onListeningComplete();
          }
        },
        localeId: 'es_ES',
        listenMode: ListenMode.confirmation,
        partialResults: true,
        onDevice: true,
      );
      _isListening = true;
      return true;
    } catch (e) {
      _isListening = false;
      return false;
    }
  }

  Future<void> stopListening() async {
    if (_speechToText.isListening) {
      await _speechToText.stop();
      _isListening = false;
    }
  }

  bool get isListening => _isListening;
}
