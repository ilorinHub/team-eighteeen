class GeoDetails {
  double? latitude;
  double? longitude;

  GeoDetails({this.latitude, this.longitude});

  GeoDetails.fromJson(Map<String, dynamic> json) {
    latitude = json['location']['lat'];
    longitude = json['location']['lng'];
  }

  @override
  toString() {
    return 'latitude: $latitude, longitude: $longitude';
  }
}
