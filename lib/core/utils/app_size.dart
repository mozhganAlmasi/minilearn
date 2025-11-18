import 'package:flutter/widgets.dart';

class AppSize {
  static late double width;
  static late double height;

  static late double paddingSmall;
  static late double paddingMedium;
  static late double paddingLarge;

  static late double fontSmall;
  static late double fontMedium;
  static late double fontLarge;

  static late double iconsize;
  static late double retakesizelarg;
  static late double retakesizesmall;
  static late double agecircular;
  static late double cardcircular;

  static void applySizes() {
    paddingSmall = width * 0.02;
    paddingMedium = width * 0.04;
    paddingLarge = width * 0.06;

    fontSmall = width * 0.035;
    fontMedium = width * 0.045;
    fontLarge = width * 0.080;

    iconsize = width * 0.15;
    retakesizelarg = width * 0.10;
    retakesizesmall = width * 0.06;
    agecircular = width * 0.04;
    cardcircular = width * 0.08;
  }
}
