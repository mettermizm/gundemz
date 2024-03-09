import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gundemz/functions/width_height.dart';
import 'package:gundemz/variables/linkes.dart';

final List<String> gazetelerAd = [
  'Ekim Sayısı',
  'Kasım Sayısı',
  // 'Aralık Sayısı',
];

class OnBoardingModel {
  final String? image;
  OnBoardingModel({required this.image});
}

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(image: AppImageAsset.onBoardingImageOne),
  OnBoardingModel(image: AppImageAsset.onBoardingImageTwo),
  // OnBoardingModel(image: AppImageAsset.onBoardingImageThree),
];

class AppImageAsset {
  static const String onBoardingImageOne = kasimSayisi;
  static const String onBoardingImageTwo = ekimSayisi;
// static const String onBoardingImageThree =
//     'https://gundemz.com/wp-content/uploads/2023/11/gundemz-ekim_page-0001-247x300.jpg';
}

class Gazeteler extends StatelessWidget {
  const Gazeteler({super.key});

  @override
  Widget build(BuildContext context) {
    String url =logoAdress;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              Container(
                  width: screenWidth(context) * 0.90,
                  height: screenHeight(context) * 0.08,
                  child: CachedNetworkImage(imageUrl: url)),
              Container(
                child: Text(
                  'GAZETELER',
                  style: TextStyle(
                    fontSize: screenHeight(context) * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    letterSpacing: screenHeight(context) * 0.007,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight(context) * 0.05,
              ),
              Container(
                width: screenWidth(context) * 0.96,
                //  height: screenHeight(context) * 0.25,
                margin: EdgeInsets.only(
                  top: screenHeight(context) * 0.02,
                  bottom: screenHeight(context) * 0.02,
                  left: screenHeight(context) * 0.02,
                  right: screenHeight(context) * 0.02,
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Set the number of columns
                    //crossAxisSpacing: 8.0, // Set the spacing between columns
                    // mainAxisSpacing: 8.0, // Set the spacing between rows
                    mainAxisExtent: screenHeight(context) * 0.25,
                  ),
                  itemBuilder: (context, index) {
                    // Replace this with your item widget
                    return Column(
                      children: [
                        Center(
                          child: Container(child: Text(gazetelerAd[index])),
                        ),
                        Card(
                          margin: EdgeInsets.only(
                            top: screenHeight(context) * 0.02,
                          ),
                          // color: Colors.red,
                          child: Container(
                            //  color: Colors.amber,
                            height: screenHeight(context) *
                                0.15, // Adjust the height as needed
                            width: screenWidth(context) * 0.35,
                            child: CachedNetworkImage(
                              // ignore: unnecessary_null_comparison
                              imageUrl: onBoardingList[index].image! == null
                                  ? logoAdress
                                  : onBoardingList[index].image!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: gazetelerAd
                      .length, // Replace this with the actual number of items
                ),
              ),
            ],
          ),
        //  AdmobBannerIp(),
        ],
      )),
    );
  }
}
