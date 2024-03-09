import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gundemz/ad_helper.dart';
import 'package:gundemz/functions/width_height.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class InterstitialAdControll extends StatefulWidget {
   late AdmobInterstitial interstitialAd;
   late BuildContext context;
   InterstitialAdControll(this.context,this.interstitialAd);
  @override
  _InterstitialAdControllState createState() => _InterstitialAdControllState();
     constroctorclass(context,interstitialAd) {
    return _InterstitialAdControllState().checkIPAddress( context, interstitialAd);
   }
  
}

class _InterstitialAdControllState extends State<InterstitialAdControll> {
  late AdmobInterstitial interstitialAd;
   Future<void> checkIPAddress(BuildContext context, AdmobInterstitial interstitialAd) async {
    try {
      final response = await http.get(Uri.parse('https://ipinfo.io/json'));

      if (response.statusCode == 200) {
        final ipInfo = json.decode(response.body);
        final clientIP = ipInfo['ip'];

        // Perform your checks here based on the clientIP
        if (clientIP == '78.186.205.7') {
          print('IP address is blocked: $clientIP');        
        } else {
          interstitialAd.show();
          print('Reklamlar izin verildi. IP Adresi: $clientIP');
          // Continue with your app logic
        }
      } else {
        print('Failed to retrieve IP information');
      }
    } catch (e) {
      print('Error checking IP address: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Your widget UI code goes here
    return  Container();
  }
}
/////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
// ignore: must_be_immutable
class RewardAdController extends StatefulWidget {
   late AdmobReward rewardAd;
   late BuildContext context;
   RewardAdController(this.context,this.rewardAd);

  @override
  State<RewardAdController> createState() => _RewardAdControllerState();
    constroctorclassR(context,rewardAd) {
    return _RewardAdControllerState().checkIPAddressR( context, rewardAd);
   }

}

class _RewardAdControllerState extends State<RewardAdController> {
 late AdmobReward rewardAd;

   @override
  void initState() {
    rewardAd = AdmobReward(
      adUnitId: AdHelper.rewardedAdUnitId!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
      },
    );
    rewardAd.load();
    super.initState();
  }
    @override
  void dispose() {
    rewardAd.dispose();
    super.dispose();
  }

   Future<void> checkIPAddressR(BuildContext context, AdmobReward rewardAd) async {
    try {
      final response = await http.get(Uri.parse('https://ipinfo.io/json'));

      if (response.statusCode == 200) {
        final ipInfo = json.decode(response.body);
        final clientIP = ipInfo['ip'];

        // Perform your checks here based on the clientIP
        if (clientIP == '78.186.205.7') {
          print('IP address is blocked: $clientIP');        
        } else {
          rewardAd.show();
          print('Reklamlar izin verildi. IP Adresi: $clientIP');
          // Continue with your app logic
        }
      } else {
        print('Failed to retrieve IP information');
      }
    } catch (e) {
      print('Error checking IP address: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Your widget UI code goes here
    return  Container();
  }
}
/////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
class BannerCheckIp extends StatefulWidget {
  @override
  State<BannerCheckIp> createState() => _BannerCheckIpState();
}

class _BannerCheckIpState extends State<BannerCheckIp> {
  late Future<void> ipCheckFuture;
  bool allowAds = true;

  @override
  void initState() {
    super.initState();
    ipCheckFuture = checkIPAddressR();
  }

  Future<void> checkIPAddressR() async {
    try {
      final response = await http.get(Uri.parse('https://ipinfo.io/json'));
      if (response.statusCode == 200) {
        final ipInfo = json.decode(response.body);
        final clientIP = ipInfo['ip'];

        // Perform your checks here based on the clientIP
        if (clientIP == '78.186.205.7') {
          print('IP address is blocked: $clientIP');
          setState(() {
            allowAds = false;
          });
        } else {
          print('Reklamlar izin verildi. IP Adresi: $clientIP');
          setState(() {
            allowAds = true;
          });
        }
      } else {
        print('Failed to retrieve IP information');
      }
    } catch (e) {
      print('Error checking IP address: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ipCheckFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // You can show a loading indicator here if needed
          return Container();
        } else {
          return allowAds
              ? Positioned(
                  bottom: 0,
                  child: Container(
                    height: screenHeight(context) * 0.05,
                    width: screenWidth(context) * 0.94,
                    child: AdmobBanner(
                      adUnitId: AdHelper.bannerAdUnitId!,
                      adSize: AdmobBannerSize.SMART_BANNER(context),
                    ),
                  ),
                )
              : Container(); // Return an empty container if ads are not allowed
        }
      },
    );
  }
}

