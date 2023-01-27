import 'dart:developer';

import 'package:egov/core/models/geocoding/geo.dart';
import 'package:egov/core/services/map/geocoding.dart';
import 'package:egov/shared/utils/resources/strings.dart';

class GoogleGeolocatingApi {
  static Future<JourneyDetails> obtainPlaceDirectionDetails(
      GeoDetails initalPosition, GeoDetails finalPosition) async {
    String directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initalPosition.latitude},${initalPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$kGoogleApiKey";
    log(directionUrl);
    final response =
        await GoogleGeoLocatingBaseApi.getMapApiRequests(directionUrl);
    if (response == "error") {
      return JourneyDetails();
    }
    if (response['status'] == "NOT_FOUND") {
      return JourneyDetails();
    }
    JourneyDetails directionDetails = JourneyDetails();
    if (response['routes'] != null) {
      directionDetails.encodedPoints =
          response['routes'][0]['overview_polyline']['points'];
    } else {
      directionDetails.encodedPoints =
          response['routes'][0]['polyline']['points'];
    }
    directionDetails.distanceText =
        response['routes'][0]['legs'][0]['distance']['text'];
    directionDetails.distanceValue =
        response['routes'][0]['legs'][0]['distance']['value'];
    directionDetails.duration =
        response['routes'][0]['legs'][0]['duration']['value'];
    directionDetails.durationText =
        response['routes'][0]['legs'][0]['duration']['text'];

    return directionDetails;
  }

  static Future<List<GooglePlacePredictions>?> autoCompleteAddress(
      String placename) async {
    String autoCompleteUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placename&key=$kGoogleApiKey&sessiontoken=ddjdbjbdjb&components=country:ng";
    final result =
        await GoogleGeoLocatingBaseApi.getMapApiRequests(autoCompleteUrl);
    if (result == "error") {
      return null;
    }
    if (result['status'] == "OK") {
      final predictions = result['predictions'];
      final placeList = (predictions as List)
          .map((e) => GooglePlacePredictions.fromJson(e))
          .toList();
      return placeList;
    }
    return null;
  }

  static Future<GeoDetails?> coordinatesFromAddress(String address) async {
    String addressUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?address=$address,+CA&key=$kGoogleApiKey";
    final result = await GoogleGeoLocatingBaseApi.getMapApiRequests(addressUrl);
    if (result['status'] == "OK") {
      final location = result['results'][0]['geometry'];
      final placeList = GeoDetails.fromJson(location);
      return placeList;
    }
    if (result == "error") {
      return null;
    }
    return null;
  }
}
