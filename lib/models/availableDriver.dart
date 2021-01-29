import 'package:flutter/foundation.dart';

class AvailableDriver {
  final String status;
  final Map position;
  final String id;

  AvailableDriver({
    this.id,
    @required this.status,
    @required this.position,
  });

  /// Convert userData to map such as a firestore document
  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'position': position,
    };
  }

  factory AvailableDriver.fromMap(
    Map<String, dynamic> data,
    String documentId,
  ) {
    if (data == null) {
      return null;
    }

    final String status = data['status'];
    final Map position = data['position']['geopoint'];

    return AvailableDriver(
      id: documentId,
      status: status,
      position: position,
    );
  }
}
