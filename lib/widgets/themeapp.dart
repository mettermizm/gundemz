import 'package:flutter/material.dart';

themeApp(){
  return ThemeData(
        colorScheme: ColorScheme.fromSeed(
        seedColor: Color.fromARGB(255, 226, 217, 217)),
        useMaterial3: true,
      );
}