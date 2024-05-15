import 'package:flutter/material.dart';
import 'package:tasks/mainApp/reusables/colors.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width * 0.8,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 15.0,
        ),
        child: const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            'Sign In',
            style: TextStyle(fontSize: 15, color: black),
          ),
        ),
      ),
    );
  }
}
