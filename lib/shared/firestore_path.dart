class FirestorePath {
  static String drivers() => 'drivers';
  static String rideRequests() => 'riderequests';
  static String userData(String uid) => 'drivers/$uid';
  static String availableDrivers() => 'availableDrivers';
  static String userVehicle(String uid) => 'drivers/$uid';
  static String availableDriver(String uid) => 'availableDrivers/$uid';
  static String rideRequest(String rideRequestId) =>
      'riderequests/$rideRequestId';
}
