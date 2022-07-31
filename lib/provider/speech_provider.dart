import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechProvider with ChangeNotifier {
  final _speech = stt.SpeechToText();
  bool isListening = false;
  late String text = "Listening...";

  void speechToText() async {
    if (!isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');
          if (text != "Listening..." && val == "done") {
            print("Searching results for $text");
            isListening = false;
            notifyListeners();
            _speech.stop();
          }
        },
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        isListening = true;
        notifyListeners();
        _speech.listen(
          onResult: (val) {
            text = val.recognizedWords;
            print(text);
            notifyListeners();
          },
        );
      }
    } else {
      isListening = false;
      notifyListeners();
      _speech.stop();
    }
  }
}
