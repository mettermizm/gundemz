import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gundemz/ad_helper.dart';
import 'package:gundemz/functions/ipcontroller.dart';
import 'package:gundemz/functions/width_height.dart';
import 'package:gundemz/screens/gazeteler.dart';
import 'package:gundemz/screens/hakkimizda.dart';
import 'package:gundemz/screens/kunye.dart';
import 'package:gundemz/webviewscreens/iletisim.dart';



class MenuDrawer extends StatefulWidget {
  MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
   late AdmobReward rewardAd;
    late AdmobInterstitial interstitialAd;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
  void initState() {
    super.initState(); 
    rewardAd = AdmobReward(
      adUnitId: AdHelper.rewardedAdUnitId!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
      },
    );
       interstitialAd = AdmobInterstitial(
      adUnitId: AdHelper.interstitialAdUnitId!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );
    rewardAd.load();
    interstitialAd.load();
  }
  @override
  void dispose() {
    super.dispose();
    rewardAd.dispose();
    interstitialAd.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
       key: _scaffoldKey,
      child: ListView(
        children: [
          ListTile(
            title: Text(
              textAlign: TextAlign.center,
              'MENÜ',
              style: TextStyle(
                  fontSize: screenHeight(context) * 0.02,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            onTap: () {
        
              Get.back();
            },
          ),
          divider(context),
          ListTile(
              leading: Icon(
                Icons.home,
                size: screenHeight(context) * 0.03,
                color: Color.fromARGB(239, 217, 4, 4),
              ),
              title: Text('Anasayfa'),
              onTap: ()  {           
                Get.back();
              }),
          divider(context),
          ListTile(
              leading: Icon(
                Icons.library_books,
                size: screenHeight(context) * 0.03,
                color: Color.fromARGB(239, 217, 4, 4),
              ),
              title: Text('Gazeteler'),
              onTap: () async{
              await RewardAdController(context,rewardAd).constroctorclassR(context,rewardAd);             
              await  Get.to(Gazeteler());
              Get.back();
              }),             
              divider(context),
              ListTile(
              leading: Icon(
                Icons.info,
                size: screenHeight(context) * 0.03,
                color: Color.fromARGB(239, 217, 4, 4),
              ),
              title: Text('Hakkımızda'),
              onTap: () async{
              await RewardAdController(context,rewardAd).constroctorclassR(context,rewardAd);             
              await   Get.to(Hakkimizda());
              Get.back();
              }),
          divider(context),
          ListTile(
              leading: Icon(
                Icons.newspaper_sharp,
                size: screenHeight(context) * 0.03,
                color: Color.fromARGB(239, 217, 4, 4),
              ),
              title: Text('Künye'),
              onTap: ()async {
                await RewardAdController(context,rewardAd).constroctorclassR(context,rewardAd);             
                await Get.to(Kunye());
                Get.back();
              }),
          divider(context),
          ListTile(
              leading: Icon(
                Icons.perm_contact_calendar,
                size: screenHeight(context) * 0.03,
                color: Color.fromARGB(239, 217, 4, 4),
              ),
              title: Text('İletişim'),
              onTap: () async {
              await RewardAdController(context,rewardAd).constroctorclassR(context,rewardAd);             
              await Get.to(Iletisim());
              Get.back();
              }),
        ],
      ),
    );
  }

  Divider divider(BuildContext context) {
    return Divider(
      thickness: 1,
      indent: screenWidth(context) * 0.03,
      endIndent: screenWidth(context) * 0.03,
    );
  }
}