import 'package:flutter/material.dart';

class Ilac {
  String ilacAdi;
  String ilacTuru;
  int gunlukKullanimSayisi;
  List<TimeOfDay> kullanilacakSaatler;

  Ilac({
    required this.ilacAdi,
    required this.ilacTuru,
    required this.gunlukKullanimSayisi,
    required this.kullanilacakSaatler,
  });

  factory Ilac.fromJson(Map<String, dynamic> json) {
    List<dynamic> saatler = json['kullanilacakSaatler'];
    List<TimeOfDay> parsedSaatler = [];
    saatler.forEach((saat) {
      parsedSaatler.add(TimeOfDay(hour: saat['hour'], minute: saat['minute']));
    });

    return Ilac(
      ilacAdi: json['ilacAdi'],
      ilacTuru: json['ilacTuru'],
      gunlukKullanimSayisi: json['gunlukKullanimSayisi'],
      kullanilacakSaatler: parsedSaatler,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, int>> saatler = [];
    kullanilacakSaatler.forEach((saat) {
      saatler.add({'hour': saat.hour, 'minute': saat.minute});
    });

    return {
      'ilacAdi': ilacAdi,
      'ilacTuru': ilacTuru,
      'gunlukKullanimSayisi': gunlukKullanimSayisi,
      'kullanilacakSaatler': saatler,
    };
  }
}
