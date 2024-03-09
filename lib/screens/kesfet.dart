import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gundemz/ad_helper.dart';
import 'package:gundemz/screens/habersayfasi.dart';
import 'package:gundemz/functions/ipcontroller.dart';
import 'package:gundemz/scripts/api.dart';
import 'package:gundemz/variables/linkes.dart';
import 'package:gundemz/widgets/appbar.dart';
import 'package:gundemz/widgets/cupertinoactivityindicator.dart';
import 'package:gundemz/widgets/drawer.dart';

const List<String> list = <String>[
  'Gündem',
  'Ekonomi',
  'İzmir',
  'Dünya',
  'Spor',
  'Sağlık',
  'Eğitim',
  'Magazin',
  'Teknoloji'
];

String? dropdownValue = list.first;

class Kesfet extends StatefulWidget {
  Kesfet({super.key});
  @override
  State<Kesfet> createState() => _KesfetState();
}

class _KesfetState extends State<Kesfet> {
  String? baslikG = 'gündem';
  int visibleItemCount = 8;
  ScrollController _scrollController = ScrollController();
  List<dynamic> posts = [];
  late AdmobInterstitial interstitialAd;
  late AdmobReward rewardAd;
  // final _nativeAdController = NativeAdmobController();
  void _loadMoreItems() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        visibleItemCount +=8;
      });

      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        useSafeArea: true,
        builder: (BuildContext context) {
          return IndicatorApp(
            radius: 15,
          );
        },
      );
      // Fetch more posts using the Api.getPosts function
      Api.getPosts(baslikG ?? 'gündem', uzunluk: visibleItemCount)
          .then((newPosts) {
        // Close the loading indicator
        Get.back();
        setState(() {
          posts = newPosts; // Assign new data to the list
        });
      });
    }
  }

  @override
  void initState() {
    interstitialAd = AdmobInterstitial(
      adUnitId: AdHelper.interstitialAdUnitId!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );

    rewardAd = AdmobReward(
      adUnitId: AdHelper.rewardedAdUnitId!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
      },
    );
    
    interstitialAd.load();
    rewardAd.load();
    //  _nativeAdController.reloadAd(forceRefresh: true);
    _scrollController.addListener(_loadMoreItems);
    super.initState();
    // İlk verileri çekmek için initState içinde çağırın
    Api.getPosts(baslikG ?? 'gündem', uzunluk: visibleItemCount)
        .then((initialPosts) {
      setState(() {
        posts = initialPosts;
      });
    });
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    rewardAd.dispose();
    //  _nativeAdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    Get.put(OnBoardingControllerTmp());
    return Scaffold(
      appBar: appAppBar(context),
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              physics: ScrollPhysics(),
              controller: _scrollController,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    kesfetcont(context),
                    sliderdot(screenwidth, screenheight),
                    onerilenler(context, screenwidth, screenheight),
                  ]),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(children: [
                      buildFutureBuilder(screenwidth, screenheight),
                    ]),
                  ]),
                ),
              ],
            ),
           BannerCheckIp(),
          ],
        ),
      ),
      drawer: MenuDrawer(),
    );
  }

  Widget buildFutureBuilder(double screenWidth, double screenheight) {
    return FutureBuilder<List<dynamic>>(
  
      future:
          Api.getPosts(dropdownValue ?? 'gündem', uzunluk: visibleItemCount),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        try {
          if (snapshot.hasError || snapshot.data == null) {
            return IndicatorApp(radius: 10);
          } else if (snapshot.hasData) {
            List<dynamic> posts = snapshot.data!;
            return Stack(
              children: [
                Positioned(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: screenheight * 0.02,
                          bottom: screenheight * 0.02,
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent: screenheight * 0.17,
                          ),
                          itemCount: posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> post = posts[index];
                            String text = post['title'];
                            Map<String, String> yeniMap = {"text": text};
                            imageList.add(yeniMap);
                            String title = post['baslik'];
                            Map<String, String> yeniMap3 = {"baslik": title};
                            titleList.add(yeniMap3);
                            String image = post["attachments"][0] ?? logoAdress;
                            Map<String, String> yeniMap2 = {
                              "attachments": image
                            };
                            networkImageList.add(yeniMap2);

                            String content = '${post['content']}...';
                            Map<String, String> yeniMap1 = {"content": content};
                            textList.add(yeniMap1);
                            List<String> words = content.split(' ');
                            // ignore: unused_local_variable
                            String shortContent = (words.length > 5)
                                ? words.sublist(0, 5).join(' ')
                                : content;
                            String timeAgo;
                            DateTime postDate =
                                DateTime.parse(posts[index]['post_date']);
                            DateTime now = DateTime.now();
                            Duration difference = now.difference(postDate);

                            if (difference.inMinutes < -1) {
                              timeAgo = 'az önce';
                            } else if (difference.inMinutes < 60) {
                              timeAgo = '${difference.inMinutes} dakika önce';
                            } else if (difference.inHours < 24) {
                              timeAgo = '${difference.inHours} saat önce';
                            } else {
                              timeAgo = '${difference.inDays} gün önce';
                            }
                            return GestureDetector(
                              onTap: () {
                                InterstitialAdControll(context,interstitialAd).constroctorclass(context,interstitialAd);  
                                Get.to( HaberSayfasi(
                                      baslik: posts[index]['baslik'],
                                      title: posts[index]["title"] ?? 'hata',
                                      content: post['content'],
                                      category: posts[index]['baslik'],
                                      time: timeAgo,
                                      imgUrl: posts[index]["attachments"]
                                                  ?.isNotEmpty ==
                                              true
                                          ? posts[index]["attachments"][0]
                                          : logoAdress,
                                   ),
                                );
                              },
                              child: Container(
                                width: screenWidth * 0.94,
                                height: screenheight * 0.17,
                                margin: EdgeInsets.only(
                                    left: screenWidth * 0.03,
                                    right: screenWidth * 0.03),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Card(
                                          margin: EdgeInsets.symmetric(
                                              vertical: screenheight * 0.01),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                new Radius.circular(8)),
                                          ),
                                          child: Container(
                                            width: screenWidth * 0.33,
                                            height: screenheight * 0.15,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                colorFilter:
                                                    new ColorFilter.mode(
                                                  Colors.black
                                                      .withOpacity(0.37),
                                                  BlendMode.darken,
                                                ),
                                                image: CachedNetworkImageProvider(
                                                    posts[index]["attachments"]
                                                                ?.isNotEmpty ==
                                                            true
                                                        ? posts[index]
                                                            ["attachments"][0]
                                                        : logoAdress),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: screenWidth * 0.61,
                                          height: screenheight * 0.15,
                                          margin: EdgeInsets.symmetric(
                                              vertical: screenheight * 0.01),
                                          padding: EdgeInsets.only(
                                              left: screenWidth * 0.03),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        posts[index]
                                                                ['baslik'] ??
                                                            'hata',
                                                        // posts[index]["baslik"]!,
                                                        style: TextStyle(
                                                          fontSize:
                                                              screenheight *
                                                                  0.0155,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  posts[index]["title"] ??
                                                      'hata',
                                                  //   posts[index]["title"]!,
                                                  style: TextStyle(
                                                    fontSize:
                                                        screenheight * 0.021,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  softWrap: true,
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        timeAgo,
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                          fontSize:
                                                              screenheight *
                                                                  0.013,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container();
        } catch (e) {
          return Text('$e');
        }
      },
    );
  }

  filter(double screenWidth, double screenheight) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: dropdownbutton(screenWidth, screenheight)),
          ],
        ),
      ],
    );
  }

  dropdownbutton(
    double screenWidth,
    double screenheight,
  ) {
    return Container(
      // color: Colors.blue,
      alignment: Alignment.topRight,
      height: screenheight * 0.05,
      width: screenWidth * 0.55,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<String>(
        underline: SizedBox(),
        value: dropdownValue,
        icon: Container(
          margin: EdgeInsets.only(right: screenWidth * 0.02),
          // color: Colors.yellow,
          width: screenWidth * 0.055,
          height: screenheight * 0.03,
          child: new LayoutBuilder(builder: (context, constraint) {
            return new Icon(
              Icons.tune,
              size: constraint.biggest.height,
            );
          }),
        ),
        style: const TextStyle(color: Colors.black),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: screenheight * 0.017),
            ),
          );
        }).toList(),
      ),
    );
  }

  Container onerilenler(
    BuildContext context,
    double screenWidth,
    double screenheight,
  ) {
    return Container(
      width: screenWidth * 0.94,
      height: screenheight * 0.03,
      margin: EdgeInsets.only(
        top: screenheight * 0.034,
        left: screenWidth * 0.03,
        right: screenWidth * 0.03,
      ),
      // color: Colors.amber,
      child: Row(children: [
        Expanded(
          child: Container(
            child: Text(
              'Önerilenler',
              style: TextStyle(
                  fontFamily: "Avenir Heavy",
                  fontSize: screenheight * 0.025,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]),
    );
  }

  Container kesfetcont(BuildContext context) {
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.94,
      height: screenheight * 0.095,
      // color: Colors.red,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      // padding: EdgeInsets.symmetric(
      //     horizontal: MediaQuery.of(context).size.width / 20),
      child: Row(children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Keşfet',
                  style: TextStyle(
                      // fontFamily: "Avenir Book",
                      fontSize: screenheight * 0.05,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  'Dünyanın dört bir yanından haberler.',
                  style: TextStyle(
                      fontFamily: "Avenir Book",
                      fontSize: screenheight * 0.015),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  //       width: screenWidth * 0.055,
                  // height: screenheight * 0.03,
                  //   width: screenWidth * 0.20,
                  // height: screenheight * 0.02,
                  // color: Colors.amber,
                  margin: EdgeInsets.only(right: screenWidth * 0.02),
                  child: dropdownbutton(screenWidth, screenheight),
                ),
              ]),
        )
      ]),
    );
  }

  sliderdot(double screenwidth, double screenheight) {
    return Container(
      child: Column(children: [
        Container(
          width: screenwidth * 0.94,
          height: screenheight * 0.27,
          margin: EdgeInsets.symmetric(
              horizontal: screenwidth * 0.03, vertical: screenheight * 0.015),
          child: CustomSliderOnBoarding(),
        ),
        Container(
          alignment: Alignment.center,
          // color: Colors.amber,
          width: screenwidth * 0.25,
          height: screenheight * 0.01,
          child: Column(children: const [
            CustomDotControllerOnBoarding(),
          ]),
        ),
      ]),
    );
  }
}

