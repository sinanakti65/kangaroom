import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:kangaroom/all_import.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  Map<String, dynamic> _users = {};
  double yildizsabah = 0.9999;
  double yildizogle = 0.5;
  double yildizikindi = 0.25;
  int duygu = 1;
  String Not = "Mehmet Ali'nin bugün yüzü asıktı.";
  List<String> ogrenciler = ["Mehmet Ali","yunus","sinan","selika"];
  String? _selectedOgrenci;
  String gelenMesaj =
      "Merhaba Sayın Veli acilen buraya gelmeniz gerekiyor.Mehmet Ali ile ilgili birkaç problem oluştu.";
  String gonderilenMesaj = "";
  List<String> imagePaths = [];
  TextEditingController _gonderilenMesajtext = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedOgrenci = ogrenciler.isNotEmpty ? ogrenciler[0] : null;
    _loadImages();
    // _loadUserData();
  }

  Future<void> _loadImages() async {
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      final imagePathsList = manifestMap.keys
          .where((String key) => key.startsWith('assets/images/'))
          .toList();

      setState(() {
        imagePaths = imagePathsList.isNotEmpty
            ? imagePathsList
            : ['assets/images/foto1.jpg'];
      });
    } catch (e) {
      setState(() {
        imagePaths = ['assets/images/foto1.jpg'];
      });
    }
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/login.json');
  }

  Future<void> _loadUserData() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      setState(() {
        _users = jsonDecode(contents);
        print("_loadUserData() çalışıyor...$_users");
      });
      print('_loadUserData() tamamlandı...');
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment(-0.15,0),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
          ),
          child: DropdownButton<String>(
            value: _selectedOgrenci,
            dropdownColor: primaryColor500,
            iconEnabledColor: Colors.white,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 20,
            ),
            onChanged: (String? newValue) {
              setState(() {
                _selectedOgrenci = newValue;
              });
            },
            items: ogrenciler.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor500,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),

      drawer: FractionallySizedBox(
        widthFactor: 0.40,
        child: Drawer(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: primaryColor500,
                ),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Menü',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      backgroundColor: primaryColor500,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Ana Sayfa'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person_pin_outlined),
                      title: Text('Profil'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profil()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.local_post_office_outlined),
                      title: Text('Kurumsal'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Kurumsal()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Ayarlar'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Ayarlar()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/icon/mis.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildEmotionBox(duygu, Not),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: lightBlue300, // Arka plan rengini mavi olarak ayarlar
                  borderRadius: BorderRadius.circular(10), // İsteğe bağlı: köşeleri yuvarlamak için
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTimeBox('Sabah Kahvaltısı', yildizsabah),
                    _buildTimeBox('Öğle Yemeği', yildizogle),
                    _buildTimeBox('İkindi Atıştırmalık', yildizikindi),
                  ],
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(height: 200.0, autoPlay: true),
              items: imagePaths.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      child: Image.asset(imagePath, fit: BoxFit.cover),
                    );
                  },
                );
              }).toList(),
            ),
            Container(
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (gelenMesaj.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                        color: primaryColor300, // Kare arka plan rengi
                        borderRadius:
                        BorderRadius.circular(10), // Kare kenar yuvarlama
                      ),
                      child: Text(
                        gelenMesaj,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  if (gonderilenMesaj.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange, // Kare arka plan rengi
                        borderRadius:
                        BorderRadius.circular(10), // Kare kenar yuvarlama
                      ),
                      child: Text(
                        gonderilenMesaj,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height:40,// Boyutunu burada ayarlayabilirsiniz
                        child: TextFormField(
                          controller: _gonderilenMesajtext,
                          decoration: InputDecoration(
                            hintText: "Mesajınızı Yazın", // hintText olarak değiştirildi
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            gonderilenMesaj = _gonderilenMesajtext.text;
                            _gonderilenMesajtext.clear();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Mesaj Gönderildi"),
                              duration: Duration(seconds: 1),
                              backgroundColor: primaryColor300,
                            ),
                          );
                        },
                        child: Text("Gönder"),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildMenuItem('Zil', 'zil.png', context),
                _buildMenuItem('Aidat', 'wallet.png', context),
                _buildMenuItem('Boy/Kilo', 'weight.png', context),
                _buildMenuItem('Yoklama', 'check.png', context),
                _buildMenuItem('Ders Programı', 'book.png', context),
                _buildMenuItem('Duyurular', 'promotion.png', context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmotionBox(int emotion, String note) {
    IconData icon;
    Color color;

    switch (emotion) {
      case 0:
        icon = Icons.sentiment_very_dissatisfied;
        color = Colors.red;
        break;
      case 1:
        icon = Icons.sentiment_neutral;
        color = Colors.orange;
        break;
      case 2:
        icon = Icons.sentiment_very_satisfied;
        color = Colors.green;
        break;
      default:
        icon = Icons.sentiment_neutral;
        color = Colors.grey;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        // color:primaryColor300,
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Icon(icon, color: color, size: 48),
          Text(
            'Duygu Durumu',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color:primaryColor300),
          ),
          SizedBox(height: 8),
          Text(
            note,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color:primaryColor300),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBox(String time, double starCount) {

    return Container(
      decoration: BoxDecoration(
        color: lightBlue300,
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            time,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Container(
            width: 40,
            height: 40,
            child: CustomPaint(
              painter: PieChartPainter(starCount),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, String iconName, BuildContext context) {
    return InkWell(
      onTap: () {
        if (title == 'Zil') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Zil()),
          );
        }

        if (title == 'Ödeme') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentPage()),
          );
        }

        if (title == 'Boy/Kilo') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BoyKilo()),
          );
        }

        if (title == 'Devamsızlık') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Devamsizlik()),
          );
        }

        if (title == 'Ders Programı') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DersProgrami()),
          );
        }

        if (title == 'Duyurular') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Duyurular()),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icon/$iconName',
            width: 64,
            height: 64,
            fit: BoxFit.contain,
            color: primaryColor300,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final double completePart;

  PieChartPainter(this.completePart);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    final completePath = Path();
    completePath.arcTo(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -90 * 3.14159265358979323846 / 180.0,
      360 * completePart * 3.14159265358979323846 / 180.0,
      false,
    );
    paint.color = Colors.yellow;
    canvas.drawPath(completePath, paint);

    final remainingPath = Path();
    remainingPath.arcTo(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -90 * 3.14159265358979323846 / 180.0 + 360 * completePart * 3.14159265358979323846 / 180.0,
      360 * (1 - completePart) * 3.14159265358979323846 / 180.0,
      false,
    );
    paint.color = Colors.grey;
    canvas.drawPath(remainingPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
