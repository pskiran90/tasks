import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF125C92);
const Color secondaryColor = Color(0xFFF9FEFF);
const Color primaryColorLight = Color(0xFFbad0df);
const bgColor = Color(0xFFF2F2F2);
const Color rowColor = Color(0xFF86A3B8);
const Color creditIn = Color(0xFF2697FF);
const Color creditOut = Color(0xFFFFA113);
const Color deposit = Color(0xFFA4CDFF);
const Color withdrawal = Color(0xFF007EE5);
const Color blue = Colors.blue;
const Color none = Colors.transparent;
const Color black = Colors.black;
const Color white = Colors.white;
const Color indigo = Colors.indigo;
const Color orange = Colors.orange;
const Color green = Colors.green;
const Color amber = Colors.amber;
const Color cyan = Colors.cyan;
const Color blueGrey = Colors.blueGrey;
const Color red = Colors.red;
const Color grey = Colors.grey;
const textColor = Colors.black;
Color grey3 = Colors.grey[300]!;
Color lbo2 = Colors.lightBlue.withOpacity(0.2);
Color lgo2 = Colors.lightGreen.withOpacity(0.2);
Color lro2 = Colors.red.withOpacity(0.2);
Color primaryColorwithOpacity = const Color(0xFF125C92).withOpacity(0.30);
MaterialColor primary = MaterialColor(0xFF125C92, color);
Map<int, Color> color = const {
  50: Color.fromRGBO(18, 92, 146, .1),
  100: Color.fromRGBO(18, 92, 146, .2),
  200: Color.fromRGBO(18, 92, 146, .3),
  300: Color.fromRGBO(18, 92, 146, .4),
  400: Color.fromRGBO(18, 92, 146, .5),
  500: Color.fromRGBO(18, 92, 146, .6),
  600: Color.fromRGBO(18, 92, 146, .7),
  700: Color.fromRGBO(18, 92, 146, .8),
  800: Color.fromRGBO(18, 92, 146, .9),
  900: Color.fromRGBO(18, 92, 146, 1),
};

//get color from rgbo value
Color rgbo(int r, int g, int b, double o) {
  return Color.fromRGBO(r, g, b, o);
}

//get color from hexadecimal
Color hex(String hex) {
  return Color(int.parse("0xFF${hex.toUpperCase()}"));
}
