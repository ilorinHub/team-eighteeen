import 'package:flutter/material.dart';

class DashboardViewmodel extends ChangeNotifier {
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
