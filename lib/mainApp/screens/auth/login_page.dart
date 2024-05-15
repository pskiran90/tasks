import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/mainApp/reusables/sized_box.dart';
import 'package:tasks/mainApp/screens/landingPage/landingscreen.dart';
import '../../reusables/colors.dart';
import '../../reusables/loading_screen.dart';
import '../../bloc/login_bloc.dart';
import '../../reusables/buttons.dart';
import '../../reusables/navigators.dart';
import '../../reusables/snack_bar.dart';
import '../../reusables/styles.dart';
import '../../../services/localDb/login/login_credentials_box.dart';
import '../../../services/localDb/login/login_credentials_model.dart';
import 'authentication_widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(text: null);
  TextEditingController passwordController = TextEditingController(text: null);
  late LoginCredentialsModel loginDetails;
  @override
  void initState() {
    LoginCredentialsModel? savedData = LoginCredentialsBox.loginCredentialsBox.fetchLoginCredentials;
    if (savedData != null && savedData.email != null) {
      emailController.text = savedData.email!;
      passwordController.text = savedData.password!;
      setState(() {
        loginDetails = savedData;
      });
    } else {
      setState(() {
        loginDetails = LoginCredentialsModel();
      });
    }
    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, eas) {
        if (eas is SignInFailure) {
          showSnackBar(context, eas.error, error: true);
        }
        if (eas is SignInSuccess) {
          showSnackBar(
            context,
            "Logged in",
          );
          pushSimple(context, const LandingScreen());
        }
      },
      builder: (context, eas) {
        double width = size.width * 0.8;
        double height = size.height * 0.8;
        return eas is SignInProgress
            ? const LoadingScreen(message: "Logging you in")
            : Scaffold(
                backgroundColor: white,
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: linearGradientBg,
                      child: Column(
                        children: [
                          hb30,
                          Center(
                            child: Container(
                              height: height,
                              width: width,
                              decoration: BoxDecoration(
                                color: none,
                                border: Border.all(color: primaryColor.withOpacity(0.40), width: 4),
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25, right: 25),
                                child: Form(
                                  key: loginFormKey,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 35),
                                      //email form field
                                      UserId(width: width, emailController: emailController),
                                      const SizedBox(height: 35),
                                      //Password form field
                                      Password(
                                        onFieldSubmitted: (String string) {
                                          login(context);
                                        },
                                        passwordController: passwordController,
                                        width: width,
                                      ),

                                      SizedBox(
                                        width: width,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: TextButton(
                                                onPressed: () async {
                                                  hideKeyboard();
                                                  setState(() {});

                                                  if (emailController.text.isEmpty) {
                                                    showSnackBar(context, "Please enter your user id to proceed", error: true);
                                                  }
                                                },
                                                child: const Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Forgot password ?",
                                                      textAlign: TextAlign.right,
                                                      style: TextStyle(fontSize: 12, letterSpacing: 1, color: primaryColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 20),
                                      // sign in button
                                      SignInButton(
                                        onPressed: passwordController.text.length < 10
                                            ? null
                                            : () {
                                                login(context);
                                              },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  void login(BuildContext context) {
    bool isValid = loginFormKey.currentState!.validate();
    if (isValid) {
      context.read<SignInBloc>().add(SignInUsingCredentials(
            email: emailController.text,
            password: passwordController.text,
          ));
    } else {
      showSnackBar(context, "Invalid email or password\nPlease retry", error: true);
    }
  }
}
