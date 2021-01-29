import 'dart:async';

import 'package:cabify_driver/models/availableDriver.dart';
import 'package:cabify_driver/providers/database_provider.dart';
import 'package:cabify_driver/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cabify_driver/providers/geolocation_provider.dart';
import 'package:cabify_driver/providers/connectivity_provider.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Position currentPosition;
  bool _isAvailable = false;
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();

  Future<void> setPosition() async {
    final position =
        await context.read(geolocationProvider).getCurrentPosition();
    setState(() => currentPosition = position);

    final pos = LatLng(position.latitude, position.longitude);
    CameraPosition cp = CameraPosition(target: pos, zoom: 14);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cp));

    bool connected =
        await context.read(connectivityProvider).connectivityAvailable();

    if (connected) {
      String address = await context
          .read(geolocationProvider)
          .findCoordinateAddress(position, context);

      print('------------ printing address ---------------');
      print(address);
    }
  }

  Future<void> goOnline() async {
    // Init firestore and geoFlutterFire
    final geo = Geoflutterfire();

    // Create a geoFirePoint
    GeoFirePoint position = geo.point(
      latitude: currentPosition.latitude,
      longitude: currentPosition.longitude,
    );

    final availableDriver = AvailableDriver(
      status: "waiting",
      position: position.data,
    );

    await context
        .read(databaseProvider)
        .setDriverAvailable(availableDriver: availableDriver);
  }

  Future<void> goOffline() async {
    await context.read(databaseProvider).removeDriverAvailable();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            setPosition();
          },
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          top: 40.0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: 64.0,
            // width: 360.0,
            decoration: BoxDecoration(
              color: _isAvailable ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(40.0),
              boxShadow: [
                const BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _isAvailable ? ' Online' : 'Offline',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                Switch(
                  value: _isAvailable,
                  onChanged: (newValue) {
                    setState(() {
                      _isAvailable = newValue;
                    });
                    newValue ? goOnline() : goOffline();
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
