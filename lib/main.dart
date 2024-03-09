import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gundemz/screens/aramasayfasi.dart';
import 'package:gundemz/screens/bodyanasayfa.dart';
import 'package:gundemz/screens/bodyaramasayfasi.dart';
import 'package:gundemz/screens/gazeteler.dart';
import 'package:gundemz/screens/habersayfasi.dart';
import 'package:gundemz/screens/hakkimizda.dart';
import 'package:gundemz/screens/kesfet.dart';
import 'package:gundemz/screens/kunye.dart';
import 'package:gundemz/variables/linkes.dart';
import 'package:gundemz/view/anasayfa_view.dart';
import 'package:gundemz/webviewscreens/iletisim.dart';
import 'package:gundemz/webviewscreens/yerelsetcim.dart';
import 'package:gundemz/widgets/animatedSplashScreen.dart';
import 'package:gundemz/widgets/themeapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  //MobileAds.instance.initialize();
  await Admob.requestTrackingAuthorization();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    String url = logoAdress;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeApp(),
      // home: AnimatedSplashScreenLunsh(url: url),
      initialRoute: '/',
      getPages:[
        GetPage(name:'/', page: () => AnimatedSplashScreenLunsh(url: url)),
        GetPage(name:'/anasayfa', page: ()=> AnasayfaView()),
        GetPage(name:'/bodyanasayfa' ,page: ()=> BodyHomePage()),
        GetPage(name:'/kesfet', page: ()=> Kesfet()),
        GetPage(name:'/arama', page: ()=> AramaSayfasi()),
        GetPage(name:'/bodyarama',page: ()=> BodyAramaSayfasi()),
        GetPage(name:'/gazeteler',page: ()=> Gazeteler()),
        GetPage(name:'/haber',page: () => HaberSayfasi()),
        GetPage(name:'/hakkimizda', page: ()=> Hakkimizda()),
        GetPage(name:'/kunye', page: ()=> Kunye()),
        GetPage(name:'/iletisim', page: ()=> Iletisim()),
        GetPage(name:'/yerelsecim', page: ()=> YerelSecim()),
      ], 
    ); 
  }
}
