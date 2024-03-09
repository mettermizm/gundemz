import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gundemz/ad_helper.dart';
import 'package:gundemz/functions/ipcontroller.dart';
import 'package:gundemz/scripts/api.dart';
import 'package:gundemz/variables/linkes.dart';
import 'package:gundemz/widgets/cupertinoactivityindicator.dart';

final List<Map<String, String>> imageList = [];
final List<Map<String, String>> textList = [];
final List<Map<String, String>> networkImageList = [];
final List<Map<String, String>> titleList = [];

// ignore: must_be_immutable
class HaberSayfasi extends StatefulWidget {
  String? baslik;
  HaberSayfasi(
      {super.key,
      this.baslik,
      this.title,
      this.content,
      this.category,
      this.time,
      this.imgUrl});
  String? title;
  String? content;
  String? category;
  String? time;
  String? imgUrl;

  @override
  State<HaberSayfasi> createState() => _HaberSayfasiState(baslikG: baslik);
}

class _HaberSayfasiState extends State<HaberSayfasi> {
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
  _HaberSayfasiState({this.baslikG});
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
    // _nativeAdController.reloadAd(forceRefresh: true);
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
    //_nativeAdController.dispose();
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
        child: Container(
          child: Stack(
            children: [
              CustomScrollView(
                //   physics: NeverScrollableScrollPhysics(),
                controller: _scrollController,
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Column(
                        children: [
                          Column(
                            children: [
                              Stack(
                                children: [
                                  backgrounnimage(
                                      context,
                                      screenWidth,
                                      screenheight,
                                      widget.imgUrl ?? logoAdress),
                                  backIcon(context, screenWidth, screenheight),
                                  titlecontainer(
                                      context,
                                      screenWidth,
                                      screenheight,
                                      widget.category ?? 'bos',
                                      widget.title ?? 'bos',
                                      widget.time ?? 'bos'),
                                  textTitleLogo(screenWidth, screenheight),
                                  bodycontant(context, screenWidth,
                                      screenheight, widget.content ?? 'bos'),
                                  // admobBanner(context),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Column(children: [
                        buildFutureBuilder(screenWidth, screenheight),
                      ]),
                    ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Positioned textTitleLogo(double screenWidth, double screenheight) {
    return Positioned(
      child: Container(
        width: screenWidth,
        height: screenheight * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.white,
        ),
        margin: EdgeInsets.only(top: screenheight * 0.34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                    left: screenWidth * 0.06, top: screenheight * 0.02),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Container(
                      width: screenWidth * 0.23,
                      height: screenheight * 0.03,
                      // color: Colors.blue,
                      child: Text(
                        'Gündemz',
                        style: TextStyle(
                            fontFamily: "Avenir Heavy",
                            fontSize: screenheight * 0.022),
                      ),
                    ),
                    Container(
                      // color: Colors.amber,
                      width: screenWidth * 0.07,
                      height: screenheight * 0.03,
                      // color: Colors.amber,
                      child: Icon(
                        Icons.new_releases_sharp,
                        color: Colors.blue,
                        size: screenheight * 0.025,
                      ),
                    )
                  ],
                ),
                // color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> kurlar() async {
    final currencyService = CurrencyService();
    final kurlar = await currencyService.fetchAndCacheKurData();
    return kurlar;
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
                          physics: NeverScrollableScrollPhysics(),
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

  bodycontant(
      context, double screenwidth, double screenheight, String content) {
    return Padding(
      padding: EdgeInsets.only(top: screenheight * 0.40),
      child: Container(
        width: screenwidth,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                left: screenwidth * 0.06,
                right: screenwidth * 0.06,
                top: screenwidth * 0.01),
            child: Text(
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: screenheight * 0.0166,
                // fontFamily: "Avenir Book",
              ),
              content,
            ),
          ),
        ),
      ),
    );
    //       ),
    //     ),
    //   ),
    // );
  }

  Positioned titlecontainer(context, double screenwidth, double screenheight,
      String category, String title, String time) {
    return Positioned(
      child: Column(
        children: [
          Container(
            // color: Colors.amber,
            width: screenwidth * 0.85,
            height: screenheight * 0.17,
            margin: EdgeInsets.only(
              top: screenheight * 0.14,
              left: screenwidth * 0.04,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                      ),
                      width: screenwidth * 0.20,
                      height: screenheight * 0.05,
                      child: Center(
                          child: Text(
                        category,
                        style: TextStyle(
                            // fontFamily: "Avenir Heavy",
                            color: Colors.white,
                            fontSize: screenheight * 0.0155),
                      )),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(top: screenheight * 0.01),
                      width: screenwidth * 0.85,
                      height: screenheight * 0.07,
                      // color: Colors.red,
                      child: Text(
                        title,
                        style: TextStyle(
                            fontFamily: "Avenir Next LT Pro Regular",
                            fontSize: screenheight * 0.025,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // color: Colors.blue,
                      width: screenwidth * 0.50,
                      height: screenheight * 0.02,
                      margin: EdgeInsets.only(top: screenheight * 0.02),
                      child: Row(
                        children: [
                          Text(
                            'Trend  ',
                            style: TextStyle(
                                fontFamily: "Avenir Book",
                                color: Colors.white,
                                fontSize: screenheight * 0.0142),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: screenwidth * 0.015),
                            child: CircleAvatar(
                              radius: screenheight * 0.005,
                              backgroundColor: Colors.white,
                              child: Container(),
                            ),
                          ),
                          Text(
                            '   $time',
                            style: TextStyle(
                                fontFamily: "Avenir Book",
                                color: Colors.white,
                                fontSize: screenheight * 0.0142),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Positioned backIcon(context, double screenwidth, double screenheight) {
    return Positioned(
      child: Column(
        children: [
          Container(
            // color: Colors.amber,
            width: screenwidth * 0.085,
            height: screenheight * 0.07,
            margin: EdgeInsets.only(
                top: screenheight * 0.04, left: screenwidth * 0.05),
            child: Column(
              children: [
                Expanded(
                  child: CircleAvatar(
                      // radius: screenheight * 0.9,
                      backgroundColor: Color.fromARGB(250, 250, 250, 250),
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                         //   Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: screenheight * 0.030,
                          ))
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Positioned backgrounnimage(
      context, double screenwidth, double screenheight, String imgUrl) {
    return Positioned(
      // left: 0,
      // top: 0,
      // right: 0,
      // bottom: ,
      child: Column(
        children: [
          Container(
            width: screenwidth,
            height: screenheight * 0.5,
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              fit: BoxFit.fill,
              color: Colors.black.withOpacity(0.40),
              colorBlendMode: BlendMode.darken,
              height: 350,
            ),
          ),
        ],
      ),
    );
  }
}
