import 'package:cabify_driver/services/google_maps_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final googleMapsProvider = Provider(
  (ref) => GoogleMapsService(),
);
