import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    )
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  // setting the bg color manually
  scaffoldBackgroundColor: const Color(0xff15161a),
  appBarTheme:const AppBarTheme(
    elevation: 0,
    backgroundColor: Color(0xff15161a)
  )
);


