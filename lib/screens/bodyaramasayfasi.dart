import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gundemz/ad_helper.dart';
import 'package:gundemz/screens/habersayfasi.dart';
import 'package:gundemz/scripts/api.dart';
import 'package:gundemz/variables/linkes.dart';
import 'package:gundemz/widgets/cupertinoactivityindicator.dart';
import 'package:gundemz/functions/ipcontroller.dart';


final List<Map<String, String>> imageList = [];
final List<Map<String, String>> textList = [];
final List<Map<String, String>> networkImageList = [];
final List<Map<String, String>> titleList = [];

// ignore: must_be_immutable
class BodyAramaSayfasi extends StatefulWidget {
  String? baslik;
  List<dynamic>? dataList;
  BodyAramaSayfasi({super.key, this.baslik, this.dataList});

  @override
  State<BodyAramaSayfasi> createState() =>
      _BodyAramaSayfasiState(baslikG: baslik);
}

class _BodyAramaSayfasiState extends State<BodyAramaSayfasi> {

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
  _BodyAramaSayfasiState({this.baslikG});
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
    //  _nativeAdController.dispose();
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
                      //  dovizkuru(screenWidth, screenheight),
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
                            // interstitialAd.show();
                            //    rewardAd.show();
                            //    Navigator.push(
                            //      context,
                            //      MaterialPageRoute(
                            //        builder: (context) => Deneme(
                            //          baslik: posts[index]['baslik'],
                            //          title: posts[index]["title"] ?? 'hata',
                            //          content: post['content'],
                            //          category: posts[index]['baslik'],
                            //          time: timeAgo,
                            //          imgUrl: posts[index]["attachments"]
                            //                      ?.isNotEmpty ==
                            //                  true
                            //              ? posts[index]["attachments"][0]
                            //              : loadImage,
                            //        ),
                            //      ),
                            //    );
                               // RewardIp() ;
                              InterstitialAdControll(context,interstitialAd).constroctorclass(context,interstitialAd);                             
                             Get.to( HaberSayfasi(
                                      baslik: posts[index]['baslik'],
                                      title: posts[index]["title"] ?? 'hata',
                                      content: post['content'],
                                      category: posts[index]['baslik'],
                                      time: timeAgo,
                                      imgUrl: posts[index]["attachments"]
                                                  ?.isNotEmpty == true
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
}




