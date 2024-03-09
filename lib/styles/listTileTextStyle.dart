import 'package:flutter/material.dart';

listTileTextStyle({required String? txt}) {
  return Text(
    '$txt'.toUpperCase(),
    style: TextStyle(
      wordSpacing: 1,
      fontSize: 16,
      fontFamily: 'AndikaNewBasic',
      // fontWeight: FontWeight.bold,
      decorationColor: Colors.amber,
      shadows: [
        Shadow(
          color: Color.fromARGB(255, 186, 26, 14),
          blurRadius: 1.0,
          offset: Offset(0.30, 0.30),
        ),
      ],
    ),
  );
}
