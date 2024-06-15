import 'package:flutter/foundation.dart';

class RidesAnimationViewModel with ChangeNotifier {
  bool _myAnimation = false;

  bool get myAnimation => _myAnimation;

  void startAnimation() {
    _myAnimation = true;
    notifyListeners();
  }
}
