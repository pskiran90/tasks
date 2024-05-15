// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../../constants/app_constants.dart';
import 'login_credentials_model.dart';

class LoginCredentialsBox with AppConstants {
  static const String hiveBoxKey = AppConstants.hiveBoxKey;
  static const String loginCredentialsBoxKey = AppConstants.credentialsBoxKey;
  late Box _loginCredentialsBox;
  LoginCredentialsBox._() {
    _loginCredentialsBox = Hive.box(hiveBoxKey);
  }
  static final LoginCredentialsBox _singleton = LoginCredentialsBox._();
  factory LoginCredentialsBox() => _singleton;

  ///for public use
  static LoginCredentialsBox get loginCredentialsBox => _singleton;

  ///save data to db
  set saveLoginCredentials(LoginCredentialsModel value) {
    _loginCredentialsBox.put(loginCredentialsBoxKey, value).catchError(
      (error, stack) {
        if (kDebugMode) debugPrint("Hive credentials saving error >>, $error  $stack");
      },
    );
  }

  ///fetch data from db
  LoginCredentialsModel? get fetchLoginCredentials {
    late LoginCredentialsModel? value;
    try {
      value = _loginCredentialsBox.get(loginCredentialsBoxKey);
      return value;
    } catch (e) {
      if (kDebugMode) debugPrint("Hive credentials fetching error >> >>, $e");
      return value;
    }
  }
}
