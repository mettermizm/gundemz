import 'dart:async';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:gundemz/ad_helper.dart';
import 'package:gundemz/functions/ipcontroller.dart';
import 'package:gundemz/screens/bodyanasayfa.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gundemz/screens/habersayfasi.dart';
import 'package:gundemz/widgets/cupertinoactivityindicator.dart';


class AnasayfaController extends GetxController {
  RxInt selectedContainerIndex = 0.obs;
  final selectedCurrency = ''.obs;
  final selectDEP = ''.obs;
  var currentIndex = 0.obs;
  var aabb = true.obs;
  
 
// var updateText = [].obs;
// uF(){
//  for (currentIndex.value; currentIndex.value < imageListforHS.length - 1;) {
//     // Ensure the list has enough elements up to currentIndex.value
//     while (updateText.length <= currentIndex.value) {
//       updateText.add(''.obs);
//     }
// 
//   updateText[currentIndex.value].value = imageListforHS[currentIndex.value]["text"] ?? IndicatorApp(radius: 12);
//   return  updateText[currentIndex.value].value;
//    // print(updateText[currentIndex.value]);
//   }
// }



  final CarouselController _carouselController = CarouselController();
  late AdmobInterstitial interstitialAd;
  late Timer timer;
   
 
   
  @override
  void onInit()  {
    interstitialAd = AdmobInterstitial(
      adUnitId: AdHelper.interstitialAdUnitId!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );
    interstitialAd.load();
   // startTimer();
    selectContainer(0);
    super.onInit();
  }

  @override
  void onClose() {
    timer.cancel();
    interstitialAd.dispose();
    selectContainer(0);
    super.onClose();
    
  }

//   startTimer() {
//   timer = Timer.periodic(Duration(seconds: 3), (timer) {
//      if (currentIndex.value < imageListforHS.length - 1) {
//        currentIndex.value++;
//      } else {
//        currentIndex.value = 0;
//      }
//    //  callback: _carouselController.animateToPage(currentIndex.value); 
//    });
//  }

  // Rest of your controller methods... 
  void selectContainer(int index) {
    selectedContainerIndex.value = index;
  }
  void updateSelectedCurrency(String currency) {
    selectedCurrency.value = currency;
  }
  void updateSelectDEP(String dep) {
    selectDEP.value = dep;
  }
 
  void updateCurrentIndex() {
    currentIndex.value++;
  }

  carouselSliderSonD(double screenheight,
    double screenWidth,
    BuildContext context,
    AnasayfaController c){
    return CarouselSlider(
    disableGesture:c.aabb.value,
    carouselController: _carouselController,
    items: imageListforHS.asMap().entries.map((entry) {
    final index = entry.key;
    final item = entry.value;
    return GestureDetector(
      onTap: () {
        InterstitialAdControll(context, interstitialAd)
            .constroctorclass(context, interstitialAd);
        Get.to(
          HaberSayfasi(
            title: item["text"]!,
            content: textListforHS[index]["content"]!,
            imgUrl: networkImageListforHS[index]["attachments"]!,
            category: titleListforHS[index]["baslik"]!,
            time: '',
          ),
        );
      },
      child: Container(
        height: screenheight * 0.025,
        alignment: Alignment.center,
        child:  Text(
          item["text"] ?? '',
          maxLines: 1,
          style: TextStyle(
            fontSize: screenheight * 0.016,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }).toList(),
  options: CarouselOptions(
    viewportFraction: 1,
    autoPlay: true,
    enlargeCenterPage: true,
    scrollDirection: Axis.vertical,
    onPageChanged: (index, reason) {
    print(imageListforHS[index]["text"]!);
    },
  ),
);

  }

}
  

