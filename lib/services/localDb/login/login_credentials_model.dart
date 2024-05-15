import 'package:hive/hive.dart';

part 'login_credentials_model.g.dart';

@HiveType(typeId: 0)
class LoginCredentialsModel {
  LoginCredentialsModel({
    this.email,
    this.password,
    this.savedAt,
    this.displayName,
  });

  @HiveField(0)
  String? email;

  @HiveField(1)
  String? password;

  @HiveField(2)
  DateTime? savedAt;

  @HiveField(3)
  String? displayName;

  factory LoginCredentialsModel.fromMap(Map<String, dynamic> data) {
    return LoginCredentialsModel(
      email: data['email'],
      password: data['password'],
      savedAt: data['savedAt'],
      displayName: data['displayName'],
    );
  }
}
