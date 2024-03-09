import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

List<dynamic> results = [];
var httpClient = http.Client();

class CurrencyService {
  static const String _kurlarKey = 'kurlar';

  Future<Map<String, dynamic>> fetchAndCacheKurData() async {
    final prefs = await SharedPreferences.getInstance();

    // Önbellekte kurları kontrol et
    final cachedKurData = prefs.getString(_kurlarKey);

    if (cachedKurData != null) {
      final cachedKurMap = json.decode(cachedKurData);
      return Map<String, dynamic>.from(cachedKurMap);
    } else {
      // Kurları çek
      final fetchedKurData = await Api.kurData();

      // Kurları önbelleğe al
      prefs.setString(_kurlarKey, json.encode(fetchedKurData));

      return fetchedKurData;
    }
  }
}

class Api {
  static Future<Map<String, dynamic>> kurData() async {
    final response = await httpClient
        .get(Uri.parse('https://hasanadiguzel.com.tr/api/kurgetir'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      double dolar = data['TCMB_AnlikKurBilgileri'][0]['ForexSelling'];
      double euro = data['TCMB_AnlikKurBilgileri'][3]['ForexSelling'];
      double sterling = data['TCMB_AnlikKurBilgileri'][4]['ForexSelling'];
      Map<String, dynamic> kurlar = {
        "dolar": "$dolar",
        "euro": "$euro",
        "sterling": "$sterling",
      };
      return kurlar;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<dynamic>> getPosts(String baslik,
      {String? baslik2, int? uzunluk}) async {
    String url = baslik2 != null
        ? 'https://gundemz.com/mobileapp/?baslik=$baslik,$baslik2&nerdenbaslasin=21'
        : uzunluk != null
        ? 'https://gundemz.com/mobileapp/?baslik=$baslik&uzunluk=$uzunluk'
        : 'https://gundemz.com/mobileapp/?baslik=$baslik';
    try {
      final response = await httpClient.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic>? res = json.decode(response.body);
      //  print(res);
        if (res != null) {
          List<dynamic>? results = res['results'];
          if (results != null) {
            return results;
          }
        }
      }
      throw Exception('Failed to load data');
    } catch (e) {
      // Handle the error (log, show a message, etc.)
      print('Error fetching data: $e');
      // Return a meaningful result or an empty list
      return [];
    }
  }

  static Future<List<dynamic>> getPostsForKesfet(List basliks) async {
    String url =
        'https://gundemz.com/mobileapp/?baslik=${basliks[0]},${basliks[1]}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> res = json.decode(response.body);
      results = res['results'];
     // print('$results');
      return results;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<dynamic>> getSearch(String baslik, String arananDeger,
      {String? baslik2, int? uzunluk}) async {
    // print('$arananDeger   arananDeger');
    // Sonuç listesi boş olarak başlatılır.
    String url =
    'https://gundemz.com/mobileapp/?baslik=$baslik&aranandeger=$arananDeger';
    // String url = baslik2 != null
    //     ? 'https://gundemz.com/mobileapp/?baslik=$baslik,$baslik2&nerdenbaslasin=21'
    //     : uzunluk != null
    //         ? 'https://gundemz.com/mobileapp/?baslik=$baslik&uzunluk=$uzunluk'
    //         : 'https://gundemz.com/mobileapp/?baslik=$baslik';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> res = json.decode(response.body);
      results = res['results'];
      // ignore: unnecessary_null_comparison
      if (results != null) {
      //  print(results[0]['title']);
        return results;
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
