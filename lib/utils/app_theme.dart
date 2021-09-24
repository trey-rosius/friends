import 'package:flutter/material.dart';

const Color primary = Color(0xFFa06ef3);
const Color bgColor = Color(0xFF1c1c1c);
const Color white = Color(0xFFFFFFFF);
const Color black = Color(0xFF000000);
const Color textfieldColor = Color(0xFF2b2b2b);
const Color greyColor = Color(0xFF161616);
const Color chatBoxOther = Color(0xFF3d3d3f);
const Color chatBoxMe = Color(0xFFf94c84);


class ThemeColor {
  static const Color primary = Color(0xFFa06ef3);
  static const Color bgColor = Color(0xFF1c1c1c);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color textfieldColor = Color(0xFF2b2b2b);
  static const Color greyColor = Color(0xFF161616);
  static const Color chatBoxOther = Color(0xFF3d3d3f);
  static const Color secondary = Color(0xFFf94c84);
  static const Color color1 = Color(0xFFfa709a);
  static const Color color2 = Color(0xFFfee240);
  static const Color cardBackground = Color(0xFF434343);


  static Shader linearGradient = LinearGradient(
    colors: <Color>[secondary, primary],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  static Shader linearGradient2 = LinearGradient(
    colors: <Color>[color1, color2],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
}