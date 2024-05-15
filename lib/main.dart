import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/mainApp/bloc/fetch_bloc.dart';
import 'package:tasks/mainApp/screens/auth/login_page.dart';

import 'mainApp/bloc/login_bloc.dart';
import 'services/localDb/hive_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppHiveConfig.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignInBloc()),
        BlocProvider(create: (context) => FetchDataBloc()),
      ],
      child: const MaterialApp(
        home: Login(),
      ),
    );
  }
}
