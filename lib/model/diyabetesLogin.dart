class Diyabet {
  final int id;
  final String adSoyad;
  final String sifre;
  final String telefon;
  final String cinsiyet;
  final String boy;
  final String kilo;
  final String yas;


  Diyabet({
    required this.id,
    required this.adSoyad,
    required this.sifre,
    required this.telefon,
    required this.cinsiyet,
    required this.boy,
    required this.kilo,
    required this.yas,
  });

  factory Diyabet.fromJson(Map<String, dynamic> json) {
    return Diyabet(
      id: json['id'],
      adSoyad: json['adSoyad'],
      telefon: json['telefon'],
      sifre: json['sifre'],
      cinsiyet:json['cinsiyet'],
      boy:json['boy'],
      kilo: json['kilo'],
      yas:json['yas'],
    );
  }
}
