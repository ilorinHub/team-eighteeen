import 'package:egov/core/api/core.dart';
import 'package:egov/core/models/auth/user.dart';

class AuthResponse extends ApiResponse {
  AuthResponse({
    required this.token,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.photoUrl,
    required this.phoneNumber,
    required this.id,
    required this.role,
  });
  final String email;
  final String token;
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? photoUrl;
  final UserType role;

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['accessToken'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      photoUrl: json['photoUrl'] ?? '',
      id: json['id'],
      role: UserTypeUtil.fromString(json['role']),
      phoneNumber: json["phoneNumber"],
    );
  }
}
