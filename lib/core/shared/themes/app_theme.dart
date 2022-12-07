import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    backgroundColor: Color.fromARGB(255, 53, 53, 53),
    cardColor: Color.fromARGB(255, 77, 73, 68).withOpacity(0.9),
    primaryColor: Color.fromARGB(255, 77, 73, 68),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headline2: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
      headline4: TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      headline5: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Colors.white,
      ),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    backgroundColor: Color.fromARGB(255, 230, 230, 230),
    cardColor: Color.fromARGB(255, 241, 232, 219).withOpacity(0.9),
    primaryColor: Colors.white,
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headline2: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
      headline4: TextStyle(
        fontSize: 12,
        color: Colors.grey,
      ),
      headline5: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Colors.black,
      ),
    ),
  );
}
