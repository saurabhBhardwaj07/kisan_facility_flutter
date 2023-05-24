class PlaceMarkLocation {
  double latitude;
  double longitude;
  String locality;
  String administrativeArea;
  String postalCode;

  PlaceMarkLocation(
      {required this.latitude,
      required this.longitude,
      required this.locality,
      required this.administrativeArea,
      required this.postalCode});

  String selectedCity() {
    return '$locality, $administrativeArea';
  }
}
