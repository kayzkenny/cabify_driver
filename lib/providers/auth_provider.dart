import 'package:cabify_driver/models/user_model.dart';
import 'package:cabify_driver/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider(
  (ref) => AuthService(),
);

final authStateProvider = StreamProvider<User>(
  (ref) => AuthService().onAuthStateChanged,
);
