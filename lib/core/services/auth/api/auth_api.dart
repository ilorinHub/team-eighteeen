import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:egov/core/api/network/network.dart';
import 'package:egov/core/api/utils/utils.dart';
import 'package:egov/core/models/auth/requests/requests.dart';
import 'package:egov/core/models/auth/response/auth_response.dart';

abstract class AuthAPi {
  Future<Either<Failure, AuthResponse>> login(LoginRequest request);
  Future<Either<Failure, AuthResponse>> signup(SignupRequest request);
  Future<Either<Failure, String>> verifyPhoneNumber(
      VerifyPhoneNumberRequest request);
  Future<Either<Failure, String>> resetPassword(ResetPasswordRequest request);
}

class AuthAPiImpl extends AuthAPi {
  AuthAPiImpl(this.client);
  final ApiClient client;

  Future<Either<Failure, AuthResponse>> _authenticate(
      {required Map<String, dynamic> requestJson,
      required String endpoint}) async {
    try {
      final httpResponse = await client.post(endpoint,
          data: requestJson, queryParameters: {'source': 'manager'});
      final response = AuthResponse.fromJson(httpResponse.data['data']);

      return right(response);
    } catch (err, stack) {
      log(err.toString());
      log(stack.toString());
      return left(ApiFailure(message: err.toString()));
    }
  }

  Future<Either<Failure, String>> _verifyOrReset(
      {required Map<String, dynamic> requestJson,
      required String endpoint}) async {
    try {
      final response = await client.post(endpoint, data: requestJson);
      return right(response.data['message'] ?? "Successful");
    } catch (err) {
      log(err.toString());
      return left(ApiFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> login(LoginRequest request) {
    return _authenticate(
        requestJson: request.toJson(), endpoint: authEndpoints.login);
  }

  @override
  Future<Either<Failure, AuthResponse>> signup(SignupRequest request) {
    return _authenticate(
        requestJson: request.toJson(), endpoint: authEndpoints.signup);
  }

  @override
  Future<Either<Failure, String>> verifyPhoneNumber(
      VerifyPhoneNumberRequest request) {
    return _verifyOrReset(
        requestJson: request.toJson(), endpoint: authEndpoints.login);
  }

  @override
  Future<Either<Failure, String>> resetPassword(
      ResetPasswordRequest request) async {
    return _verifyOrReset(
        requestJson: request.toJson(), endpoint: authEndpoints.login);
  }
}
