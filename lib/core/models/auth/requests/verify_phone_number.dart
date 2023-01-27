import 'package:egov/core/api/core.dart';

class VerifyPhoneNumberRequest extends ApiRequest {
  final String email;
  final String type;
  final String otp;

  VerifyPhoneNumberRequest(
      {required this.email, required this.type, required this.otp});

  @override
  Map<String, dynamic> toJson() {
    return {'email': email, "type": type, "otp": otp};
  }
}
