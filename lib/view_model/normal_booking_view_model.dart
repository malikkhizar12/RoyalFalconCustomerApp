import 'package:flutter/foundation.dart';
import '../model/normal_booking_car_model.dart';

class CarViewModel with ChangeNotifier {
  List<CarModel> _cars = [];

  List<CarModel> get cars => _cars;

  CarViewModel() {
    _cars = CarModel.normal_booking_cars();
  }

  void addCar(CarModel car) {
    _cars.add(car);
    notifyListeners();
  }

  void removeCar(CarModel car) {
    _cars.remove(car);
    notifyListeners();
  }
}
