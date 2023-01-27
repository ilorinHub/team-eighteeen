import 'package:dartz/dartz.dart';
import 'package:egov/core/api/utils/utils.dart';
import 'package:egov/core/models/auth/requests/requests.dart';
import 'package:egov/core/models/auth/response/auth_response.dart';
import 'package:egov/core/models/auth/user.dart';
import 'package:egov/core/services/auth/api/auth_api.dart';
import 'package:egov/core/services/storage/storage_service.dart';

typedef _SignupOrLogin = Future<Either<Failure, AuthResponse>> Function();

abstract class AuthService {
  Future<Either<Failure, AuthResponse>> login(LoginRequest request);
  Future<Either<Failure, AuthResponse>> signup(SignupRequest request);
  Future<Either<Failure, String>> verifyPhoneNumber(
      VerifyPhoneNumberRequest request);

  Future<Either<Failure, String>> resetPassword(ResetPasswordRequest request);
}

class AuthServiceImpl extends AuthService {
  AuthServiceImpl({
    required this.authApi,
    required this.storageService,
  });

  final AuthAPi authApi;
  final StorageService storageService;

  Future<Either<Failure, AuthResponse>> _authenticate(
      _SignupOrLogin signupOrLogin) async {
    final response = await signupOrLogin();
    return response.fold((failure) {
      return left(failure);
    }, (response) async {
      final success = await storageService.saveToken(
          response.token,
          User(
            email: response.email,
            id: response.id,
            firstName: response.firstName,
            lastName: response.lastName,
            phoneNumber: response.phoneNumber,
            photoUrl: response.photoUrl,
            userType: response.role,
          ));
      if (success) {
        return right(response);
      }
      return left(GenericFailure(message: 'failed to save token'));
    });
  }

  @override
  Future<Either<Failure, AuthResponse>> login(LoginRequest request) {
    return _authenticate(() => authApi.login(request));
  }

  @override
  Future<Either<Failure, AuthResponse>> signup(SignupRequest request) {
    return _authenticate(() => authApi.signup(request));
  }

  @override
  Future<Either<Failure, String>> verifyPhoneNumber(
      VerifyPhoneNumberRequest request) async {
    return authApi.verifyPhoneNumber(request);
  }

  @override
  Future<Either<Failure, String>> resetPassword(ResetPasswordRequest request) {
    return authApi.resetPassword(request);
  }
}
