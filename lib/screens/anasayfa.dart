//import 'package:flutter/material.dart';
//import 'package:gundemz/widgets/appbar.dart';
//import 'package:gundemz/widgets/drawer.dart';
//import 'dart:async';
//import 'dart:ui';
//import 'package:admob_flutter/admob_flutter.dart';
//import 'package:auto_size_text/auto_size_text.dart';
//import 'package:carousel_slider/carousel_slider.dart';
//import 'package:gundemz/ad_helper.dart';
//import 'package:gundemz/screens/habersayfasi.dart';
//import 'package:gundemz/functions/ipcontroller.dart';
//import 'package:gundemz/scripts/api.dart';
//import 'package:gundemz/webviewscreens/yerelsetcim.dart';
//import 'package:gundemz/widgets/cupertinoactivityindicator.dart';
//import 'bodyanasayfa.dart';
//
//class Anasayfa extends StatefulWidget {
//  const Anasayfa({super.key});
//  @override
//  State<Anasayfa> createState() => _AnasayfaState();
//}
//
//class _AnasayfaState extends State<Anasayfa> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: appAppBar(context),
//      body: SafeArea(child: TapNestedScrollView()),
//      drawer: MenuDrawer(),
//    );
//  }
//}
//
//class TapNestedScrollView extends StatefulWidget {
//  const TapNestedScrollView({Key? key}) : super(key: key);
//  @override
//  _TapNestedScrollViewState createState() => _TapNestedScrollViewState();
//}
//
//class _TapNestedScrollViewState extends State<TapNestedScrollView>
//  with SingleTickerProviderStateMixin {
//  int? selectedContainerIndex;
//  late final TabController _tabCont;
//  int _currentIndex = 0;
//  String selectedCurrency = '';
//  String selectDEP = '';
//  final CarouselController _carouselController = CarouselController();
//  late Timer _timer;
//  late AdmobInterstitial interstitialAd;
//
//  selectContainer(int? index) {
//    setState(() {
//      selectedContainerIndex = index!;
//    });
//  }
//
//  @override
//  void initState() {
//    interstitialAd = AdmobInterstitial(
//      adUnitId: AdHelper.interstitialAdUnitId!,
//      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
//        if (event == AdmobAdEvent.closed) interstitialAd.load();},
//    );
//    interstitialAd.load();
//    _tabCont = TabController(length: 10, vsync: this);
//    _startTimer();
//    selectContainer(0);
//    super.initState();
//  }

//  @override
//  void dispose() {
//    _timer.cancel();
//    _tabCont = TabController(length: 10, vsync: this);
//    selectContainer(0);
//    interstitialAd.dispose();
//    super.dispose();
//  }

//  void _startTimer() {
//    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
//      if (_currentIndex < imageListforHS.length - 1) {
//        _currentIndex++;
//      } else {
//        _currentIndex = 0;
//      }
//      _carouselController.animateToPage(_currentIndex);
//    });
//  }

//  @override
//  Widget build(BuildContext context) {
//    double screenWidth = MediaQuery.of(context).size.width;
//    double screenheight = MediaQuery.of(context).size.height;
//
//    return Scaffold(
//      body: nestedScrollView(screenWidth, screenheight, context),
//    );
//  }

