class YemekVerisi {
  final String secilenOgun;
  final String secilenKategori;
  final String secilenYuzde;
  final String secilenYiyecek;
  final String toplam;

  final DateTime tarih;

  YemekVerisi({
    required this.secilenOgun,
    required this.secilenKategori,
    required this.secilenYuzde,
    required this.secilenYiyecek,
    required this.toplam,
    required this.tarih,
  });

  Map<String, dynamic> toJson() {
    return {
      'secilenOgun': secilenOgun,
      'secilenKategori': secilenKategori,
      'secilenYuzde': secilenYuzde,
      'secilenYiyecek': secilenYiyecek,
      'toplam':toplam,
      'tarih': tarih.toIso8601String(),
    };
  }

  factory YemekVerisi.fromJson(Map<String, dynamic> json) {
    return YemekVerisi(
      secilenOgun: json['secilenOgun'],
      secilenKategori: json['secilenKategori'],
      secilenYuzde: json['secilenYuzde'],
      secilenYiyecek: json['secilenYiyecek'],
      toplam: json['toplam'],
      tarih: DateTime.parse(json['tarih']),
    );
  }
}
