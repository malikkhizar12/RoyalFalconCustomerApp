import 'package:flutter/foundation.dart';

class AirportAnimationViewModel with ChangeNotifier {
  bool _myAnimation = false;

  bool get myAnimation => _myAnimation;

  void startAnimation() {
    _myAnimation = true;
    notifyListeners();
  }

  @override
  void dispose() {
    // Any cleanup can be done here
    super.dispose();
  }
}
