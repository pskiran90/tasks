// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../constants/app_constants.dart';
import 'login/login_credentials_box.dart';
import 'login/login_credentials_model.dart';

class AppHiveConfig {
  AppHiveConfig._();

  static Future<void> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    Hive.registerAdapter(LoginCredentialsModelAdapter());

    await Future.wait([
      Hive.openBox(AppConstants.hiveBoxKey),
      Hive.openBox(LoginCredentialsBox.loginCredentialsBoxKey),
    ]);
  }
}
