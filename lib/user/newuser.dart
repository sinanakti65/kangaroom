import 'dart:convert';
import 'dart:io';
import 'dart:math';
import '/theme.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/diyabetesLogin.dart';
import '../homescreen/homescreen.dart';
import 'package:http/http.dart' as http;
import '../homescreen/notification_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  TextEditingController telefonController = TextEditingController();
  String? selectedCinsiyet;
  List<String> cinsiyetler = ['Erkek', 'Kadın'];
  TextEditingController boyController = TextEditingController();
  TextEditingController kiloController = TextEditingController();
  TextEditingController yasController = TextEditingController();
  TextEditingController adSoyadController = TextEditingController();
  TextEditingController sifreController = TextEditingController();
  String? selectedAvatar;
  List<Diyabet> newuser = [];
  List<int> sorulacak = [];
  List<int> sorulmayacak = [];
  List<double> kansekeri = [];
  List<int> adimsayisi = [];

  int id=0;
  late String telefon;
  late String adSoyad;
  late String sifre;
  late String boy;
  late String kilo;
  late String yas;


  @override
  void initState() {
    super.initState();
    fetchData();
    NotificationHelper.scheduleDailyNotification(id:1, title:"Diyabet'ES" , body: rastgeleBildirim(), payload: '', notificationTime:TimeOfDay(hour: 12, minute: 00) );
  }




  Map<String, Map<String, String>> bildirimler = {
    "Beslenme": {
      "1": "Yarım elma gönül alma, ara öğün yemeyi unutma!",
      "2": "Sağlıksız beslenmenin cezasını ayaklar çekmesin Yemeğine değil hayatına şeker kat",
      "3": "Hayatın tadı şekersiz daha tatlıdır",
      "4": "Daha kontrollü bir şeker için sağlıklı beslenmeyi seçin",
      "5": "Küçük bir hatırlatma! Ara öğününü yedin mi?",
      "6": "Unutmal Öğün atlayarak kan şekerini dengeleyemezsin",
      "7": "Doğru beslen, hareket et şekerini kontrol et",
      "8": "Sağlıklı beslen şekerine yön ver"
    },
    "Fiziksel Aktivite": {
      "1": "Güneş görmeyen doktor görür! Temiz hava almanın tam zamanı. Bugün hava çok güzel biraz yürüyüş yapmaya ne dersin?",
      "2": "Bilmek yetmez uygulamak lazım hadi biraz yürüyelim",
      "3": "Üşenme, erteleme, zamanım yok deme! Hadi yürüyüşe",
      "4": "Hedefine ulaşmak için az adımın kaldı. Başarabilirsin!",
      "5": "Sağlıklı bir sen için bugün harekete geç",
      "6": "Tebrikler günlük adım sayısı hedefinize ulaştınız. Başarını sevdiklerinle paylaşabilirsin",
      "7": "Sağlığa adım at hedefini tamamla",
      "8": "Üşenme erteleme vazgeçme 45 dk yürüyüş yap 23 saat 15 dk seninle Hayatımızda diyabet her gün yürü hareket et",
      "9": "Kendine yatırım yap ve yürüyüş yap",
      "10": "Kendini sevive ona yürüyüş yaparak sağlike hediye et"
    },
    "Tedaviye Uyum": {
      "1": "Bahaneler şekerini normalleştirmez",
      "2": "Seni ayakta tutan iki şey var. Sağ ve sol ayağın onlara iyi bak! Şekerini kontrol et sağlıklı yaşamaya devam et",
      "3": "Sağlıklı yaşamak için kan şekerine kulak ver",
      "4": "Şekerini kontrol et hayatını kontrol et",
      "5": "Huylu huyundan vazgeçer. Sağlıklı yaşamayı seçer",
      "6": "Hadi bugün sağlıklı kalmak için elinden gelenin en iyisini yap",
      "7": "Su içmeyi gülümsemeyi 😊 ve şekerini ölçmeyi unutma",
      "8": "Hayallerine sınır koyma kan şekerine sınır koy",
      "9": "Kan şekerinizi dengeleyin hayata gülümseyin",
      "10": "Bu yıl kl göz böbrek ve sinir muayenenizi yaptırmayı unutmayın. Bir dost Alaç/Insulin saatlerinde hatırlatma:",
      "11": "Bugün ayaklanının kontrol ettin mi?",
      "12": "Aman dikkat! Tüm gözler üzerinizde. Yıllık göz muayenenizi aksatmayın"
    }
  };



  String rastgeleBildirim() {
    // "Beslenme", "Fiziksel Aktivite" ve "Tedaviye Uyum" kategorilerinden rastgele birini seç
    final rastgeleKategori = ["Beslenme", "Fiziksel Aktivite", "Tedaviye Uyum"].elementAt(Random().nextInt(3));

    // Seçilen kategorinin altında bulunan bildirimlerin listesini al
    final bildirimlerListesi = bildirimler[rastgeleKategori]!;

    // Rastgele bir bildirimi seç
    final rastgeleBildirim = bildirimlerListesi.values.elementAt(Random().nextInt(bildirimlerListesi.length));

    return rastgeleBildirim;
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

  Future<void> _register() async {
    final String apiUrl = 'https://wux32a4eyri33ujw2j47p6uvli0fblto.lambda-url.us-east-1.on.aws/api/DiyabetesLogin';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },



        body: jsonEncode(<String, dynamic>{
          "id": 0,
          "telefon": telefon,
          "adSoyad": adSoyad,
          "sifre":sifre,
          "cinsiyet": selectedCinsiyet,
          "boy": boy,
          "kilo": kilo,
          "yas": yas,
        }
        ),


      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        id = responseData['id'];

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Rezervasyon Oluşturuldu...'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Rezervasyon kaydedilirken bir hata oluştu!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('****************************************************************************** $e');
      print('HTTP isteği sırasında bir hata oluştu: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bir hata oluştu, lütfen tekrar deneyin! $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  //dosya oluşturma
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/login.json');
  }
  void showToast() {
    Fluttertoast.showToast(
      msg: "Bir hata oluştu, lütfen tekrar deneyin!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
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
          content: Text('Kullanıcı bilgileri başarıyla kaydedildi!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigator ile ekranı değiştir
    } catch (e) {
      print(e);
      // Hata durumunda bildirim
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kullanıcı bilgileri kaydedilirken  bir hata oluştu!'),
          backgroundColor: Colors.red,
        ),
      );
    }

    // Dosyayı döndür
    return file;
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Kayıt',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: telefonController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Telefon Numarası',
                ),
              ),
              SizedBox(height: 12.0),

              TextField(
                controller: sifreController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Şifre',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: adSoyadController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Ad Soyad',
                ),
              ),
              SizedBox(height: 12.0),
              DropdownButtonFormField<String>(
                value: selectedCinsiyet,
                onChanged: (value) {
                  setState(() {
                    selectedCinsiyet = value;
                  });
                },
                items: cinsiyetler.map((cinsiyet) {
                  return DropdownMenuItem(
                    value: cinsiyet,
                    child: Text(cinsiyet),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Cinsiyet',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: boyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Boy (cm)',
                  hintText: 'Örnek: 180',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: kiloController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Kilo (kg)',
                  hintText: 'Örnek: 75',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: yasController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Yaş',
                  hintText: 'Örnek: 30',
                ),
              ),
              SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: () {
                  // Telefon numarasının 10 hane şeklinde girilip girilmediğini kontrol eder
                  if (telefonController.text.length != 10) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Lütfen 10 hane olacak şekilde bir telefon numarası girin')),
                    );
                    return;
                  }

                  // Diğer alanların boş girilip girilmediğini veya cinsiyetin seçilip seçilmediğini kontrol eder
                  if (selectedCinsiyet == null ||
                      boyController.text.isEmpty ||
                      kiloController.text.isEmpty ||
                      yasController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                          Text('Lütfen tüm bilgileri eksiksiz doldurun')),
                    );
                    return;
                  }

                  List<Diyabet> selectedDiyabet = newuser
                      .where((diyabet) =>
                      telefonController.text.contains(diyabet.telefon))
                      .toList();
                  if (selectedDiyabet.isNotEmpty) {
                    telefon = selectedDiyabet[0].telefon;
                    adSoyad = selectedDiyabet[0].adSoyad;
                    sifre=selectedDiyabet[0].sifre;
                    boy = selectedDiyabet[0].boy;
                    kilo = selectedDiyabet[0].kilo;
                    selectedCinsiyet=selectedDiyabet[0].cinsiyet;
                    yas = selectedDiyabet[0].yas;
                  } else {
                    // Gerekli doğrulamalar yapıldıktan sonra bilgileri işlemek için devam edebiliriz
                    telefon = telefonController.text;
                    adSoyad = adSoyadController.text;
                    sifre=sifreController.text;
                    boy = boyController.text;
                    kilo = kiloController.text;
                    yas = yasController.text;
                    _register();
                  }
                  if(selectedCinsiyet?.compareTo("Erkek")==0){
                    selectedAvatar='assets/avatars/man/man1/';

                  }

                  if(selectedCinsiyet?.compareTo("Kadın")==0){
                    selectedAvatar='assets/avatars/woman/woman1/';
                  }

                  Map<String, dynamic> newUser = {
                    //json datasına da verileri de gönder

                    "id":id,
                    "avatar": selectedAvatar,
                    "telefon": telefon,
                    "adSoyad": adSoyad,
                    "sifre":sifre,
                    "cinsiyet": selectedCinsiyet,
                    "boy": boy,
                    "kilo": kilo,
                    "yas": yas,
                    "login": 1,
                  };
                  _updateLoginJson(newUser);
                  _writeRozetData();


                  // Bilgileri kaydettikten sonra HomeScreen'e yönlendirme yapılır
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AnaSayfa()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: primaryColor500,
                ),
                child: Text(
                  'Bilgileri Kaydet',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _showAvatarSelectionDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Profil Seç'),
  //         content: Container(
  //           width: double.maxFinite,
  //           height: 300.0,
  //           child: GridView.count(
  //             crossAxisCount: 5,
  //             children: List.generate(
  //               10,
  //                   (index) {
  //                 return GestureDetector(
  //                   onTap: () {
  //                     setState(() {
  //                       selectedAvatar = 'avatar${index + 1}.png';
  //                     });
  //                     Navigator.pop(context);
  //                   },
  //                   child: Container(
  //                     margin: EdgeInsets.all(8.0),
  //                     decoration: BoxDecoration(
  //                       color: selectedAvatar == 'avatar${index + 1}.png'
  //                           ? Colors.blue
  //                           : Colors.transparent,
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                     child: Image.asset(
  //                       'assets/avatars/avatar${index + 1}.png',
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }


}
