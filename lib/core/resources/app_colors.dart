import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor primarySwatch = Colors.deepPurple;
  static Color primary = const Color.fromRGBO(82, 72, 195, 1);
  static Color splash = Colors.deepPurpleAccent;
  static Color ihdaaSignatureBoard = const Color.fromRGBO(57, 39, 59, 1);
  //static Color secondary = Colors.amber;
  // const Color.fromRGBO(224, 80, 118, 1)
  static Color secondary = const Color.fromRGBO(251, 210, 222, 1);
  static Color thirdColor = const Color.fromRGBO(224, 80, 118, 1);
  static Color reset = Colors.redAccent;
  static Color red = Colors.red;
  static Color green = Colors.green;
  static Color expansion = Colors.deepPurple[50]!;
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color black45 = Colors.black45;
  static Color grey = Colors.grey;
  static Color greyLight = Colors.grey[300]!;
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
