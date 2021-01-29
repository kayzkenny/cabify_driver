import 'package:flutter/foundation.dart';

class Vehicle {
  Vehicle({
    @required this.model,
    @required this.number,
    @required this.color,
  });
  final String model;
  final String number;
  final String color;

  /// Convert userData to map such as a firestore document
  Map<String, Map<String, String>> toMap() {
    // return {
    //   'vehicleColor': model,
    //   'vehicleModel': number,
    //   'vehicleNumber': color,
    // };
    return {
      'vehicleDetails': {
        'model': model,
        'number': number,
        'color': color,
      }
    };
  }
}
