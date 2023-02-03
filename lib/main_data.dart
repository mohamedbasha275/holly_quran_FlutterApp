import 'package:flutter/material.dart';
// title
String mainTitle = "إيجاري";
// width and height of screens
extension MediaQueryValues on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}
/// ***********************************************************************
// lightTheme
final lightTheme = ThemeData(
  fontFamily: 'Cairo',
  primarySwatch: Colors.green,
  backgroundColor: const Color.fromRGBO(61, 154, 150, 1),
  canvasColor: const Color.fromRGBO(255, 255, 255, 1), // background color of pages
  primaryColor: const Color.fromRGBO(85, 167, 151, 1),
  bottomAppBarColor: const Color.fromRGBO(107, 108, 107, 1),
  dividerColor: const Color.fromRGBO(220, 223, 227, 1),
  indicatorColor: const Color.fromRGBO(169, 171, 173, 1),
  // app bar
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    shadowColor: Colors.grey,
    foregroundColor: Colors.black,
  ),
  // text
  textTheme: const TextTheme(
    // used
    headline1: TextStyle(
      fontFamily: 'Cairo',
      color: Color.fromRGBO(52, 52, 52, 1),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    // used
    headline2: TextStyle(
      color: Color.fromRGBO(83, 82, 88, 1.0),
      fontSize: 27,
      fontWeight: FontWeight.w500,
      fontFamily: 'Cairo',
    ),
    // used
    headline3: TextStyle(
      fontFamily: 'Cairo',
      color: Color.fromRGBO(83, 82, 88, 1.0),
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    // used
    headline4: TextStyle(
      fontFamily: 'Cairo',
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    ),
    // used
    headline5: TextStyle(
      fontFamily: 'Cairo',
      color: Color.fromRGBO(83, 82, 88, 1),
      fontSize: 10,
    ),
    //used
    headline6: TextStyle(
      fontFamily: 'Cairo',
      color: Color.fromRGBO(56, 154, 151, 1),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    // used
    bodyText1: TextStyle(
      color: Color.fromRGBO(128,128,128,1),
      fontFamily: 'Cairo',
      fontSize: 14,
    ),
    // default of all  texts
    bodyText2: TextStyle(
      color: Color.fromRGBO(134, 136, 141, 1),
      fontFamily: 'Cairo',
    ),
  ),
);