//  NestedScrollView nestedScrollView(
//      double screenWidth, double screenheight, BuildContext context) {
//    return NestedScrollView(
//      headerSliverBuilder: (_, __) {
//        return [
//          SliverAppBar(
//            automaticallyImplyLeading: false,
//            toolbarHeight: screenheight * 0,
//            pinned: true,
//            bottom: TabBar(
//              tabAlignment: TabAlignment.start,
//              indicatorColor: Colors.transparent,
//              padding: EdgeInsets.only(
//                  left: screenWidth * 0.06,
//                  right: screenWidth * 0.06,
//                  bottom: screenheight * 0),
//              labelPadding:
//                  EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
//              controller: _tabCont,
//              isScrollable: true,
//              unselectedLabelColor: Colors.black26,
//              labelStyle: TextStyle(
//                fontSize: screenheight * 0.0166,
//                overflow: TextOverflow.fade,
//                fontWeight: FontWeight.bold,
//              ),
//              labelColor: Colors.black,
//              unselectedLabelStyle: TextStyle(
//                fontSize: screenheight * 0.0142,
//                fontWeight: FontWeight.normal,
//              ),
//              tabs: [
//                Tab(child: Text('Gündem')),
//                Tab(child: Text('Ekonomi')),
//                Tab(child: Text('İzmir')),
//                Tab(child: Text('Dünya')),
//                Tab(child: Text('Spor')),
//                Tab(child: Text('Sağlık')),
//                Tab(child: Text('Eğitim')),
//                Tab(child: Text('Magazin')),
//                Tab(child: Text('Teknoloji')),
//                Tab(child: Text('Yerel Seçim')),
//              ],
//            ),
//          ),
//          sondakika(screenheight, screenWidth, context),
//          // cardWidget(screenWidth, screenheight)
//          // tapsondakika(context),
//        ];
//      },
//      body: TabBarView(
//        physics: ScrollPhysics(),
//        controller: _tabCont,
//        children: [
//          BodyHomePage(baslik: 'Gündem'),
//          BodyHomePage(baslik: 'Ekonomi'),
//          BodyHomePage(baslik: 'İzmir'),
//          BodyHomePage(baslik: 'Dünya'),
//          BodyHomePage(baslik: 'Spor'),
//          BodyHomePage(baslik: 'Sağlık'),
//          BodyHomePage(baslik: 'Eğitim'),
//          BodyHomePage(baslik: 'Magazin'),
//          BodyHomePage(baslik: 'Teknoloji'),
//          YerelSecim(),
//        ],
//      ),
//    );
//  }
//
//  SliverAppBar sondakika(
//    double screenheight,
//    double screenWidth,
//    BuildContext context,
//    //  AsyncSnapshot<List<dynamic>> snapshot
//  ) {
//    return SliverAppBar(
//      collapsedHeight: screenheight * 0.05,
//      pinned: true,
//      automaticallyImplyLeading: false,
//      toolbarHeight: screenheight * 0.05,
//      expandedHeight: screenheight * 0.05,
//      flexibleSpace: Card(
//        margin: EdgeInsets.symmetric(
//          horizontal: screenWidth * 0.03,
//          vertical: 0,
//        ),
//        child: Container(
//          width: screenWidth * 0.94,
//          height: screenheight * 0.05,
//          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//          decoration: BoxDecoration(
//              color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
//          child: Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.center,
//            mainAxisSize: MainAxisSize.max,
//            children: [
//              Container(
//                width: screenWidth * 0.05,
//                height: screenheight * 0.05,
//                child: Icon(
//                  Icons.notifications,
//                  size: screenheight * 0.025,
//                ),
//              ),
//              Center(
//                child: Container(
//                  width: screenWidth * 0.22,
//                  height: screenheight * 0.05,
//                  child: Center(
//                    child: Text(
//                      " Son Dakika : ",
//                      style: TextStyle(
//                          fontFamily: "avenir-roman",
//                          fontSize: screenheight * 0.0155,
//                          color: Colors.black,
//                          fontWeight: FontWeight.bold),
//                    ),
//                  ),
//                ),
//              ),
//              Center(
//                child: Container(
//                    width: screenWidth * 0.52,
//                    child: CarouselSlider(
//                      carouselController: _carouselController,
//                      items: imageListforHS.map((item) {
//                        return GestureDetector(
//                          onTap: () {
//                          InterstitialAdControll(context,interstitialAd).constroctorclass(context,interstitialAd); 
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) => HaberSayfasi(
//                                title: imageListforHS[_currentIndex]["text"]!,
//                                content: textListforHS[_currentIndex]
//                                    ["content"]!,
//                                imgUrl: networkImageListforHS[_currentIndex]
//                                    ["attachments"]!,
//                                category: titleListforHS[_currentIndex]
//                                    ["baslik"]!,
//                                time: '',
//                              ),
//                            ),
//                          );
//                          },
//                          child: Container(
//                            height: screenheight * 0.025,
//                            alignment: Alignment.center,
//                            child: ListView.builder(
//                              itemCount: 1,
//                              itemBuilder: (context, index) {
//                                return imageListforHS[_currentIndex]["text"]
//                                            ?.isNotEmpty ??
//                                        false
//                                    ? Text(
//                                        imageListforHS[_currentIndex]["text"]!,
//                                        maxLines: 1,
//                                        style: TextStyle(
//                                          fontSize: screenheight * 0.016,
//                                          fontWeight: FontWeight.bold,
//                                          color: Colors.red,
//                                        ),
//                                        overflow: TextOverflow.ellipsis,
//                                      )
//                                    : IndicatorApp(radius: 8);
//                              },
//                            ),
//                          ),
//                        );
//                      }).toList(),
//                      options: CarouselOptions(
//                        viewportFraction: 1,
//                        autoPlayInterval: Duration(seconds: 15),
//                        autoPlayAnimationDuration: Duration(milliseconds: 900),
//                        scrollDirection: Axis.vertical,
//                        onPageChanged: (index, reason) {
//                          setState(() {
//                            _currentIndex = index;
//                          });
//                        },
//                      ),
//                    )),
//              ),
//              Container(
//                width: screenWidth * 0.05,
//                height: screenheight * 0.05,
//                child: Center(
//                  child: Icon(
//                    Icons.chevron_right,
//                    size: screenheight * 0.03,
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//

//  Future<Map<String, dynamic>> kurlar() async {
//    final currencyService = CurrencyService();
//    final kurlar = await currencyService.fetchAndCacheKurData();
//    return kurlar;
//  }
//

//  SliverAppBar cardWidget(double screenWidth, double screenheight) {
//    return SliverAppBar(
//      collapsedHeight: screenheight * 0.20,
//      floating: true, // Üst taraftaki widget kayar
//      pinned: false, // Üst taraftaki widget en üstte sabit kalmaz
//      snap: true,
//      automaticallyImplyLeading: false,
//      toolbarHeight: screenheight * 0.20,
//      expandedHeight: screenheight * 0.20,
//      flexibleSpace: FutureBuilder(
//        future: kurlar(),
//        builder: (BuildContext context,
//            AsyncSnapshot<Map<String, dynamic>> snapshot) {
//          if (snapshot.hasError || snapshot.data == null) {
//            return IndicatorApp(radius: 10);
//          } else if (snapshot.hasData) {
//            Map<String, dynamic> posts = snapshot.data!;
//            return Container(
//              margin: EdgeInsets.only(
//                left: screenWidth * 0.03,
//                right: screenWidth * 0.03,
//                top: screenheight * 0.01,
//                bottom: screenWidth * 0,
//              ),
//              width: screenWidth * 0.94,
//              height: screenheight * 0.20,
//              child: Card(
//                margin: EdgeInsets.zero,
//                child: Stack(children: [
//                  Positioned(
//                    child: Column(
//                      children: [
//                        Expanded(
//                          child: Container(
//                            width: screenWidth * 0.94,
//                            height: screenheight * 0.20,
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(10.0),
//                              image: DecorationImage(
//                                colorFilter: new ColorFilter.mode(
//                                  Colors.black.withOpacity(0.37),
//                                  BlendMode.darken,
//                                ),
//                                image: AssetImage('assets/images/1.jpg'),
//                                fit: BoxFit.cover,
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                  Positioned(
//                    child: Row(
//                      children: [
//                        Expanded(
//                          child: Container(
//                            width: screenWidth * 0.36,
//                            height: screenheight * 0.09,
//                            margin: EdgeInsets.only(
//                              left: screenWidth * 0.02,
//                              top: screenheight * 0.02,
//                            ),
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: [
//                                Expanded(
//                                  flex: 1,
//                                  child: AutoSizeText(
//                                    textAlign: TextAlign.center,
//                                    selectDEP == '' ? 'Dolar Kuru' : selectDEP,
//                                    minFontSize: 0,
//                                    style: TextStyle(
//                                      fontFamily: "Avenir Book",
//                                      color: Colors.white,
//                                      fontSize: screenheight * 0.014,
//                                      overflow: TextOverflow.fade,
//                                    ),
//                                  ),
//                                ),
//                                Expanded(
//                                  flex: 2,
//                                  child: AutoSizeText(
//                                    selectedCurrency == ''
//                                        ? '\$ ${posts['dolar']}'
//                                        : selectedCurrency,
//                                    minFontSize: 0,
//                                    style: TextStyle(
//                                      fontFamily: "Avenir Book",
//                                      color: Colors.white,
//                                      fontSize: screenheight * 0.031,
//                                      overflow: TextOverflow.fade,
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                  Positioned(
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: [
//                        Row(
//                          children: [
//                            Expanded(child: Container()),
//                            Expanded(
//                              flex: 35,
//                              child: Container(
//                                height: screenheight * 0.07,
//                                margin: EdgeInsets.only(
//                                  top: screenheight * 0.11,
//                                  bottom: screenheight * 0.0010,
//                                ),
//                                decoration: BoxDecoration(
//                                  borderRadius:
//                                      BorderRadius.all(Radius.circular(12)),
//                                  color: Colors.black.withOpacity(0.95),
//                                  shape: BoxShape.rectangle,
//                                ),
//                                clipBehavior: Clip.hardEdge,
//                                child: BackdropFilter(
//                                  filter:
//                                      ImageFilter.blur(sigmaX: 10, sigmaY: 70),
//                                  child: Row(
//                                    children: [
//                                      Expanded(
//                                        child: GestureDetector(
//                                          onTap: () {
//                                            setState(() {
//                                              selectContainer(0);
//                                              selectDEP = 'Dolar Kuru';
//                                              selectedCurrency =
//                                                  '\$ ${posts['dolar']}';
//                                            });
//                                          },
//                                          child: Container(
//                                            margin: EdgeInsets.symmetric(
//                                              horizontal: screenWidth * 0.01,
//                                              vertical: screenheight * 0.005,
//                                            ),
//                                            decoration: BoxDecoration(
//                                              borderRadius:
//                                                  BorderRadius.circular(12),
//                                              color: selectedContainerIndex == 0
//                                                  ? Color(0xFF131B1F)
//                                                  : Colors.transparent,
//                                            ),
//                                            child: Column(
//                                              crossAxisAlignment:
//                                                  CrossAxisAlignment.center,
//                                              mainAxisAlignment:
//                                                  MainAxisAlignment.center,
//                                              children: [
//                                                Expanded(child: Container()),
//                                                Expanded(
//                                                  flex: 6,
//                                                  child: new LayoutBuilder(
//                                                    builder:
//                                                        (context, constraint) {
//                                                      return new Icon(
//                                                        Icons.attach_money,
//                                                        size: constraint
//                                                            .biggest.height,
//                                                        color: Colors.white,
//                                                      );
//                                                    },
//                                                  ),
//                                                ),
//                                                Expanded(
//                                                  flex: 5,
//                                                  child: Text(
//                                                    'Dolar',
//                                                    textAlign: TextAlign.center,
//                                                    style: TextStyle(
//                                                      fontFamily:
//                                                          "Avenir Medium",
//                                                      fontSize:
//                                                          screenheight * 0.013,
//                                                      color: Colors.white,
//                                                    ),
//                                                  ),
//                                                ),
//                                                Expanded(child: Container()),
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                      Expanded(
//                                        child: GestureDetector(
//                                          onTap: () {
//                                            setState(() {
//                                              selectContainer(1);
//                                              selectDEP = 'Euro Kuru';
//                                              selectedCurrency =
//                                                  '€ ${posts['euro']}';
//                                            });
//                                          },
//                                          child: Container(
//                                            margin: EdgeInsets.symmetric(
//                                              horizontal: screenWidth * 0.01,
//                                              vertical: screenheight * 0.005,
//                                            ),
//                                            decoration: BoxDecoration(
//                                              borderRadius:
//                                                  BorderRadius.circular(12),
//                                              color: selectedContainerIndex == 1
//                                                  ? Color(0xFF131B1F)
//                                                  : Colors.transparent,
//                                            ),
//                                            child: Column(
//                                              crossAxisAlignment:
//                                                  CrossAxisAlignment.center,
//                                              mainAxisAlignment:
//                                                  MainAxisAlignment.center,
//                                              children: [
//                                                Expanded(child: Container()),
//                                                Expanded(
//                                                  flex: 6,
//                                                  child: new LayoutBuilder(
//                                                    builder:
//                                                        (context, constraint) {
//                                                      return new Icon(
//                                                        Icons.euro,
//                                                        size: constraint
//                                                            .biggest.height,
//                                                        color: Colors.white,
//                                                      );
//                                                    },
//                                                  ),
//                                                ),
//                                                Expanded(
//                                                  flex: 5,
//                                                  child: Text(
//                                                    'Euro',
//                                                    style: TextStyle(
//                                                      fontFamily:
//                                                          "Avenir Medium",
//                                                      fontSize:
//                                                          screenheight * 0.013,
//                                                      color: Colors.white,
//                                                    ),
//                                                  ),
//                                                ),
//                                                Expanded(child: Container()),
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                      Expanded(
//                                        child: GestureDetector(
//                                          onTap: () {
//                                            setState(() {
//                                              selectContainer(2);
//                                              selectDEP = 'Pound Kuru';
//                                              selectedCurrency =
//                                              '£ ${posts['sterling']}';
//                                            });
//                                          },
//                                          child: Container(
//                                            margin: EdgeInsets.symmetric(
//                                              horizontal: screenWidth * 0.01,
//                                              vertical: screenheight * 0.005,
//                                            ),
//                                            decoration: BoxDecoration(
//                                              borderRadius:
//                                                  BorderRadius.circular(12),
//                                              color: selectedContainerIndex == 2
//                                                  ? Color(0xFF131B1F)
//                                                  : Colors.transparent,
//                                            ),
//                                            child: Column(
//                                              crossAxisAlignment:
//                                                  CrossAxisAlignment.center,
//                                              mainAxisAlignment:
//                                                  MainAxisAlignment.center,
//                                              children: [
//                                                Expanded(child: Container()),
//                                                Expanded(
//                                                  flex: 6,
//                                                  child: new LayoutBuilder(
//                                                    builder:
//                                                        (context, constraint) {
//                                                      return new Icon(
//                                                        Icons.currency_pound,
//                                                        size: constraint
//                                                            .biggest.height,
//                                                        color: Colors.white,
//                                                      );
//                                                    },
//                                                  ),
//                                                ),
//                                                Expanded(
//                                                  flex: 5,
//                                                  child: Text(
//                                                    'Pound',
//                                                    style: TextStyle(
//                                                      fontFamily:
//                                                          "Avenir Medium",
//                                                      fontSize:
//                                                          screenheight * 0.013,
//                                                      color: Colors.white,
//                                                    ),
//                                                  ),
//                                                ),
//                                                Expanded(child: Container()),
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ),
//                            ),
//                            Expanded(child: Container()),
//                          ],
//                        ),
//                      ],
//                    ),
//                  ),
//                ]),
//              ),
//            );
//          }
//          return Container();
//        },
//      ),
//    );
//  }
//}
