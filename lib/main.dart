import 'package:flutter/material.dart';

import 'home/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Bu widget uygulamanızın köküdür.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Bu uygulamanızın temasıdır.
        //
        // DENEYİN: Uygulamanızı "flutter run" ile çalıştırmayı deneyin.
        // Uygulamanın mor bir araç çubuğuna sahip olduğunu göreceksiniz.
        // Ardından, uygulamadan çıkmadan, aşağıdaki colorScheme'deki seedColor'u
        // Colors.green olarak değiştirmeyi deneyin ve "hot reload"u çalıştırın
        // (değişikliklerinizi kaydedin veya Flutter destekli bir IDE'de
        // "hot reload" düğmesine basın ya da uygulamayı komut satırından başlattıysanız "r" tuşuna basın).
        //
        // Sayacın sıfırlanmadığını fark edin; yeniden yükleme sırasında uygulama durumu kaybolmaz.
        // Durumu sıfırlamak için hot restart kullanın.
        //
        // Bu sadece değerler için değil, kod için de geçerlidir: Çoğu kod değişikliği sadece hot reload ile test edilebilir.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AnaSayfa(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // Bu widget uygulamanızın ana sayfasıdır. Stateful'dır, yani
  // nasıl göründüğünü etkileyen alanlara sahip bir State nesnesi vardır (aşağıda tanımlanmıştır).

  // Bu sınıf, state için yapılandırmadır. Ebeveyn tarafından sağlanan değerleri (bu durumda title)
  // saklar ve State'in build metodunda kullanır. Widget alt sınıfındaki alanlar her zaman "final" olarak işaretlenir.

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // Bu setState çağrısı, Flutter framework'üne bu State'te bir şeylerin değiştiğini söyler,
      // bu da build metodunun tekrar çalıştırılmasına neden olur, böylece ekran güncellenen
      // değerleri yansıtabilir. Eğer _counter'ı setState çağırmadan değiştirirsek,
      // build metodu tekrar çağrılmaz ve bu yüzden hiçbir şey görünürde değişmez.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Bu metod, setState çağrıldığında her seferinde yeniden çalıştırılır,
    // örneğin yukarıda _incrementCounter metodu tarafından yapıldığı gibi.
    //
    // Flutter framework, build metodlarının hızlı yeniden çalıştırılması için optimize edilmiştir,
    // bu yüzden yeniden inşa edilmesi gereken her şeyi yeniden inşa etmek,
    // tek tek widget örneklerini değiştirmek zorunda kalmaktan daha hızlıdır.
    return Scaffold(
      appBar: AppBar(
        // DENEYİN: Buradaki rengi belirli bir renge (örneğin Colors.amber) değiştirin ve
        // hot reload'u tetikleyin, AppBar renginin değiştiğini, diğer renklerin aynı kaldığını görün.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Burada App.build metodu tarafından oluşturulan MyHomePage nesnesinden alınan değeri
        // alıyoruz ve bunu appbar başlığımızı ayarlamak için kullanıyoruz.
        title: Text(widget.title),
      ),
      body: Center(
        // Center bir yerleşim widget'ıdır. Tek bir çocuk alır ve onu
        // ebeveynin ortasına yerleştirir.
        child: Column(
          // Column da bir yerleşim widget'ıdır. Bir dizi çocuğu alır ve
          // dikey olarak sıralar. Varsayılan olarak, çocuklarını yatay olarak sığdırmak için
          // boyutlandırır ve ebeveyninin yüksekliği kadar uzun olmaya çalışır.
          //
          // Column'un kendini boyutlandırma ve çocuklarını konumlandırma şeklini kontrol etmek için çeşitli özellikleri vardır.
          // Burada children'ı dikey olarak ortalamak için mainAxisAlignment kullanıyoruz;
          // ana eksen burada dikey eksendir çünkü Column'lar dikeydir (yan eksen yatay olacaktır).
          //
          // DENEYİN: "debug painting"i tetikleyin (IDE'de "Toggle Debug Paint" eylemini seçin
          // veya konsolda "p" tuşuna basın), her widget için tel kafesi görmek için.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Butona bu kadar kez bastınız:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Arttır',
        child: const Icon(Icons.add),
      ), // Bu son virgül build metotlarını daha düzenli hale getirir.
    );
  }
}
