import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gundemz/functions/width_height.dart';
import 'package:gundemz/variables/linkes.dart';

class Hakkimizda extends StatelessWidget {
  const Hakkimizda({super.key});

  @override
  Widget build(BuildContext context) {
    String url =logoAdress;
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
                    'HAKKIMIZDA',
                    style: TextStyle(
                      fontSize: screenHeight(context) * 0.03,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: screenHeight(context) * 0.007,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: screenHeight(context) * 0.03,
                    bottom: screenHeight(context) * 0.07,
                    left: screenWidth(context) * 0.05,
                    right: screenWidth(context) * 0.05,
                  ),
                  child: Center(
                    child: Text(
                      '''GÜNDEM Z: YENİLİKÇİ HABER PLATFORMU GÜNDEM Z, MODERN VE YENİLİKÇİ YAKLAŞIMIYLA HABER DÜNYASINA İDDİALI BİR GİRİŞ YAPMIŞ BİR HABER SİTESİDİR. OKUYUCULARA GÜVENİLİR, TARAFSIZ VE KAPSAMLI HABER İÇERİKLERİ SUNARAK, ONLARIN GÜNCEL OLAYLARI YAKINDAN TAKİP ETMELERİNİ SAĞLAMAYI HEDEFLEMEKTEDİR. İNTERNET ÇAĞINDA HIZLA DEĞİŞEN HABER TÜKETİM ALIŞKANLIKLARINA UYUM SAĞLAYARAK, HABERLERİ DAHA ANLAŞILIR VE ETKİLİ BİR ŞEKİLDE SUNMA KONUSUNDA ÖNCÜ BİR ROL ÜSTLENİR. YENİLİKÇİ İÇERİKLER VE GÖRSEL TASARIM: GÜNDEM Z, HABER SUNUMUNDA İÇERİK KALİTESİNE VE ESTETİK TASARIMA BÜYÜK ÖNEM VERİR. GÖRSEL AÇIDAN ZENGİNLEŞTİRİLMİŞ HABERLERLE, OKUYUCULARIN İLGİSİNİ ÇEKMEYİ VE HABERE DAİR DETAYLARI DAHA ETKİLİ BİR ŞEKİLDE AKTARMAYI AMAÇLAR. KULLANICI DOSTU ARAYÜZÜ SAYESİNDE, OKUYUCULARIN HABERLERE KOLAYCA ERİŞEBİLMESİ VE İSTEDİKLERİ BİLGİLERE HIZLICA ULAŞABİLMESİ SAĞLANIR. TARAFSIZ HABERCİLİK İLKESİ: GÜNDEM Z, HABER SUNUMUNDA TARAFSIZLIK İLKESİNE BAĞLIDIR. HABERLER, OBJEKTİF BİR BAKIŞ AÇISIYLA AKTARILIRKEN, OLAYLARIN FARKLI YÖNLERİ DİKKATE ALINARAK ANALİZ EDİLİR. OKUYUCULARIN HABERLERİ TARAFSIZ BİR PLATFORMDAN EDİNDİKLERİ GÜVEN DUYGUSU, SİTEYE OLAN BAĞLILIĞI ARTTIRIR. ÇEŞİTLİLİK VE KAPSAYICILIK: SİTE, GENİŞ BİR KONU YELPAZESİNİ KAPSAYAN HABER İÇERİKLERİ SUNAR. SİYASİ, EKONOMİK, SOSYAL, KÜLTÜREL VE BİLİMSEL KONULARI ELE ALAN MAKALELER, OKUYUCULARIN FARKLI İLGİ ALANLARINA HİTAP EDER. ÇEŞİTLİLİK SAYESİNDE, ZİYARETÇİLERİN FARKLI PERSPEKTİFLERDEN HABERLERİ TAKİP EDEBİLMESİ VE KENDİLERİNİ GELİŞTİREBİLMESİ DESTEKLENİR. HIZLI VE GÜVENİLİR HABERLER: GÜNDEM Z, GÜNCEL HABERLERE HIZLI BİR ŞEKİLDE ULAŞMAYI SAĞLAYARAK OKUYUCULARIN OLAYLARI AN BE AN TAKİP ETMELERİNİ KOLAYLAŞTIRIR. HABER KAYNAKLARINDAN DOĞRULANMIŞ BİLGİLERE DAYANAN İÇERİKLER, HABERİN GÜVENİLİRLİĞİNİ VE DOĞRULUĞUNU ARTTIRIR. TOPLUMLA ETKİLEŞİM: GÜNDEM Z, OKUYUCULARIYLA ETKİLEŞİMİ TEŞVİK EDER. YORUM VE GERİ BİLDİRİMLERİN ÖNEMSENDİĞİ SİTE, OKUYUCULARIN DÜŞÜNCELERİNİ PAYLAŞMASINA OLANAK TANIR. BU SAYEDE, HABERLER VE İÇERİKLER DAHA ZENGİN VE ÇEŞİTLİ BİR PERSPEKTİFLE ELE ALINIR. SONUÇ OLARAK, GÜNDEM Z, MODERN VE YENİLİKÇİ HABERCİLİK ANLAYIŞIYLA OKUYUCULARIN GÜNCEL GELİŞMELERİ KOLAYLIKLA TAKİP ETMELERİNİ SAĞLAYAN ÖNEMLİ BİR HABER PLATFORMUDUR. TARAFSIZLIK, GÜVENİLİRLİK VE ÇEŞİTLİLİK İLKESİYLE DONATILAN SİTE, HABER DÜNYASINDA ÖNEMLİ BİR OYUNCU OLARAK DİKKAT ÇEKMEKTEDİR.''',
                      style: TextStyle(fontSize: screenHeight(context) * 0.010),
                    ),
                  ),
                ),
              ],
            ),
          ),
         // AdmobBannerIp(),
        ],
      )),
    );
  }
}
