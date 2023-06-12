import 'package:flutter/material.dart';

class AppTheme{

  static const Color primary    = Color(0xFFEDC123);
  static const Color bgGray     = Color(0XFFFAFAFA);
  static const Color text_dark  = Color(0XFF000000);

  static const Color note_1     = Color(0XFFFF9B73);
  static const Color note_2     = Color(0XFFFFC972);
  static const Color note_3     = Color(0XFFB692FE);
  static const Color note_4     = Color(0XFFE4EE90);
  static const Color note_5     = Color(0XFF00D4FF);

  static final ThemeData lightTheme = ThemeData(
        primaryColor: const Color(0xFFEDC123),
        colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: Color(0XFFFAFAFA)),
        highlightColor:  const Color(0XFFFAFAFA),
        textTheme: const TextTheme(

          //Titulo 'Note'
          displayLarge: TextStyle(
              fontSize: 32.0,
              //fontFamily:,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000000),
          ),

          //Titulo 'App'
          displayMedium: TextStyle(
              fontSize: 32.0,
              //fontFamily:,
              fontWeight: FontWeight.bold,
              color: Color(0xFFEDC123),
          ),

          //'Login'/'Crear Cuenta'
          displaySmall: TextStyle(
              fontSize: 16.0,
              //fontFamily:,
              fontWeight: FontWeight.bold,
              color: Color(0XFF1F1F1F),
          ),

          bodyLarge: TextStyle(
              fontSize: 24.0,
              //fontFamily:,
              fontWeight: FontWeight.bold,
              color: Color(0XFF1F1F1F),
          ),

          //'Usuario'/'Contraseña'
          bodyMedium: TextStyle(
              fontSize: 14.0,
              //fontFamily:,
              fontWeight: FontWeight.normal,
              color: Color(0XFF1F1F1F),
          ),

          bodySmall: TextStyle(
              fontSize: 14.0,
              //fontFamily:,
              fontWeight: FontWeight.bold,
              color: Color(0XFF1F1F1F),
          ),
        ),
      );

}