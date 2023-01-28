import 'package:flutter/material.dart';

class RiderDashboardViewmodel extends ChangeNotifier {
  bool _isLoading = false;
  bool get loading => _isLoading;

  void toggleAuthLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  List<NewOrderDetails> newOrderDetailsList = [
    NewOrderDetails(
        orderName: 'Wasiu Olamilekan',
        orderDestination: 'Unity Road, Ilorin',
        pickUpLocation: 'Tipper-garrage, Tanke, Ilorin',
        estimatedDuration: '20 mins')
  ];

  RideType _userRideType = RideType.single;
  RideType get userRideType => _userRideType;
  set userRideType(RideType riderType) {
    _userRideType = riderType;
    notifyListeners();
  }

  bool _cardAdded = false;
  bool get cardAdded => _cardAdded;
  set cardAdded(bool val) {
    _cardAdded = val;
    notifyListeners();
  }

  bool _bankAdded = false;
  bool get bankAdded => _bankAdded;
  set bankAdded(bool val) {
    _bankAdded = val;
    notifyListeners();
  }
}

enum RideType { single, shared }

class NewOrderDetails {
  final String orderName;
  final String orderDestination;
  final String pickUpLocation;
  final String estimatedDuration;

  NewOrderDetails(
      {required this.orderName,
      required this.orderDestination,
      required this.pickUpLocation,
      required this.estimatedDuration});
}
