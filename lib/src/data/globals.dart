import 'package:flutter/material.dart';

class SizeConfig {
  static double heightMultiplier(BuildContext context) {
    return MediaQuery.of(context).size.height / 812;
  }

  static double widthMultiplier(BuildContext context) {
    return MediaQuery.of(context).size.width / 375;
  }
}
