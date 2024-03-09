import 'package:flutter/material.dart';

double screenWidth(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  return screenWidth;
}

double screenHeight(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  return screenHeight;
}
