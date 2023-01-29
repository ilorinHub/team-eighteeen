import 'package:egov/core/api/core.dart';

class ResetPasswordRequest extends ApiRequest {
  final String phoneNumber;
  final String otpCode;
  final String password;
  final String confirmPassword;

  ResetPasswordRequest(
      {required this.phoneNumber,
      required this.otpCode,
      required this.password,
      required this.confirmPassword});

  @override
  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'password': password,
      'confirmPassword': confirmPassword,
      'code': otpCode
    };
  }
}
