import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cabify_driver/models/address_model.dart';
import 'package:cabify_driver/models/user_data_model.dart';

final appStateProvider = Provider(
  (ref) => AppState(),
);

class AppState extends ChangeNotifier {
  Address pickupAddress;
  UserData currentUserData;
  Address destinationAddress;

  void updatePickupAddress(Address pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }

  void updateDestinationAddress(Address destination) {
    destinationAddress = destination;
    notifyListeners();
  }

  void updateCurrentUserData(UserData userData) {
    currentUserData = userData;
    notifyListeners();
  }
}
