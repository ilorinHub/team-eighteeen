import 'dart:convert';

import 'package:etransport/models/user/user_model.dart';
import 'package:flutter/foundation.dart';

class DriverModel {
  String firstname;
  String lastname;
  String email;
  UserTypes userType;
  String id;
  String number;
  DriverModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.userType,
    required this.id,
    required this.number,
  });
  DriverModel copyWith({
    String? firstname,
    String? lastname,
    String? email,
    UserTypes? userType,
    String? id,
    String? number,
  }) {
    return DriverModel(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      id: id ?? this.id,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'userType': describeEnum(userType),
      'id': id,
      'number': number,
    };
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      email: map['email'] ?? '',
      userType: UserTypes.values
          .firstWhere((element) => describeEnum(element) == map['userType']),
      id: map['id'] ?? '',
      number: map['number'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());
  factory DriverModel.fromJson(String source) =>
      DriverModel.fromMap(json.decode(source));
}
