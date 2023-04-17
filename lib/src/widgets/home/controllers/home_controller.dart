import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  int indexSelected = 0;
  void onIndexSelected(int index) {
    indexSelected = index;
    print("change");
    notifyListeners();
  }
}
