import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cabify_driver/shared/api_keys.dart';
import 'package:cabify_driver/shared/endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cabify_driver/models/address_model.dart';
import 'package:cabify_driver/services/request_helper.dart';
import 'package:cabify_driver/providers/appstate_provider.dart';

class GeolocationService {
  Future<Position> getCurrentPosition({
    LocationAccuracy desiredAccuracy = LocationAccuracy.bestForNavigation,
  }) async =>
      await Geolocator.getCurrentPosition(desiredAccuracy: desiredAccuracy);

  Future<Position> get getLastKnownPosition async =>
      await Geolocator.getLastKnownPosition();

  Future<String> findCoordinateAddress(
    Position position,
    BuildContext context,
  ) async {
    String placeAddress = "";

    String url =
        '$geocodeEndpoint?latlng=${position.latitude},${position.longitude}&key=${APIKeys.googleMaps}';

    var response = await RequestHelper.getRequest(url);

    if (response != 'failed') {
      placeAddress = response['results'][0]['formatted_address'];

      Address pickupAddress = Address(
        latitude: position.latitude,
        longitude: position.longitude,
        placeName: placeAddress,
      );

      context.read(appStateProvider).updatePickupAddress(pickupAddress);
    }

    return placeAddress;
  }
}
