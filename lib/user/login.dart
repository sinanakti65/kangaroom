import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../../models/diyabetesLogin.dart';
import '../../theme.dart';
import '../homescreen/homescreen.dart';
import 'newuser.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Map<String, dynamic> _users = {};
  late   String _username;
  late    String _password;
  late String formattedDateTime;
  List<Diyabet> newuser = [];
  List<int> sorulacak = [];
  List<int> sorulmayacak = [];
  List<double> kansekeri = [];
  List<int> adimsayisi = [];



  @override
  void initState() {
    super.initState();
    _loadUserData();
    fetchData();
    _writeRozetData();
    formattedDateTime =
    "${DateTime.now().year}-${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}-${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}";

  }

  @override
  void dispose() {
    super.dispose();

  }

  Future<void> fetchData() async {
    try {
      final DiyabetResponse = await http.get(Uri.parse(
          'https://wux32a4eyri33ujw2j47p6uvli0fblto.lambda-url.us-east-1.on.aws/api/DiyabetesLogin'));

      if (DiyabetResponse.statusCode == 200) {
        setState(() {
          newuser = (jsonDecode(DiyabetResponse.body) as List)
              .map((e) => Diyabet.fromJson(e))
              .toList();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bağlantı Kuruludu...'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Sunucuyla iletişim kurarken bir hata oluştu...\n lütfen internet bağlantınızı kontrol ediniz.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }



  Future<File> _updateLoginJson(Map<String, dynamic> newUser) async {
    final file = await _localFile;

    try {
      // Yeni kullanıcı bilgilerini login.json dosyasına kaydet
      print("yazma işlemi başladı*****************************************");
      await file.writeAsString(json.encode(newUser));

      // Başarılı güncelleme bildirimi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kullanıcı bilgileri başarıyla doğrulandı...!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigator ile ekranı değiştir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AnaSayfa()),
      );
    } catch (e) {
      print(e);
      // Hata durumunda bildirim
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kullanıcı bilgileri doğrulanırken bir hata oluştu!'),
          backgroundColor: Colors.red,
        ),
      );
    }

    // Dosyayı döndür
    return file;
  }




  void _searchData() async {
    print(_username);
    print(_password);


    List<Diyabet> login = newuser
        .where((loginn) =>
    loginn.telefon.compareTo(_username)==0 &&loginn.sifre.compareTo(_password)==0)
        .toList();

    if(login.isNotEmpty){
      print("eşleşme bulundu******************************************");

      String selectedCinsiyet=login[0].cinsiyet;
      String selectedAvatar="";

        if(selectedCinsiyet.compareTo("Erkek")==0){
          selectedAvatar='assets/avatars/man/man1/';
        }


      if(selectedCinsiyet.compareTo("Kadın")==0){
        selectedAvatar='assets/avatars/woman/woman1/';
      }

      Map<String, dynamic> newUser = {
        //json datasına da verileri de gönder

        "avatar": selectedAvatar,
        "telefon": login[0].telefon,
        "id": login[0].id,
        "adSoyad": login[0].adSoyad,
        "sifre": login[0].sifre,
        "cinsiyet": login[0].cinsiyet,
        "boy": login[0].boy,
        "kilo": login[0].kilo,
        "yas": login[0].yas,
        "login": 1,

      };


      _updateLoginJson(newUser);




    }
    else{
      print("kullanıcı bulunamdaı liste boş");
      print(newuser);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kullanıcı bilgileri doğrulanamadı!'),
          backgroundColor: Colors.red,
        ),
      );
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

      // Dosyadaki verileri yazdır
      print('_loadUserData() tamamlandı...');

    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }


  Future<File> get _localFile2 async {
    final path = await _localPath2;
    return File('$path/rozet.json');
  }

  Future<String> get _localPath2 async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<void> _writeRozetData() async {
    try {
      final file = await _localFile2;

      // Eğer dosya yoksa, oluştur
      if (!(await file.exists())) {
        await file.create(recursive: true);
      }

      // Rozet verilerini JSON formatına çevir
      Map<String, dynamic> rozetData = {
        'rozet1': 0,
        'rozet1kontrol': 1,
        'rozet2': 0,
        'rozet2kontrol': 1,
        'rozet3': 0,
        'rozet3kontrol': 1,
        'rozet4': 0,
        'rozet4kontrol': 1,
        'rozet5': 0,
        'rozet5kontrol': 1,
        'rozet6': 0,
        'rozet6kontrol': 1,
        'puan': 0,
        'puan2':100,
        'hedefadim': 5000,
        'atilanadim':0,
        'sorulacak':sorulacak,
        'sorulmayacak':sorulmayacak,
        'kansekeri':kansekeri,
        'kankontrol':1,
        'adimsayisi':adimsayisi,
        'tarih': DateTime.now().toIso8601String(),
        'tarihgün': DateTime.now().toIso8601String(),
        'bilgikontrol':1,
      };

      // JSON formatına çevrilen verileri dosyaya ekle
      String jsonData = jsonEncode(rozetData);
      await file.writeAsString(jsonData);
    } catch (e) {
      print('Dosyaya yazılırken hata oluştu: $e');
    }
  }


  void _authenticateUser() {
    print("******_authenticateUser çalışıyor...");
    print("************pasword****$_password");
    print("************username****$_username");


    if (_username == null || _username.isEmpty)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen telefon numaranızı girin:('),
          backgroundColor: Colors.orange,
        ),
      );
    }
    else if (_username.length!=10)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen telefon numaranızı 10 hane girin:('),
          backgroundColor: Colors.orange,
        ),
      );
    }
    else if (_password == null || _password.isEmpty)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen şifrenizi girin:('),
          backgroundColor: Colors.orange,
        ),
      );
    }

    else if ((_users["sifre"].compareTo(_password)==0) &&(_users["telefon"].compareTo(_username)==0) ) {
      print("kullanıcı doğrulandı...");


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kullanıcı Bilgileri Doğrulandı:)'),
          backgroundColor: Colors.green,
        ),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kullanıcı bilgileri doğrulanamadı:('),
          backgroundColor: Colors.red,
        ),
      );

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor500, // Arka plan rengi beyaz
        elevation: 0, // Gerekirse gölgeyi kaldır
        centerTitle: true, // Başlığı ortala
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30), // Oval şekil
          ),
        ),
        title: const Text(
          'Giriş Yap',
          style: TextStyle(color: Colors.white), // Başlık rengi beyaz
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300, // Fotoğrafın yüksekliği
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icon/wal.png'),
                ),
              ),
            ),
            SizedBox(height: 20), // Diğer widget'lar arasında boşluk bırakmak için
            TextFormField(
              decoration: InputDecoration(labelText: 'Telefon:'),
              onChanged: (value) {
                _username = value;
              },
              validator: (value) {
                if (_username == null || _username.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lütfen telefon numaranızı girin:('),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (_username.length != 10) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lütfen telefon numaranızı 10 hane olacak şekilde girin:('),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Şifre:'),
              onChanged: (value) {
                _password = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen Şifre Girin!';
                }
                return null;
              },
              obscureText: true,
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _searchData();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor500,
                  ),
                  icon: Icon(Icons.done_outline, color: Colors.white), // Giriş yap iconu
                  label: Text(
                    'Giriş Yap',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewUser()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor500,
                  ),
                  icon: Icon(Icons.person_add, color: Colors.white), // Kayıt ol iconu
                  label: const Text(
                    'Kayıt Ol',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );



  }

}