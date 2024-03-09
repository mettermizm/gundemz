import 'package:flutter/material.dart';
import 'package:gundemz/controller/anasayfa_controller.dart';
import 'package:get/get.dart';
import 'package:gundemz/screens/bodyanasayfa.dart';
import 'package:gundemz/webviewscreens/yerelsetcim.dart';
import 'package:gundemz/widgets/appbar.dart';
import 'package:gundemz/widgets/drawer.dart';

class AnasayfaView extends StatefulWidget {
  const AnasayfaView({super.key});

  @override
  State<AnasayfaView> createState() => _AnasayfaViewState();
}

class _AnasayfaViewState extends State<AnasayfaView> with SingleTickerProviderStateMixin {
   final AnasayfaController controller = Get.put(AnasayfaController());
   late final TabController _tabCont;
  @override
  void initState()  {
    //controller.onInit();
  // _startTimer();
    _tabCont = TabController(length: 10, vsync: this);
    super.initState();
  }
  
  @override
  void dispose() {
    _tabCont = TabController(length: 10, vsync: this);
    super.dispose();
  }
  
  //void _startTimer() {
  // _timer = Timer.periodic(Duration(seconds: 3), (timer) {
  //  if ( controller.currentIndex.value  <imageListforHS.length - 1) {
  //    controller.currentIndex.value++;
  // 
  //  } else {
  //  controller.currentIndex.value = 0;}
  //  _carouselController.animateToPage(controller.currentIndex.value);
  // });
  //}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    final AnasayfaController _controller = Get.put(AnasayfaController(),permanent: true);
    
    return Scaffold(
      appBar: appAppBar(context),
       drawer: MenuDrawer(),
      body: SafeArea(
      child:  NestedScrollView(
      headerSliverBuilder: (_, __) {
        return [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: screenheight * 0,
            pinned: true,
            bottom: TabBar(
              tabAlignment: TabAlignment.start,
              indicatorColor: Colors.transparent,
              padding: EdgeInsets.only(
              left: screenWidth * 0.06,
              right: screenWidth * 0.06,
              bottom: screenheight * 0),
              labelPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              controller: _tabCont,
              isScrollable: true,
              unselectedLabelColor: Colors.black26,
              labelStyle: TextStyle(
              fontSize: screenheight * 0.0166,
              overflow: TextOverflow.fade,
              fontWeight: FontWeight.bold,
              ),
              labelColor: Colors.black,
              unselectedLabelStyle: TextStyle(
              fontSize: screenheight * 0.0142,
              fontWeight: FontWeight.normal,
              ),
              tabs: [
                Tab(child: Text('Gündem')),
                Tab(child: Text('Ekonomi')),
                Tab(child: Text('İzmir')),
                Tab(child: Text('Dünya')),
                Tab(child: Text('Spor')),
                Tab(child: Text('Sağlık')),
                Tab(child: Text('Eğitim')),
                Tab(child: Text('Magazin')),
                Tab(child: Text('Teknoloji')),
                Tab(child: Text('Yerel Seçim')),
              ],
            ),
          ),
          sondakika(screenheight, screenWidth, context,_controller),
          // cardWidget(screenWidth, screenheight)
          // tapsondakika(context),
        ];
      },
      body: TabBarView(
        physics: ScrollPhysics(),
        controller:_tabCont,
        children: [
          BodyHomePage(baslik: 'Gündem'),
          BodyHomePage(baslik: 'Ekonomi'),
          BodyHomePage(baslik: 'İzmir'),
          BodyHomePage(baslik: 'Dünya'),
          BodyHomePage(baslik: 'Spor'),
          BodyHomePage(baslik: 'Sağlık'),
          BodyHomePage(baslik: 'Eğitim'),
          BodyHomePage(baslik: 'Magazin'),
          BodyHomePage(baslik: 'Teknoloji'),
          YerelSecim(),
        ],
        ),))
        );
      
  
    // Your existing code;
  }
  
   SliverAppBar sondakika(
    double screenheight,
    double screenWidth,
    BuildContext context,
    AnasayfaController c  ,
    //  AsyncSnapshot<List<dynamic>> snapshot
  ) {
    return 
    
     SliverAppBar(
      collapsedHeight: screenheight * 0.05,
      pinned: true,
      automaticallyImplyLeading: false,
      toolbarHeight: screenheight * 0.05,
      expandedHeight: screenheight * 0.05,
      flexibleSpace:Card(
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
          vertical: 0),
        child:  Container(
          width: screenWidth * 0.94,
          height: screenheight * 0.05,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: screenWidth * 0.05,
                height: screenheight * 0.05,
                child: Icon(
                  Icons.notifications,
                  size: screenheight * 0.025,
                ),
              ),
              Center(
                child: Container(
                  width: screenWidth * 0.22,
                  height: screenheight * 0.05,
                  child: Center(
                    child: Text(
                      " Son Dakika : ",
                      style: TextStyle(
                          fontFamily: "avenir-roman",
                          fontSize: screenheight * 0.0155,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Center(
              child: Container(
              width: screenWidth * 0.52,
              child: c.carouselSliderSonD(screenheight, screenWidth, context,c))),
              Container(
                width: screenWidth * 0.05,
                height: screenheight * 0.05,
                child: Center(
                child: Icon(
                Icons.chevron_right,
                size: screenheight * 0.03),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
