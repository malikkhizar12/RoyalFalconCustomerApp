import 'package:flutter/material.dart';

class AirportAnimationViewModel with ChangeNotifier {
  bool _myAnimation = false;

  bool get myAnimation => _myAnimation;

  void startAnimation() {
    _myAnimation = true;
    notifyListeners();
  }

  void stopAnimation() {
    _myAnimation = false;
    notifyListeners();
  }
}
