import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechProvider with ChangeNotifier {
  final _speech = stt.SpeechToText();
  bool isListening = false;
  late String text = "Listening...";
  bool isBottomSheetOpened = false;

  void switchBottomSheet() {
    isBottomSheetOpened = !isBottomSheetOpened;
    notifyListeners();
  }

  Future<String?> speechToText() async {
    String? recognisedWords;
    text = "Listening...";
    notifyListeners();
    await _listen();
    recognisedWords = _speech.lastRecognizedWords;
    return Future.value(recognisedWords);
  }

  Future<void> _listen() async {
    if (!isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus : $val'),
        onError: (val) => print('onError : $val'),
      );
      if (available) {
        isListening = true;
        notifyListeners();
        _speech.listen(onResult: (val) {
          text = val.recognizedWords;
          notifyListeners();
        });
      }
    } else {
      isListening = false;
      notifyListeners();
      _speech.stop();
    }
  }
}
