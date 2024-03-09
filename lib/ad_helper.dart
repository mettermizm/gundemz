//import 'dart:io';
//class AdHelper {
//  static String? get bannerAdUnitId {
//     if (Platform.isAndroid) {
//      return 'ca-app-pub-2894818708842198/3731346549';
//    } else if (Platform.isIOS) {
//      return 'ca-app-pub-2894818708842198/4981874101';
//    } else {
//      throw new UnsupportedError('Unsupported platform');
//    }
//  }
//
//  static String? get interstitialAdUnitId {
//     if (Platform.isAndroid) {
//      return 'ca-app-pub-2894818708842198/7586846988';
//    } else if (Platform.isIOS) {
//      return 'ca-app-pub-2894818708842198/3673549914';
//    } else {
//      throw new UnsupportedError('Unsupported platform');
//    }
//  }
//
//  static String? get rewardedAdUnitId {
//     if (Platform.isAndroid) {
//      return 'ca-app-pub-2894818708842198/8785196827';
//       } else if (Platform.isIOS) {
//         return 'ca-app-pub-2894818708842198/3837201446';
//    } else {
//      throw new UnsupportedError('Unsupported platform');
//    }
//  }
//}

import 'package:admob_flutter/admob_flutter.dart';

bool _adtest = true;

class AdHelper {
  static String? get bannerAdUnitId {
    if (_adtest = true) {
      return AdmobBanner.testAdUnitId;
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String? get interstitialAdUnitId {
    if (_adtest = true) {
      return AdmobInterstitial.testAdUnitId;
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String? get rewardedAdUnitId {
    if (_adtest = true) {
      return AdmobReward.testAdUnitId;
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
}
