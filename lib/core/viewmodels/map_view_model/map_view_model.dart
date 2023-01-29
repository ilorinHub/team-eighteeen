import 'dart:async';

import 'package:egov/core/models/geocoding/geo.dart';
import 'package:egov/core/services/map/geolocating_methods.dart';
import 'package:egov/shared/utils/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewModel extends ChangeNotifier {
  double initZoom = 16;
  LatLng initCoordinates = const LatLng(6.5244, 3.3792);

  final Completer<GoogleMapController> controller = Completer();

  GoogleMapController? _newGoogleMapController;
  GoogleMapController? get newGoogleMapController => _newGoogleMapController;
  set newGoogleMapController(GoogleMapController? controller) {
    _newGoogleMapController = controller;
    notifyListeners();
  }

  List<LatLng> polyLineCoordinates = [];
  List<LatLng> get polyCoordinates => polyLineCoordinates;
  final Set<Polyline> _polylineSet = {};
  Set<Polyline> get polylineSet => _polylineSet;
  final Set<Marker> _markersSet = {};
  Set<Marker> get markers => _markersSet;

//this is the prediction list when user starts typing
  List<GooglePlacePredictions> _placePredictionList = [];
  List<GooglePlacePredictions> get placePredictionList => _placePredictionList;
  set placePredictionList(List<GooglePlacePredictions> val) {
    _placePredictionList = val;
    notifyListeners();
  }

  double _pinMargin = 0;
  double get pinMargin => _pinMargin;
  set pinMargin(double val) {
    _pinMargin = val;
    notifyListeners();
  }

  String _userAddress = '';
  String get userAddress => _userAddress;
  set userAddress(String val) {
    _userAddress = val;
    notifyListeners();
  }

  String _riderAddress = '';
  String get riderAddress => _riderAddress;
  set riderAddress(String val) {
    _riderAddress = val;
    notifyListeners();
  }

  String _deliveryAddress = '';
  String get deliveryAddress => _deliveryAddress;
  set deliveryAddress(String val) {
    _deliveryAddress = val;
    notifyListeners();
  }

  void updatePinMargin() {
    if (pinMargin == 0) {
      pinMargin = 20;
    } else {
      pinMargin = 0;
    }
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String _location = 'location';
  String get location => _location;
  set location(String val) {
    _location = val;
    notifyListeners();
  }

  String _error = 'Something went wrong\nTry again later';
  String get error => _error;
  set error(String val) {
    _error = val;
    notifyListeners();
  }

  bool _hasError = false;
  bool get hasError => _hasError;
  set hasError(bool error) {
    _hasError = error;
    notifyListeners();
  }

  GeoDetails _pickUpGeoDetails = GeoDetails();
  GeoDetails get pickUpGeoDetails => _pickUpGeoDetails;
  set pickUpGeoDetails(GeoDetails val) {
    _pickUpGeoDetails = val;
    notifyListeners();
  }

  GeoDetails _deliveryGeoDetails = GeoDetails();
  GeoDetails get deliveryGeoDetails => _deliveryGeoDetails;
  set deliveryGeoDetails(GeoDetails val) {
    _deliveryGeoDetails = val;
    notifyListeners();
  }

//when map moves
  Future<String?> getNewAddressWhenMapMoves() async {
    List<Placemark> placemarks = [];
    try {
      placemarks =
          await placemarkFromCoordinates(value.latitude, value.longitude);
    } catch (e) {
      return null;
    }
    userAddress = placemarks.first.subAdministrativeArea!.split(' ').first;
    location =
        '${placemarks.last.administrativeArea}, ${placemarks.first.street}, ${placemarks.last.subAdministrativeArea}';
    notifyListeners();
    return location;
  }

  Future<GeoDetails?> getCoordinatesFromAddress(String address) async {
    final result = await GoogleGeolocatingApi.coordinatesFromAddress(address);
    if (result == null) {
      return null;
    }
    return result;
  }

  void findPlaceFromAutoComplete(String placeName) async {
    error = '';
    if (placeName.isNotEmpty) {
      currentIndex = 1;
      loading = true;
      final result = await GoogleGeolocatingApi.autoCompleteAddress(placeName);
      if (result == null) {
        loading = false;
        return;
      }
      placePredictionList = result;
      loading = false;
    } else {
      currentIndex = 0;
    }
  }

  determineUserCurrentPosition() async {
    final Position position;
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    position = await Geolocator.getCurrentPosition();
    value = LatLng(position.latitude, position.longitude);
    return await getNewAddressWhenMapMoves();
  }

  JourneyDetails _tripDirectionDetails = JourneyDetails();
  JourneyDetails get tripDirectionDetails => _tripDirectionDetails;
  set tripDirectionDetails(JourneyDetails directionDetails) {
    _tripDirectionDetails = directionDetails;
    notifyListeners();
  }

  Future<void> getPolyLinesAndDistance(bool updateMap,
      {GeoDetails? origin, GeoDetails? destination}) async {
    // setCustomMarker();
    final result = await GoogleGeolocatingApi.obtainPlaceDirectionDetails(
        origin ?? pickUpGeoDetails, destination ?? deliveryGeoDetails);
    if (result.distanceText != null) {
      loading = true;
      hasError = false;
      tripDirectionDetails = result;
      PolylinePoints polyLinePoints = PolylinePoints();
      List<PointLatLng> decodedPolyLinePointsResult =
          polyLinePoints.decodePolyline(tripDirectionDetails.encodedPoints!);
      polyLineCoordinates.clear();
      if (decodedPolyLinePointsResult.isNotEmpty) {
        for (var pointLatLng in decodedPolyLinePointsResult) {
          polyLineCoordinates
              .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
        }
      }
      int i = 0;
      _polylineSet.clear();
      for (i = 0; i < polyLineCoordinates.length; i++) {
        Polyline polyLine = Polyline(
          color: primaryColor,
          polylineId: const PolylineId("PolylineID"),
          jointType: JointType.mitered,
          points: polyLineCoordinates,
          width: 4,
          geodesic: false,
          zIndex: 0,
        );
        _polylineSet.add(polyLine);
      }
      if (updateMap) {
        LatLngBounds latLngBounds;
        final LatLng pickup = LatLng(
            origin?.latitude ?? pickUpGeoDetails.latitude!,
            origin?.longitude ?? pickUpGeoDetails.longitude!);
        final LatLng delivery = LatLng(
            destination?.latitude ?? deliveryGeoDetails.latitude!,
            destination?.longitude ?? deliveryGeoDetails.longitude!);

        if (pickup.latitude > delivery.latitude &&
            pickup.longitude > delivery.longitude) {
          latLngBounds = LatLngBounds(southwest: delivery, northeast: pickup);
        } else if (pickup.longitude > delivery.longitude) {
          latLngBounds = LatLngBounds(
              southwest: LatLng(pickup.latitude, delivery.longitude),
              northeast: LatLng(delivery.latitude, pickup.longitude));
        } else if (pickup.latitude > delivery.latitude) {
          latLngBounds = LatLngBounds(
              southwest: LatLng(delivery.latitude, pickup.longitude),
              northeast: LatLng(pickup.latitude, delivery.longitude));
        } else {
          latLngBounds = LatLngBounds(northeast: delivery, southwest: pickup);
        }

        newGoogleMapController
            ?.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 50));
        if (origin == null && destination == null) {
          await loadMarkers();
        } else {
          await loadMarkers(
            origin: origin,
            destination: destination,
          );
        }
      }
      loading = false;
    } else {
      hasError = true;
      error = 'Could not resolve coordinates\nPlease, try a different location';
    }

    notifyListeners();
  }

  // BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  // BitmapDescriptor senderIcon = BitmapDescriptor.defaultMarker;
  // void setCustomMarker() {
  //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, deliveryMarker)
  //       .then((value) {
  //     destinationIcon = value;
  //   });
  //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, senderMarker)
  //       .then((value) {
  //     senderIcon = value;
  //   });
  // }

  loadMarkers({GeoDetails? origin, GeoDetails? destination}) async {
    _markersSet.clear();
    final pickUpCordinate = origin ?? pickUpGeoDetails;
    final deliveryCordinates = destination ?? deliveryGeoDetails;
    final List<LatLng> latLen = [
      LatLng(pickUpCordinate.latitude!, pickUpCordinate.longitude!),
      LatLng(deliveryCordinates.latitude!, deliveryCordinates.longitude!),
    ];

    Marker pickUpLocationMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(10),
      infoWindow: const InfoWindow(title: '', snippet: "Pickup location"),
      position: latLen[0],
      markerId: const MarkerId("pickUpId"),
    );
    Marker dropOffLocationMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(10),
        infoWindow: const InfoWindow(title: '', snippet: "Destination"),
        position: latLen[1],
        markerId: const MarkerId("dropOffId"));

    for (int i = 0; i < 2; i++) {
      _markersSet.add(pickUpLocationMarker);
      _markersSet.add(dropOffLocationMarker);
    }

    notifyListeners();
  }

  //polylines
  Set<Polyline> _polyline = {};
  Set<Polyline> get polyline => _polyline;
  set polyline(Set<Polyline> val) {
    _polyline = val;
    notifyListeners();
  }

  LatLng _value = const LatLng(6.5244, 3.3792);
  LatLng get value => _value;
  set value(LatLng val) {
    _value = val;
    notifyListeners();
  }

  cancelOrderOnMap() {
    _polylineSet.clear();
    polyCoordinates.clear();
    _markersSet.clear();
  }

  void disposeValues() {
    _currentIndex = 0;
    _loading = false;
    error = 'Something went wrong\nTry again later';
  }
}
