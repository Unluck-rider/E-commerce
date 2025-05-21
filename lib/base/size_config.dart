import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockWidth;
  static late double blockHeight;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;
  }

  // Get proportional width
  static double w(double inputWidth) => (inputWidth / 375.0) * screenWidth;

  // Get proportional height
  static double h(double inputHeight) => (inputHeight / 812.0) * screenHeight;
}


// use case
/* @override
Widget build(BuildContext context) {
  SizeConfig.init(context); // Always initialize once per screen

  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: SizeConfig.w(20), // Responsive width
      vertical: SizeConfig.h(10),   // Responsive height
    ),
    child: Text(
      'Hello!',
      style: TextStyle(fontSize: SizeConfig.w(16)), // Responsive font size
    ),
  );
}
*/