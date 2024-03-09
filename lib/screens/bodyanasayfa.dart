import 'dart:ui';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gundemz/ad_helper.dart';
import 'package:gundemz/screens/habersayfasi.dart';
import 'package:gundemz/functions/ipcontroller.dart';
import 'package:gundemz/scripts/api.dart';
import 'package:gundemz/variables/linkes.dart';
import 'package:gundemz/widgets/cupertinoactivityindicator.dart';
//import 'package:native_ads_flutter/native_ads.dart';
//import 'package:native_ads_flutter/native_ads.dart';

final List<Map<String, String>> imageListforHS = [];
final List<Map<String, String>> textListforHS = [];
final List<Map<String, String>> networkImageListforHS = [];
final List<Map<String, String>> titleListforHS = [];

// ignore: must_be_immutable
class BodyHomePage extends StatefulWidget {
  String? baslik;
  BodyHomePage({super.key, this.baslik});

  @override
  State<BodyHomePage> createState() => _BodyHomePageState(baslikG: baslik);
}

class _BodyHomePageState extends State<BodyHomePage> {
  String? kurs;
  int? selectedContainerIndex;
  int counter = 0;
  String? baslikG = 'gündem';
  String selectedCurrency = '';
  String selectDEP = '';
  int visibleItemCount = 8;
  ScrollController _scrollController = ScrollController();
  List<dynamic> posts = []; // Yeni bir liste oluşturun
  late AdmobInterstitial interstitialAd;
  late AdmobReward rewardAd;
  _BodyHomePageState({this.baslikG});
  //final _nativeAdController = NativeAdmobController();
  selectContainer(int? index) {
    setState(() {
      selectedContainerIndex = index!;
    });
  }

