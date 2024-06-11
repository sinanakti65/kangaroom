import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Renk sabitleri
const Color primaryColor100 = Color(0xffbcdaff); // Açık mavi
const Color primaryColor300 = Color(0xFF28235D); // Koyu mavi
const Color primaryColor500 = Color(0xFFEE6A68); // Kırmızı (AppBar için)
const Color colorWhite = Colors.white; // Beyaz arka plan
const Color backgroundColor = Color(0xffF5F9FF); // Açık mavi arka plan
const Color lightBlue100 = Color(0xff1463ae); // Çok açık mavi
const Color lightBlue300 = Color(0xff009daf); // Açık mavi
const Color lightBlue400 = Color(0xffBFC8D2); // Açık gri mavi
const Color darkBlue300 = Color(0xff526983); // Orta koyulukta mavi
const Color darkBlue500 = Color(0xff293948); // Koyu mavi
const Color darkBlue700 = Color(0xff17212B); // Çok koyu mavi

const double borderRadiusSize = 16.0; // Kenar yuvarlaklığı boyutu

// Metin stilleri
TextStyle greetingTextStyle = GoogleFonts.poppins(
    fontSize: 24, fontWeight: FontWeight.w700, color: darkBlue500); // Selamlama metin stili

TextStyle titleTextStyle = GoogleFonts.poppins(
    fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white); // Başlık metin stili

TextStyle subTitleTextStyle = GoogleFonts.poppins(
    fontSize: 16, fontWeight: FontWeight.w500, color: darkBlue500); // Alt başlık metin stili

TextStyle normalTextStyle = GoogleFonts.poppins(
    color: darkBlue500 // Normal metin stili
);

TextStyle descTextStyle = GoogleFonts.poppins(
    fontSize: 14, fontWeight: FontWeight.w400, color: darkBlue300); // Açıklama metin stili

TextStyle descTextStyle2 = GoogleFonts.poppins(
    fontSize: 20, fontWeight: FontWeight.w400, color: darkBlue300); // Büyük açıklama metin stili

TextStyle addressTextStyle = GoogleFonts.poppins(
    fontSize: 14, fontWeight: FontWeight.w400, color: darkBlue300); // Adres metin stili

TextStyle facilityTextStyle = GoogleFonts.poppins(
    fontSize: 13, fontWeight: FontWeight.w500, color: darkBlue300); // Tesis metin stili

TextStyle priceTextStyle = GoogleFonts.poppins(
    fontSize: 16, fontWeight: FontWeight.w700, color: darkBlue500); // Fiyat metin stili

TextStyle buttonTextStyle = GoogleFonts.poppins(
    fontSize: 16, fontWeight: FontWeight.w600, color: colorWhite); // Buton metin stili

TextStyle bottomNavTextStyle = GoogleFonts.poppins(
    fontSize: 12, fontWeight: FontWeight.w500, color: primaryColor500); // Alt navigasyon metin stili

TextStyle tabBarTextStyle = GoogleFonts.poppins(
    fontWeight: FontWeight.w500, color: primaryColor500); // Sekme çubuğu metin stili

// Belirli bir renkten MaterialColor oluşturma fonksiyonu
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05]; // Güç seviyeleri listesi
  Map<int, Color> swatch = {}; // Renk tonları haritası
  final int r = color.red, g = color.green, b = color.blue; // Renk bileşenleri

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i); // Güç seviyelerini 0.1 artışlarla ekleme
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength; // Güç seviyesi farkı
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    ); // Her güç seviyesi için renk tonu oluşturma
  }
  return MaterialColor(color.value, swatch); // Oluşturulan MaterialColor'ı döndürme
}
