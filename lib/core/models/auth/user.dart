enum UserType { user, rider, organization, manager }

class UserTypeUtil {
  static UserType fromString(String value) {
    return UserType.values.firstWhere(
        (element) => element.name.toLowerCase() == value.toLowerCase());
  }
}

class User {
  User({
    required this.userType,
    required this.email,
    required this.id,
    required this.firstName,
    required this.photoUrl,
    required this.lastName,
    required this.phoneNumber,
  });

  final UserType userType;
  final String email;
  final String? photoUrl;
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  Map<String, dynamic> toJson() {
    return {
      'userType': userType.name,
      'id': id,
      'email': email,
      'firstName': firstName,
      'photoUrl': photoUrl,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    };
  }

  User copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? photoUrl,
    String? phoneNumber,
  }) {
    return User(
      userType: userType,
      email: email ?? this.email,
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userType: UserTypeUtil.fromString(json['userType']),
        email: json['email'],
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phoneNumber: json['phoneNumber'],
        photoUrl: json['photoUrl']);
  }
}
