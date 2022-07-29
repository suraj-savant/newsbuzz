import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToogleSearch with ChangeNotifier {
  bool isSearchBarActive = false;
  void toogleSeachBar() {
    isSearchBarActive = !isSearchBarActive;
    notifyListeners();
  }
}