class OnBoardingModel {
  final String? image;
  OnBoardingModel({required this.image});
}

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(image: AppImageAsset.onBoardingImageOne),
  OnBoardingModel(image: AppImageAsset.onBoardingImageTwo),
  OnBoardingModel(image: AppImageAsset.onBoardingImageThree),
];

class CustomSliderOnBoarding extends GetView<OnBoardingControllerTmp> {
  

  
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: Api.getPosts(dropdownValue ?? 'gündem', uzunluk: 10),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return IndicatorApp(
            radius: 15,
          ); // Yüklenirken gösterilecek widget
        }
        if (snapshot.hasError) {
          return Text('Hata: ${snapshot.error}');
        } else if (snapshot.data == null) {
          return Text('Hata: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<dynamic> posts = snapshot.data!;
          String timeAgo;
          DateTime postDate = DateTime.parse(posts[0]['post_date']);
          DateTime now = DateTime.now();
          Duration difference = now.difference(postDate);
          if (difference.inMinutes < -1) {
            timeAgo = 'az önce';
          } else if (difference.inMinutes < 60) {
            timeAgo = '${difference.inMinutes} dakika önce'; //
          } else if (difference.inHours < 24) {
            timeAgo = '${difference.inHours} saat önce';
          } else {
            timeAgo = '${difference.inDays} gün önce';
          }
          return PageView.builder(
            
            onPageChanged: (val) {
              controller.onPageChaged(val);
            },
            itemCount: onBoardingList.length,
            itemBuilder: (context, i) => Stack(children: [
              GestureDetector(
                onTap: () {         
             
                  Get.to( HaberSayfasi(
                        baslik: posts[i]['baslik'],
                        title: posts[i]["title"] ?? 'hata',
                        content: posts[i]['content'],
                        category: posts[i]['baslik'],
                        time: timeAgo,
                        imgUrl: posts[i]["attachments"]?.isNotEmpty == true
                            ? posts[i]["attachments"][0]
                            : logoAdress,
                    ),                   
                  );
                },
                child: Stack(
                  children: [
                    Positioned(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: screenwidth * 0.94,
                              height: screenheight * 0.27,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                image: DecorationImage(
                                  colorFilter: new ColorFilter.mode(
                                      Colors.black.withOpacity(0.40),
                                      BlendMode.darken),
                                  image: NetworkImage(
                                    posts[i]["attachments"]?.isNotEmpty == true
                                        ? posts[i]["attachments"][0]
                                        : logoAdress,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: screenheight * 0.02,
                                  left: screenwidth * 0.04,
                                  bottom: screenheight * 0.21),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                              ),
                              width: screenwidth * 0.20,
                              height: screenheight * 0.04,
                              child: Center(
                                child: Text(
                                  posts[i]['baslik'],
                                  style: TextStyle(
                                      // fontFamily: "Avenir Heavy",
                                      color: Colors.white,
                                      fontSize: screenheight * 0.015),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              // color: Colors.black,
                              width: screenwidth * 0.70,
                              height: screenheight * 0.09,
                              margin: EdgeInsets.only(
                                  top: screenheight * 0.18,
                                  left: screenwidth * 0.04),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Gündem Z ',
                                            style: TextStyle(
                                                fontFamily: "Avenir Heavy",
                                                color: Colors.white,
                                                fontSize:
                                                    screenheight * 0.013)),
                                        CircleAvatar(
                                          backgroundColor: Colors.blue,
                                          radius: screenheight * 0.010,
                                          child: new LayoutBuilder(
                                              builder: (context, constraint) {
                                            return new Icon(
                                              Icons.check_circle_outline,
                                              size: constraint.biggest.height,
                                            );
                                          }),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: screenwidth * 0.02),
                                          child: CircleAvatar(
                                            radius: screenheight * 0.006,
                                            backgroundColor: Colors.white,
                                            child: Container(),
                                          ),
                                        ),
                                        Text(
                                          timeAgo,
                                          style: TextStyle(
                                              fontFamily: "Avenir Book",
                                              color: Colors.white,
                                              fontSize: screenheight * 0.013),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      posts[i]['title'],
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontFamily:
                                              "Avenir Next LT Pro Regular",
                                          fontSize: screenheight * 0.02,
                                          color: Colors.white,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
          );
        }
        ;
        return Container();
      },
    );
  }
}

class CustomDotControllerOnBoarding extends StatelessWidget {
  const CustomDotControllerOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return GetBuilder<OnBoardingControllerTmp>(
        builder: (controller) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    onBoardingList.length,
                    (index) => AnimatedContainer(
                          margin: EdgeInsets.only(right: screenwidth * 0.01),
                          duration: const Duration(milliseconds: 900),
                          width: controller.currenPage == index
                              ? screenwidth * 0.10
                              : screenwidth * 0.04,
                          height: screenheight * 0.008,
                          decoration: BoxDecoration(
                              color: controller.currenPage == index
                                  ? AppColor.primaryColor
                                  : Colors.grey[400],
                              borderRadius:
                                  BorderRadius.circular(screenheight * 0.003)),
                        ))
              ],
            ));
  }
}

class AppImageAsset {
  static const String onBoardingImageOne = 'assets/images/3.jpg';
  static const String onBoardingImageTwo = 'assets/images/2.jpg';
  static const String onBoardingImageThree = 'assets/images/1.jpg';
}

class AppColor {
  static const Color grey = Color(0xff8e8e8e);
  static const Color primaryColor = Color(0xff5DB1DF);
}

abstract class OnBoardingCotroller extends GetxController {
  onPageChaged(int index);
}

class OnBoardingControllerTmp extends OnBoardingCotroller {
 
  int currenPage = 0;
  @override
  onPageChaged(int index) {
    currenPage = index;
    update();
  }
}
