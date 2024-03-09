import 'package:flutter/material.dart';

tapTextStyle({required String? txt, FontWeight? fontWeight}) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          '$txt',
          style: TextStyle(
            color: Colors.black26,
            wordSpacing: 1,
            fontSize: 18,
            fontFamily: 'AndikaNewBasic',
            fontWeight: fontWeight,
          ),
        ),
      ),
    ],
  );
}

tapTextStyleUnSelected({required String? txt}) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          '$txt',
          style: TextStyle(
            wordSpacing: 1,
            fontSize: 18,
            fontFamily: 'AndikaNewBasic',
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
    ],
  );
}
