import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gundemz/functions/width_height.dart';
import 'package:gundemz/screens/bodyaramasayfasi.dart';
import 'package:gundemz/scripts/api.dart';
import 'package:gundemz/webviewscreens/yerelsetcim.dart';
import 'package:gundemz/widgets/appbar.dart';
import 'package:gundemz/widgets/drawer.dart';


class TapNested extends StatefulWidget {
  const TapNested({Key? key}) : super(key: key);
  @override
  _TapNestedState createState() => _TapNestedState();
}

class _TapNestedState extends State<TapNested> with SingleTickerProviderStateMixin {

  late final TabController _tabCont;
  @override
  void initState() {
    _tabCont = TabController(length: 10, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appAppBar(context),
      body: SafeArea(child: nestedScrollView(screenwidth, screenheight)),
      drawer: MenuDrawer(),
    );
  }

  NestedScrollView nestedScrollView(double screenWidth, double screenHeight) {
    TextEditingController _searchController = TextEditingController();
    return NestedScrollView(
      headerSliverBuilder: (_, __) {
        return [
          SliverAppBar(
            expandedHeight: screenHeight * 0.16,
            collapsedHeight: screenHeight * 0.16,
            // toolbarHeight: screenHeight * 0.05,
            pinned: true,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              // color: Colors.purple,
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // color: Colors.amber,
                    width: screenWidth * 0.18,
                    height: screenHeight * 0.06,
                    child: Text('Ara',
                        style: TextStyle(
                            fontFamily: "Avenir Heavy",
                            fontSize: screenHeight * 0.047,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    // color: Colors.blue,
                    width: screenWidth * 0.50,
                    height: screenHeight * 0.02,
                    child: Text('Dünyanın dört bir yanından haberler.',
                        style: TextStyle(
                            fontFamily: 'Avenir Book',
                            fontSize: screenHeight * 0.0142)),
                  ),
                  Container(
                    // color: Colors.amber,
                    width: screenWidth * 0.94,
                    height: screenHeight * 0.06,
                    margin: EdgeInsets.only(top: screenHeight * 0.02),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                            // blurStyle: BlurStyle.inner,
                          )
                        ],
                        color: Colors.white.withOpacity(1),
                        borderRadius: BorderRadius.all(Radius.circular(9))),
                    child: TextField(
                      controller:
                          _searchController, // Attach the controller to TextField
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () async {
                            int selectedTabIndex = _tabCont.index;
                            String baslik = 'gündem';
                            String arananDeger = _searchController.text;
                            print("Seçili olan tab index'i: $selectedTabIndex");
                            switch (selectedTabIndex) {
                              case 0:
                              List<dynamic> data =
                              await Api.getSearch(baslik, arananDeger);
                              Get.to(
                              arananDeger.isEmpty ||
                              // ignore: unnecessary_null_comparison
                              arananDeger == null
                              //   data == arananDeger
                              ?  BosSayfa()
                              : BodyAramaSayfasi(
                              baslik: baslik, dataList: data));
                              print(data);
                              break;
                              case 1:
                               baslik = 'ekonomi';
                               List<dynamic> data =
                               await Api.getSearch(baslik, arananDeger);
                                Get.to( arananDeger.isEmpty ||
                                 // ignore: unnecessary_null_comparison
                                 arananDeger == null
                               ? BosSayfa()
                               : BodyAramaSayfasi(
                                 baslik: baslik,
                                 dataList: data,
                                 ),
                                 );
                              
                                break;
                              case 2:
                                baslik = 'izmir';
                                List<dynamic> data =
                                    await Api.getSearch(baslik, arananDeger);
                                Get.to( arananDeger.isEmpty ||
                                 // ignore: unnecessary_null_comparison
                                 arananDeger == null
                                ? BosSayfa()
                                : BodyAramaSayfasi(
                                 baslik: baslik,
                                 dataList: data,
                                 ),
                                 );
                                break;
                              case 3:
                                baslik = 'Dünya';
                                List<dynamic> data =
                                    await Api.getSearch(baslik, arananDeger);
                                Get.to( arananDeger.isEmpty ||
                                 // ignore: unnecessary_null_comparison
                                 arananDeger == null
                               ? BosSayfa()
                               : BodyAramaSayfasi(
                                 baslik: baslik,
                                 dataList: data,
                                 ),
                                 );
                                break;
                              case 4:
                                baslik = 'spor';
                                List<dynamic> data =
                                    await Api.getSearch(baslik, arananDeger);
                                Get.to( arananDeger.isEmpty ||
                                 // ignore: unnecessary_null_comparison
                                 arananDeger == null
                               ? BosSayfa()
                               : BodyAramaSayfasi(
                                 baslik: baslik,
                                 dataList: data,
                                 ),
                                 );
                                break;
                              case 5:
                                baslik = 'sağlık';
                                List<dynamic> data =
                                    await Api.getSearch(baslik, arananDeger);
                                Get.to( arananDeger.isEmpty ||
                                 // ignore: unnecessary_null_comparison
                                 arananDeger == null
                               ? BosSayfa()
                               : BodyAramaSayfasi(
                                 baslik: baslik,
                                 dataList: data,
                                 ),
                                 );
                                break;
                              case 6:
                                baslik = 'magazin';
                                List<dynamic> data =
                                    await Api.getSearch(baslik, arananDeger);
                                Get.to( arananDeger.isEmpty ||
                                 // ignore: unnecessary_null_comparison
                                 arananDeger == null
                               ? BosSayfa()
                               : BodyAramaSayfasi(
                                 baslik: baslik,
                                 dataList: data,
                                 ),
                                 );
                                break;
                              case 7:
                                baslik = 'eğitim';
                                List<dynamic> data =
                                    await Api.getSearch(baslik, arananDeger);
                                Get.to( arananDeger.isEmpty ||
                                 // ignore: unnecessary_null_comparison
                                 arananDeger == null
                               ? BosSayfa()
                               : BodyAramaSayfasi(
                                 baslik: baslik,
                                 dataList: data,
                                 ),
                                 );
                                break;
                              case 8:
                                baslik = 'teknoloji';
                                List<dynamic> data =
                                    await Api.getSearch(baslik, arananDeger);
                                Get.to( arananDeger.isEmpty ||
                                 // ignore: unnecessary_null_comparison
                                 arananDeger == null
                               ? BosSayfa()
                               : BodyAramaSayfasi(
                                 baslik: baslik,
                                 dataList: data,
                                 ),
                                 );
                                break;
                              case 9:
                                baslik = 'yerel seçim';
                                List<dynamic> data =
                                    await Api.getSearch(baslik, arananDeger);
                               Get.to( arananDeger.isEmpty ||
                                 // ignore: unnecessary_null_comparison
                                 arananDeger == null
                               ? BosSayfa()
                               : BodyAramaSayfasi(
                                 baslik: baslik,
                                 dataList: data,
                                 ),
                                 );
                                break;
                              default:
                            }
                            //Api.getSearch(selectedTabIndex,)
                          },
                          icon: Icon(
                            Icons.search,
                            size: screenHeight * 0.035,
                          ),
                        ), // First icon

                        hintText: 'Haber, Konu Başlığı, Kaynak',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: screenHeight * 0.018),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
          ),
          SliverAppBar(
            // backgroundColor: Colors.amber,
            expandedHeight: screenHeight * 0.05,
            toolbarHeight: screenHeight * 0.01,
            automaticallyImplyLeading: false,

            pinned: true,
            bottom: TabBar(
              tabAlignment: TabAlignment.start,
              // indicatorWeight: screenWidth * 0.0,
              // indicatorColor: Colors.amber,
              indicatorSize: TabBarIndicatorSize.tab,
              padding: EdgeInsets.only(
                  left: screenWidth * 0.03,
                  right: screenWidth * 0.03,
                  top: screenHeight * 0),
              // indicatorPadding: EdgeInsets.all(0),
              // labelPadding: EdgeInsets.only(right: 10, left: 10, bottom: 0),
              // labelColor: Colors.black,
              indicator: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue,
              ),
              // indicatorWeight: 2,
              controller: _tabCont,
              isScrollable: true,
              unselectedLabelColor: Colors.black26,
              labelStyle: TextStyle(
                // inherit: true,
                fontSize: screenHeight * 0.0166,
                fontWeight: FontWeight.bold,
                // backgroundColor: Colors.blue
              ),
              labelColor: Colors.white,
              unselectedLabelStyle: TextStyle(
                // fontFamily: 'AndikaNewBasic',
                // wordSpacing: 20,
                // wordSpacing: 50,
                fontSize: screenHeight * 0.0142,
                // backgroundColor: Colors.red,
                fontWeight: FontWeight.normal,
              ),
              tabs: [
                Tab(child: texttapbar('Gündem')),
                Tab(child: texttapbar('Ekonomi')),
                Tab(child: texttapbar('İzmir')),
                Tab(child: texttapbar('Dünya')),
                Tab(child: texttapbar('Spor')),
                Tab(child: texttapbar('Sağlık')),
                Tab(child: texttapbar('Magazin')),
                Tab(child: texttapbar('Eğitim')),
                Tab(child: texttapbar('Teknoloji')),
                Tab(child: Text('Yerel Seçim')),
              ],
            ),
          ),
        ];
      },
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabCont,
        children: [
          BodyAramaSayfasi(baslik: 'Gündem'),
          BodyAramaSayfasi(baslik: 'Ekonomi'),
          BodyAramaSayfasi(baslik: 'İzmir'),
          BodyAramaSayfasi(baslik: 'Dünya'),
          BodyAramaSayfasi(baslik: 'Spor'),
          BodyAramaSayfasi(baslik: 'Sağlık'),
          BodyAramaSayfasi(baslik: 'Magazin'),
          BodyAramaSayfasi(baslik: 'Eğitim'),
          BodyAramaSayfasi(baslik: 'Teknoloji'),
          YerelSecim(),
        ],
      ),
    );
  }
}

texttapbar(String? txt) {
  return Text(
    txt!,
    style: TextStyle(
        // fontFamily: "Avenir Medium",
        ),
  );
}

class AramaSayfasi extends StatefulWidget {
  const AramaSayfasi({super.key});

  @override
  State<AramaSayfasi> createState() => _AramaSayfasiState();
}

class _AramaSayfasiState extends State<AramaSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TapNested(),
      drawer: MenuDrawer(),
    );
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

class BosSayfa extends StatelessWidget {
  const BosSayfa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 50.0, color: Colors.red),
              SizedBox(height: 10.0),
              Text(
                'Sonuç bulunamadı!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: screenHeight(context) * 0.02),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
