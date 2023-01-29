import 'package:egov/core/models/auth/requests/requests.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  bool _show = false;
  bool get show => _show;
  bool _isLoading = false;
  bool get loading => _isLoading;

  void togglePasswordVisibility() {
    _show = !_show;
    notifyListeners();
  }

  void toggleAuthLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  String message = '';
  Future<bool> loginUser(LoginRequest loginRequest) async {
    toggleAuthLoading();
    await Future.delayed(const Duration(seconds: 2), () {});
    toggleAuthLoading();
    return true;
  }

  Future<bool> createAccount(SignupRequest signUpRequest) async {
    await Future.delayed(const Duration(seconds: 2), () {});
    return true;
  }

  Future<bool> requestResetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 2), () {});
    return true;
  }

  Future<bool> resetPassword(String otp, String password) async {
    await Future.delayed(const Duration(seconds: 2), () {});
    return true;
  }
}
