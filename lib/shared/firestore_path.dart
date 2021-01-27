class FirestorePath {
  static String drivers() => 'drivers';
  static String rideRequests() => 'riderequests';
  static String userData(String uid) => 'users/$uid';
  static String rideRequest(String rideRequestId) =>
      'riderequests/$rideRequestId';
}
