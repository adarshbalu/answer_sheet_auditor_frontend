import 'package:flutter/material.dart';

class AppTheme {
  static const Color PRIMARY_COLOR = Color(0xFF13457A);
  static const Color ACCENT_COLOR = Color(0xFFFDB73B);
  static const Color ERROR_COLOR = Color(0xFFFD3B3B);
  static const Color DONE_COLOR = Color(0xFF00982B);
  static const Color CANVAS_COLOR = Color(0xFFF2F3F5);
  static const Color FONT_MAIN_COLOR = Color(0xFF14132A);
  static const Color FONT_MEDIUM_COLOR = Color(0xFF4A4A53);
  static const Color FONT_LIGHT_COLOR = Color(0xFF97A4AE);
  static const Color BORDER_COLOR = Color(0xFFD3DCE6);

  static const TextTheme TEXT_THEME = TextTheme(
    headline1: TextStyle(
      fontFamily: 'GoogleSans',
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: FONT_MAIN_COLOR,
    ),
    headline2: TextStyle(
      fontFamily: 'GoogleSans',
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: FONT_MAIN_COLOR,
    ),
    headline3: TextStyle(
      fontFamily: 'GoogleSans',
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: FONT_MEDIUM_COLOR,
    ),
    headline4: TextStyle(
      fontFamily: 'GoogleSans',
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: FONT_MAIN_COLOR,
    ),
    headline5: TextStyle(
      fontFamily: 'GoogleSans',
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: FONT_LIGHT_COLOR,
    ),
    button: TextStyle(
      fontFamily: 'GoogleSans',
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      fontFamily: 'GoogleSans',
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: FONT_LIGHT_COLOR,
    ),
    subtitle2: TextStyle(
      fontFamily: 'GoogleSans',
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: FONT_MAIN_COLOR,
    ),
    bodyText1: TextStyle(
      fontFamily: 'GoogleSans',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: FONT_MAIN_COLOR,
    ),
  );

  static const ButtonThemeData BUTTON_THEME_DATA = ButtonThemeData(
    buttonColor: PRIMARY_COLOR,
    textTheme: ButtonTextTheme.primary,
    padding: EdgeInsets.symmetric(
      vertical: 14.0,
      horizontal: 22.0,
    ),
  );

  static const IconThemeData ICON_THEME_DATA = IconThemeData(
    color: Colors.black,
    size: 36.0,
  );
}
