import 'package:flutter/material.dart';

class NotSelectedView extends StatelessWidget {
  const NotSelectedView({
    super.key,
    required this.msg,
    this.padding = false,
  });
  final String msg;
  final bool padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding ? 8 : 0),
      child: Card(
        child: Center(
          child: Text(msg),
        ),
      ),
    );
  }
}
