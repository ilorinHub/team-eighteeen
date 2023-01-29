import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel(
      {required String firstname,
      required String lastname,
      required String email,
      required int number,
      required UserTypes userType,
      required String id}) = _UserModel;
  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}

enum UserTypes { user, admin, driver }
