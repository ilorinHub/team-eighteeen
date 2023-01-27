import 'package:egov/core/api/core.dart';

class SignupRequest extends ApiRequest {
  SignupRequest({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
  });

  final String? email;
  final String password;
  final String fullName;

  final String phoneNumber;

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'password': password,
    };
    if (email != null) {
      json['email'] = email;
    }

    return json;
  }
}
