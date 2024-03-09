import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gundemz/functions/width_height.dart';
import 'package:gundemz/variables/linkes.dart';


class Kunye extends StatelessWidget {
  const Kunye({super.key});

  @override
  Widget build(BuildContext context) {
    String url =
        logoAdress;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      width: screenWidth(context) * 0.90,
                      height: screenHeight(context) * 0.08,
                      child: CachedNetworkImage(imageUrl: url)),
                  Container(
                    child: Text(
                      'KÜNYE',
                      style: TextStyle(
                        fontSize: screenHeight(context) * 0.03,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        letterSpacing: screenHeight(context) * 0.007,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: screenWidth(context) * 0.7,
                      margin: EdgeInsets.symmetric(
                          horizontal: screenWidth(context) * 0.03,
                          vertical: screenHeight(context) * 0.02),
                      child: Center(
                        child: Column(
                          children: [
                            kunyetext(context, 'Yayın Türü ', FontWeight.bold),
                            kunyetext(context, 'Bölgesel Süreli Aylık ',
                                FontWeight.bold),
                            sizedbox(context),
                            kunyetext(
                                context, 'İmtiyaz Sahibi ', FontWeight.bold),
                            kunyetext(context, 'Kollekt Medya Organizasyon ',
                                FontWeight.bold),
                            kunyetext(
                                context,
                                'Sanayi Ticaret Limited Şirketi ',
                                FontWeight.bold),
                            sizedbox(context),
                            kunyetext(context, 'Genel Yayın Yönetmeni ',
                                FontWeight.bold),
                            kunyetext(
                                context, 'Sibel Özdemir ', FontWeight.bold),
                            sizedbox(context),
                            kunyetext(context, 'Sorumlu ', FontWeight.bold),
                            kunyetext(context, 'Yazı İşleri Müdürü ',
                                FontWeight.bold),
                            kunyetext(
                                context, 'Hatice Nur Yavaş ', FontWeight.bold),
                            kunyetext(
                                context, 'Reklam İletişim ', FontWeight.bold),
                            kunyetext(context, 'info@gundemz.com ',
                                FontWeight.normal),
                            kunyetext(context, '0(532) 379 31 73 ',
                                FontWeight.normal),
                            sizedbox(context),
                            kunyetext(context, 'Basım Yeri ', FontWeight.bold),
                            kunyetext(context, 'İhlas Gazetecilik A.Ş ',
                                FontWeight.bold),
                            kunyetext(context, 'Fatih Mahallesi 1199 Sk. ',
                                FontWeight.bold),
                            kunyetext(context, ' No:1/7 Sarnıç - Gaziemir ',
                                FontWeight.bold),
                            kunyetext(context, 'İZMİR ', FontWeight.bold),
                            kunyetext(context, 'Tel: 0232 257 67 32 ',
                                FontWeight.normal),
                            sizedbox(context),
                            kunyetext(
                                context, 'Yönetim Yeri ', FontWeight.bold),
                            kunyetext(context, 'Çınarlı Mah. 1572 Sk. No:33 ',
                                FontWeight.bold),
                            kunyetext(
                                context, 'Konak / İZMİR ', FontWeight.bold),
                            SizedBox(
                              height: screenHeight(context) * 0.07,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
           // AdmobBannerIp(),
          ],
        ),
      ),
    );
  }

  SizedBox sizedbox(BuildContext context) =>
      SizedBox(height: screenHeight(context) * 0.01);

  Text kunyetext(BuildContext context, String txt, FontWeight fontWeight) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: screenHeight(context) * 0.02,
        fontWeight: fontWeight,
        // color: Colors.grey,
      ),
      textAlign: TextAlign.center,
    );
  }
}
