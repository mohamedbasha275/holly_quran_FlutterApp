import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor primarySwatch = Colors.deepPurple;
  static Color primary = const Color.fromRGBO(82, 72, 195, 1);
  static Color splash = Colors.deepPurpleAccent;
  static Color secondary = Colors.amber;
  static Color expansion = HexColor('FCECDD');
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color grey = Colors.grey;
  static Color transparentColor=Colors.transparent;
}

// convert hex to color
class HexColor extends Color
{
  static int _getColorFromHex(String hexColor)
  {
    hexColor =hexColor.toUpperCase().replaceAll("#", "");
    if(hexColor.length==6)
    {
      hexColor="FF$hexColor";
    }
    return int.parse(hexColor,radix: 16);
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

}
