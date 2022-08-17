import 'package:flutter/material.dart';

class ArticleCardHeaderProvider with ChangeNotifier {
  int? maxTitleLines = 2;
  bool isHomeScreen = true;

  void toogleHomeScreen() {
    isHomeScreen = !isHomeScreen;
    notifyListeners();
  }

  void changeMaxTitleLines(bool isExpansionIconChanged) {
    int? maxLines = isExpansionIconChanged ? null : 2;
    maxTitleLines = maxLines;
    notifyListeners();
  }
}