  void _loadMoreItems() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        visibleItemCount += 8;
      });

      // Show the loading indicator while fetching more posts

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
    //_nativeAdController.reloadAd(forceRefresh: true);
    selectContainer(0);
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
    // _nativeAdController.dispose();
    selectContainer(0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: ValueKey(counter),
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              physics: ScrollPhysics(),
              controller: _scrollController,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(children: [
                      dovizkuru(screenWidth, screenheight),
                      buildFutureBuilder(screenWidth, screenheight),
                    ]),
                  ]),
                ),
              ],
            ),
            BannerCheckIp(),
          ],
        ),
      ),
    );
  }

  FutureBuilder<Map<String, dynamic>> dovizkuru(
      double screenWidth, double screenheight) {
    return FutureBuilder(
      future: kurlar(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasError || snapshot.data == null) {
          return Container();
        } else if (snapshot.hasData) {
          Map<String, dynamic> posts = snapshot.data!;
          return Container(
            margin: EdgeInsets.only(
              left: screenWidth * 0.03,
              right: screenWidth * 0.03,
              top: screenheight * 0.01,
              bottom: screenWidth * 0,
            ),
            width: screenWidth * 0.94,
            height: screenheight * 0.20,
            child: Card(
              margin: EdgeInsets.zero,
              child: Stack(children: [
                Positioned(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: screenWidth * 0.94,
                          height: screenheight * 0.20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                Colors.black.withOpacity(0.37),
                                BlendMode.darken,
                              ),
                              image: AssetImage('assets/images/1.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: screenWidth * 0.36,
                          height: screenheight * 0.09,
                          margin: EdgeInsets.only(
                            left: screenWidth * 0.02,
                            top: screenheight * 0.02,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: AutoSizeText(
                                  textAlign: TextAlign.center,
                                  selectDEP == '' ? 'Dolar Kuru' : selectDEP,
                                  minFontSize: 0,
                                  style: TextStyle(
                                    fontFamily: "Avenir Book",
                                    color: Colors.white,
                                    fontSize: screenheight * 0.014,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                  selectedCurrency == ''
                                      ? '\$ ${posts['dolar']}'
                                      : selectedCurrency,
                                  minFontSize: 0,
                                  style: TextStyle(
                                    fontFamily: "Avenir Book",
                                    color: Colors.white,
                                    fontSize: screenheight * 0.031,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Container()),
                          Expanded(
                            flex: 35,
                            child: Container(
                              height: screenheight * 0.07,
                              margin: EdgeInsets.only(
                                top: screenheight * 0.11,
                                bottom: screenheight * 0.0010,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Colors.black.withOpacity(0.95),
                                shape: BoxShape.rectangle,
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 70),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectContainer(0);
                                            selectDEP = 'Dolar Kuru';
                                            selectedCurrency =
                                                '\$ ${posts['dolar']}';
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.01,
                                            vertical: screenheight * 0.005,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: selectedContainerIndex == 0
                                                ? Color(0xFF131B1F)
                                                : Colors.transparent,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(child: Container()),
                                              Expanded(
                                                flex: 6,
                                                child: new LayoutBuilder(
                                                  builder:
                                                      (context, constraint) {
                                                    return new Icon(
                                                      Icons.attach_money,
                                                      size: constraint
                                                          .biggest.height,
                                                      color: Colors.white,
                                                    );
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                  'Dolar',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: "Avenir Medium",
                                                    fontSize:
                                                        screenheight * 0.013,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(child: Container()),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectContainer(1);
                                            selectDEP = 'Euro Kuru';
                                            selectedCurrency =
                                                '€ ${posts['euro']}';
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.01,
                                            vertical: screenheight * 0.005,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: selectedContainerIndex == 1
                                                ? Color(0xFF131B1F)
                                                : Colors.transparent,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(child: Container()),
                                              Expanded(
                                                flex: 6,
                                                child: new LayoutBuilder(
                                                  builder:
                                                      (context, constraint) {
                                                    return new Icon(
                                                      Icons.euro,
                                                      size: constraint
                                                          .biggest.height,
                                                      color: Colors.white,
                                                    );
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                  'Euro',
                                                  style: TextStyle(
                                                    fontFamily: "Avenir Medium",
                                                    fontSize:
                                                        screenheight * 0.013,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(child: Container()),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectContainer(2);
                                            selectDEP = 'Pound Kuru';
                                            selectedCurrency =
                                                '£ ${posts['sterling']}';
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.01,
                                            vertical: screenheight * 0.005,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: selectedContainerIndex == 2
                                                ? Color(0xFF131B1F)
                                                : Colors.transparent,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(child: Container()),
                                              Expanded(
                                                flex: 6,
                                                child: new LayoutBuilder(
                                                  builder:
                                                      (context, constraint) {
                                                    return new Icon(
                                                      Icons.currency_pound,
                                                      size: constraint
                                                          .biggest.height,
                                                      color: Colors.white,
                                                    );
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                  'Pound',
                                                  style: TextStyle(
                                                    fontFamily: "Avenir Medium",
                                                    fontSize:
                                                        screenheight * 0.013,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(child: Container()),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
        }
        return Container();
      },
    );
  }

  Future<Map<String, dynamic>> kurlar() async {
    final currencyService = CurrencyService();
    final kurlar = await currencyService.fetchAndCacheKurData();
    return kurlar;
  }

  cardWidget(double screenWidth, double screenheight) {
    return SliverAppBar(
      collapsedHeight: screenheight * 0.20,
      floating: true, // Üst taraftaki widget kayar
      pinned: false, // Üst taraftaki widget en üstte sabit kalmaz
      snap: true,
      automaticallyImplyLeading: false,
      toolbarHeight: screenheight * 0.20,
      expandedHeight: screenheight * 0.20,
      flexibleSpace: FutureBuilder(
        future: kurlar(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasError || snapshot.data == null) {
            return IndicatorApp(radius: 10);
          } else if (snapshot.hasData) {
            Map<String, dynamic> posts = snapshot.data!;
            return Container(
              margin: EdgeInsets.only(
                left: screenWidth * 0.03,
                right: screenWidth * 0.03,
                top: screenheight * 0.01,
                bottom: screenWidth * 0,
              ),
              width: screenWidth * 0.94,
              height: screenheight * 0.20,
              child: Card(
                margin: EdgeInsets.zero,
                child: Stack(children: [
                  Positioned(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: screenWidth * 0.94,
                            height: screenheight * 0.20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.37),
                                  BlendMode.darken,
                                ),
                                image: AssetImage('assets/images/1.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: screenWidth * 0.36,
                            height: screenheight * 0.09,
                            margin: EdgeInsets.only(
                              left: screenWidth * 0.02,
                              top: screenheight * 0.02,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    textAlign: TextAlign.center,
                                    selectDEP == '' ? 'Dolar Kuru' : selectDEP,
                                    minFontSize: 0,
                                    style: TextStyle(
                                      fontFamily: "Avenir Book",
                                      color: Colors.white,
                                      fontSize: screenheight * 0.014,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: AutoSizeText(
                                    selectedCurrency == ''
                                        ? '\$ ${posts['dolar']}'
                                        : selectedCurrency,
                                    minFontSize: 0,
                                    style: TextStyle(
                                      fontFamily: "Avenir Book",
                                      color: Colors.white,
                                      fontSize: screenheight * 0.031,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Container()),
                            Expanded(
                              flex: 35,
                              child: Container(
                                height: screenheight * 0.07,
                                margin: EdgeInsets.only(
                                  top: screenheight * 0.11,
                                  bottom: screenheight * 0.0010,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  color: Colors.black.withOpacity(0.95),
                                  shape: BoxShape.rectangle,
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 70),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectContainer(0);
                                              selectDEP = 'Dolar Kuru';
                                              selectedCurrency =
                                                  '\$ ${posts['dolar']}';
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.01,
                                              vertical: screenheight * 0.005,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: selectedContainerIndex == 0
                                                  ? Color(0xFF131B1F)
                                                  : Colors.transparent,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(child: Container()),
                                                Expanded(
                                                  flex: 6,
                                                  child: new LayoutBuilder(
                                                    builder:
                                                        (context, constraint) {
                                                      return new Icon(
                                                        Icons.attach_money,
                                                        size: constraint
                                                            .biggest.height,
                                                        color: Colors.white,
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: Text(
                                                    'Dolar',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Avenir Medium",
                                                      fontSize:
                                                          screenheight * 0.013,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(child: Container()),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectContainer(1);
                                              selectDEP = 'Euro Kuru';
                                              selectedCurrency =
                                                  '€ ${posts['euro']}';
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.01,
                                              vertical: screenheight * 0.005,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: selectedContainerIndex == 1
                                                  ? Color(0xFF131B1F)
                                                  : Colors.transparent,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(child: Container()),
                                                Expanded(
                                                  flex: 6,
                                                  child: new LayoutBuilder(
                                                    builder:
                                                        (context, constraint) {
                                                      return new Icon(
                                                        Icons.euro,
                                                        size: constraint
                                                            .biggest.height,
                                                        color: Colors.white,
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: Text(
                                                    'Euro',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Avenir Medium",
                                                      fontSize:
                                                          screenheight * 0.013,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(child: Container()),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectContainer(2);
                                              selectDEP = 'Pound Kuru';
                                              selectedCurrency =
                                                  '£ ${posts['sterling']}';
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.01,
                                              vertical: screenheight * 0.005,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: selectedContainerIndex == 2
                                                  ? Color(0xFF131B1F)
                                                  : Colors.transparent,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(child: Container()),
                                                Expanded(
                                                  flex: 6,
                                                  child: new LayoutBuilder(
                                                    builder:
                                                        (context, constraint) {
                                                      return new Icon(
                                                        Icons.currency_pound,
                                                        size: constraint
                                                            .biggest.height,
                                                        color: Colors.white,
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: Text(
                                                    'Pound',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Avenir Medium",
                                                      fontSize:
                                                          screenheight * 0.013,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(child: Container()),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget buildFutureBuilder(double screenWidth, double screenheight) {
    return FutureBuilder<List<dynamic>>(
      future: Api.getPosts(baslikG ?? 'gündem', uzunluk: visibleItemCount),
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
                          //   physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: screenheight * 0.36,
                          ),
                          itemCount: posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> post = posts[index];
                            String text = post['title'];
                            Map<String, String> yeniMap = {"text": text};
                            imageListforHS.add(yeniMap);
                            String title = post['baslik'];
                            Map<String, String> yeniMap3 = {"baslik": title};
                            titleListforHS.add(yeniMap3);
                            String image = post["attachments"][0] ?? logoAdress;
                            Map<String, String> yeniMap2 = {
                              "attachments": image
                            };
                            networkImageListforHS.add(yeniMap2);

                            String content = '${post['content']}...';
                            Map<String, String> yeniMap1 = {"content": content};
                            textListforHS.add(yeniMap1);
                            List<String> words = content.split(' ');
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
                               Get.to(() => HaberSayfasi(
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
                                width: screenWidth * 0.44,
                                margin: EdgeInsets.only(
                                  bottom: screenheight * 0.01,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: screenheight * 0.14,
                                      width: screenWidth * 0.44,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                        ),
                                        image: DecorationImage(
                                          colorFilter: new ColorFilter.mode(
                                              Colors.black.withOpacity(0.25),
                                              BlendMode.darken),
                                          image: CachedNetworkImageProvider(
                                              posts[index]["attachments"]
                                                          ?.isNotEmpty ==
                                                      true
                                                  ? posts[index]["attachments"]
                                                      [0]
                                                  : logoAdress),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: screenheight * 0.20,
                                      width: screenWidth * 0.38,
                                      margin: EdgeInsets.only(
                                        top: screenheight * 0.01,
                                        left: screenWidth * 0.03,
                                        right: screenWidth * 0.03,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              posts[index]['baslik'] ?? 'hata',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      "BebasNeue-Regular",
                                                  fontSize:
                                                      screenheight * 0.015,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              posts[index]["title"] ?? 'hata',
                                              maxLines: 3,
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      screenheight * 0.018,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(shortContent,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontSize:
                                                        screenheight * 0.009)),
                                          ),
                                          Expanded(
                                            child: Text(timeAgo,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontSize:
                                                        screenheight * 0.012,
                                                    color: Colors.red)),
                                          ),
                                        ],
                                      ),
                                    )
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
                Positioned(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              width: screenWidth * 0.26,
                              height: screenheight * 0.055,
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    counter++;
                                  });
                                },
                                child: Text(
                                  'En Yeni',
                                  style: TextStyle(
                                    fontFamily: "Avenir Medium",
                                    color: Colors.black,
                                    fontSize: screenheight * 0.016,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
}
