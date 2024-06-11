class Kanmodel {
  final int id;
  final String adSoyad;
  final String telefon;
  final String yas;
  final double kan;
  final DateTime tarih;


  Kanmodel({
    required this.id,
    required this.adSoyad,
    required this.telefon,
    required this.yas,
    required this.kan,
    required this.tarih,


  });

  factory Kanmodel.fromJson(Map<String, dynamic> json) {
    return Kanmodel(
      id: json['id'],
      adSoyad: json['adSoyad'],
      telefon: json['telefon'],
      yas:json['yas'],
      kan:json['kan'],
      tarih:json['tarih'],
    );
  }
}
