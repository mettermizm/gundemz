import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gundemz/widgets/bottomnavigationbar.dart';
import 'package:page_transition/page_transition.dart';


class AnimatedSplashScreenLunsh extends StatelessWidget {
  const AnimatedSplashScreenLunsh({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2000,
      // ignore: unnecessary_null_comparison
      splash: url == null ? Container() : CachedNetworkImage(imageUrl: url),
      nextScreen: BottomNavigationbar(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
    );
  }
}