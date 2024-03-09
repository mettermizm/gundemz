import 'package:flutter/cupertino.dart';


// ignore: must_be_immutable
class IndicatorApp extends StatelessWidget {
  double? radius;

  IndicatorApp({Key? key, required this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CupertinoActivityIndicator(
          radius: radius!,
          color: const Color.fromARGB(255, 0, 102, 211),
        ),
        // SizedBox(height: screenHeight(context) * 0.04),
      ],
    );
  }
}
