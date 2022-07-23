import 'package:flutter/cupertino.dart';

class ToogleSearch with ChangeNotifier {
  bool isSearchBarActive = false;
  void toogleSeachBar() {
    isSearchBarActive = !isSearchBarActive;
    notifyListeners();
  }
}
