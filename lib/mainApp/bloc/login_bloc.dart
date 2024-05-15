import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../services/localDb/login/login_credentials_box.dart';
import '../../services/localDb/login/login_credentials_model.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInUsingCredentials>((event, emit) async {
      emit(SignInProgress());
      if (kDebugMode) debugPrint("SignInBloc");
      var client = http.Client();
      try {
        var response = await client.post(
          Uri.parse('https://swan.alisonsnewdemo.online/api/login'),
          body: {
            'email_phone': event.email,
            'password': event.password,
          },
        );
        LoginCredentialsBox.loginCredentialsBox.saveLoginCredentials = LoginCredentialsModel(
          password: event.password,
          email: event.email,
          savedAt: DateTime.now(),
        );
        emit(SignInSuccess());
        debugPrint(response.body.toString());
      } catch (e) {
        emit(SignInFailure(e));
      }
    });
  }
}

///state - inst
abstract class SignInState {}

///event - inst
abstract class SignInEvent {}

///events - impl
class SignIn extends SignInEvent {}

class SignInUsingCredentials extends SignInEvent {
  final String email;
  final String password;
  SignInUsingCredentials({
    required this.email,
    required this.password,
  });
}

///states - impl
class SignInInitial extends SignInState {}

class SignInProgress extends SignInState {}

class SignInSuccess extends SignInState {
  SignInSuccess();
}

class SignInFailure extends SignInState {
  SignInFailure(this.error);

  final dynamic error;
}
