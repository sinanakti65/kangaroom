import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kangaroom/theme.dart';

class BoyKilo extends StatefulWidget {
  @override
  _BoyKiloState createState() => _BoyKiloState();
}

class _BoyKiloState extends State<BoyKilo> {
  @override
  void initState() {
    super.initState();
    // Buraya initState'de yapılacak işlemleri ekleyebilirsiniz.
    print("BoyKilo initState çağrıldı");
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
          'Boy/Kilo',
          style: titleTextStyle,
        ),
        centerTitle: true, // Başlığı ortalar
      ),
      body: Center(
        child: Container(
          color: primaryColor100, // Arka plan rengini mavi yapar
          child: Text(
            'Boy Kilo',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
