import 'package:flutter/material.dart';

class ToogleSearch with ChangeNotifier {
  bool isSearchBarActive = false;
  void toogleSeachBar() {
    isSearchBarActive = !isSearchBarActive;
    notifyListeners();
  }
}
