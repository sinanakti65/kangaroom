import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kangaroom/theme.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  void initState() {
    super.initState();
    // Buraya initState'de yapılacak işlemleri ekleyebilirsiniz.
    print("Profil initState çağrıldı");
    _loadPaymentData();
  }

  Future<void> _loadPaymentData() async {
    // Ödeme verilerini yüklemek için kullanılacak asenkron fonksiyon
    try {
      // Ödeme verilerini yüklemek için kod buraya gelecek
      print("Ödeme verileri yükleniyor...");
      // Örneğin, bir dosyadan veri okuyabilirsiniz veya bir API çağrısı yapabilirsiniz
    } catch (e) {
      print("Ödeme verilerini yüklerken hata: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor500,
        iconTheme: IconThemeData(
          color: Colors.white, // Geri dönüş okunun rengini beyaz yapar
        ),
        title: Text(
          'Profil',
          style: titleTextStyle,
        ),
        centerTitle: true, // Başlığı ortalar
      ),
      body: Center(
        child: Container(
          color: primaryColor100, // Arka plan rengini mavi yapar
          child: Text(
            'Profil',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
