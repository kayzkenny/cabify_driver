import 'package:cabify_driver/models/user_data_model.dart';
import 'package:cabify_driver/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cabify_driver/services/firestore_database_service.dart';

final databaseProvider = Provider<FirestoreDatabase>(
  (ref) =>
      FirestoreDatabase(uid: ref.watch(authServiceProvider).currentUser().uid),
);

final userDataProvider = StreamProvider.autoDispose<UserData>(
  (ref) => ref.read(databaseProvider).userDataStream,
);
