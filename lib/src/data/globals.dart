import 'package:flutter/material.dart';

class SizeConfig {
  static double heightMultiplier(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height > size.width ? size.height : size.width;
    return height / 812;
  }

  static double widthMultiplier(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.height > size.width ? size.width : size.height;
    return width / 375;
  }
}
