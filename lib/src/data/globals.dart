// globals.dart

import 'package:flutter/widgets.dart';

double heightMediaQuery = 0.0;
double widthMediaQuery = 0.0;

void updateMediaQueryValues(BuildContext context) {
  heightMediaQuery = MediaQuery.of(context).size.height / 812;
  widthMediaQuery = MediaQuery.of(context).size.width / 375;
}
