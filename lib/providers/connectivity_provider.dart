import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cabify_driver/services/connectivity_service.dart';

final connectivityProvider = Provider((ref) => ConnectivityService());
