import 'package:geolocator/geolocator.dart';

class LocationUtils {
  static Future<LocationPermission> _checkPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission;
  }

  static Future<bool> requestPermission() async {
    final permission = await _checkPermission();
    if (permission == LocationPermission.denied) {
      var requestEnableLocation = await Geolocator.requestPermission();
      if (requestEnableLocation != LocationPermission.denied) {
        return true;
      }
      return false;
    }
    return true;
  }

  static Future<Coordinates?> getLatitudeAndLongitude() async {
    final isSuccessfull = await requestPermission();
    if (!isSuccessfull) {
      return null;
    }
    final position = await Geolocator.getCurrentPosition();
    return Coordinates(lat: position.latitude, long: position.longitude);
  }
}

class Coordinates {
  final double lat;
  final double long;
  Coordinates({required this.lat, required this.long});

  Map<String, dynamic> toJson() {
    return {"latitude": lat, "longitude": long};
  }
}
