class AnasayfaModel {
  String dolar;
  String euro;
  String sterling;

  AnasayfaModel({required this.dolar, required this.euro, required this.sterling});

  factory AnasayfaModel.fromJson(Map<String, dynamic> json) {
    return AnasayfaModel(
      dolar: json['dolar'] ?? '',
      euro: json['euro'] ?? '',
      sterling: json['sterling'] ?? '',
    );
  }
}
