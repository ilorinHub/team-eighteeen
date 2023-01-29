import 'package:egov/core/api/core.dart';

class LoginRequest extends ApiRequest {
  LoginRequest({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
