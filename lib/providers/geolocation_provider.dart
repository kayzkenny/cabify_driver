import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cabify_driver/services/geolocation_service.dart';

final geolocationProvider = Provider((ref) => GeolocationService());
