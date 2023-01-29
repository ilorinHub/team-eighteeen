// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
      number: json['number'] as int,
      userType: $enumDecode(_$UserTypesEnumMap, json['userType']),
      id: json['id'] as String,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'number': instance.number,
      'userType': _$UserTypesEnumMap[instance.userType]!,
      'id': instance.id,
    };

const _$UserTypesEnumMap = {
  UserTypes.user: 'user',
  UserTypes.admin: 'admin',
  UserTypes.driver: 'driver',
};
