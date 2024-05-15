import 'package:flutter/material.dart';

import '../../reusables/colors.dart';

class Password extends StatelessWidget {
  const Password({
    super.key,
    required this.width,
    required this.onFieldSubmitted,
    required this.passwordController,
  });
  final double width;
  final void Function(String)? onFieldSubmitted;
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: passwordController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        obscuringCharacter: "*",
        decoration: const InputDecoration(
          labelText: "Password *",
          labelStyle: TextStyle(color: black, fontSize: 15),
        ),
    
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}

class UserId extends StatelessWidget {
  const UserId({
    super.key,
    required this.width,
    required this.emailController,
  });

  final double width;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          labelText: "User ID *",
          labelStyle: TextStyle(color: black, fontSize: 15),
          suffixIcon: Icon(Icons.account_circle),
        ),
       
      ),
    );
  }
}
