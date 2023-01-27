import 'package:egov/core/models/auth/user.dart';
import 'package:egov/core/services/storage/storage_service.dart';
import 'package:flutter/material.dart';

class StateProvider extends ChangeNotifier {
  StateProvider({
    required this.storageService,
  });

  final StorageService storageService;

  StateStatus _stateStatus = StateStatus.unauthenticated;
  StateStatus get stateStatus => _stateStatus;
  set stateStatus(StateStatus value) {
    _stateStatus = value;
    notifyListeners();
  }

  bool _firstTimeUser = true;
  bool get firstTimeUser => _firstTimeUser;
  set firstTimeUser(bool value) {
    _firstTimeUser = value;
    notifyListeners();
  }

  User? _currentUser;
  User? get currentUser => _currentUser;
  set currentUser(User? value) {
    _currentUser = value;
    notifyListeners();
  }

  AppToken _currentToken = AppToken(token: null, user: null);
  AppToken get currentToken => _currentToken;
  set currentToken(AppToken value) {
    _currentToken = value;
    notifyListeners();
  }

  Future<void> init() async {
    currentToken = storageService.getToken();
    currentUser = currentToken.user;
    if (currentToken.user != null) {
      firstTimeUser = false;
    }
    if (currentToken.token != null && currentToken.user != null) {
      stateStatus = StateStatus.authenticated;
    } else {
      stateStatus = StateStatus.unauthenticated;
    }
  }

  Future<void> refresh() async {
    init();
  }

  Future<void> logout() async {
    await storageService.updateToken(currentToken.copyWithToken(null));
    await refresh();
  }
}

enum StateStatus { unauthenticated, authenticated }
