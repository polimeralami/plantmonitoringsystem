import 'package:flutter/material.dart';

// app configurations
class AppConfig {
  static const appName = "Flutter Login Templates";
}

//Class to get Screen Size
class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = (screenWidth! / 100);
    blockSizeVertical = (screenHeight! / 100);

    _safeAreaHorizontal =
        _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical =
        _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;
  }
}

// class for change card color based on value
class AlertConfig {
  static const minTemp = 24;
  static const maxTemp = 30;
  static const minTempColor = Colors.yellow;
  static const maxTempColor = Colors.red;

  static const minHumid = 55;
  static const maxHumid = 75;
  static const minHumidColor = Colors.yellow;
  static const maxHumidColor = Colors.red;

  static const minMoisture = 65;
  static const maxMoisture = 74;
  static const minMoistureColor = Colors.yellow;
  static const maxMoistureColor = Colors.red;
}
