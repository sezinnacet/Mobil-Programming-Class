import 'package:flutter/material.dart';
import 'calendar_page.dart';
import 'login_page.dart';
import 'blog_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Etkinlik Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<Color?>? _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _opacityAnimation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeIn,
    );

    _colorAnimation = ColorTween(begin: Colors.white, end: Colors.deepPurple)
        .animate(_controller!);

    _controller!.forward();

    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, child) {
        return Scaffold(
          body: Center(
            child: FadeTransition(
              opacity: _opacityAnimation!,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Eventify',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Türkiye'nin Ücretsiz Etkinlikleri",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: _colorAnimation!.value,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Event> events = [
    Event(
      name: 'Konser',
      date: '2023-12-20',
      location: 'İstanbul',
      image: NetworkImage('https://fotolifeakademi.com/uploads/2020/12/konser-cekimi-workshop.webp'),
      details: 'Bu konserde ünlü sanatçı XYZ sahne alacak. Etkinlik ücretsizdir.',
    ),
    Event(
      name: 'Tiyatro',
      date: '2023-12-22',
      location: 'Ankara',
      image: NetworkImage(
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Maly_Theatre_foto_2.jpg/640px-Maly_Theatre_foto_2.jpg'),
    ),

    Event(
      name: 'Festival',
      date: '2023-12-26',
      location: 'İzmir',
      image: NetworkImage('https://www.erasmusplusturkiye.com/wp-content/uploads/2022/09/festival.jpeg'),
    ),
    Event(
      name: 'Konser',
      date: '2023-12-28',
      location: 'Eskişehir',
      image: NetworkImage('https://eskisehirnet.teimg.com/eskisehir-net/uploads/2023/12/sdf-eskisehir-tepebasi-yeniyilcoskusukonser.png'),
    ),
    Event(
      name: 'Konser',
      date: '2023-12-29',
      location: 'Eskişehir',
      image: NetworkImage('https://www.tepebasi.bel.tr/etkinlikler/resimler/100.%20Y%C4%B1l%20Konseri%20dikey.jpg'),
    ),
    Event(
      name: 'Sergi',
      date: '2023-12-30',
      location: 'Antalya',
      image: NetworkImage('https://saltonline.org/directus/media/thumbnails/image_5-jpg-780-5000-false.jpg'),
    ),

  ];

  bool isSearching = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Etkinlikler'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
          ),
        ],
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 80,
                child: DrawerHeader(
                  child: Text('Menü', style: TextStyle(color: Colors.white, fontSize: 20)),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Takvim'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalendarPage()));
                  // Takvim sayfasına yönlendirme
                },
              ),
              ListTile(
                leading: Icon(Icons.login),
                title: Text('Giriş Yap'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                  // Giriş sayfasına yönlendirme
                },
              ),
              ListTile(
                leading: Icon(Icons.article),
                title: Text('Blog'),
                onTap: () {
                  // Blog sayfasına yönlendirme
                  Navigator.pop(context); // Drawer'ı kapat
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BlogPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.search),
                title: Text('Ara'),
                onTap: () {
                  Navigator.pop(context); // Drawer'ı kapat
                  setState(() {
                    isSearching = true; // Arama kutusunu aç
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Ayarlar'),
                onTap: () {
                  // Ayarlar sayfasına yönlendirme
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          isSearching
              ? Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Ara',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Arama işlevi buraya eklenecek
              },
            ),
          )
              : Container(),
          Expanded(
            child: Scrollbar( // Scrollbar widget'ı eklendi
              isAlwaysShown: true, // Scrollbar her zaman görünür
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return EventCard(event: events[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Event {
  final String name;
  final String date;
  final String location;
  final ImageProvider image;
  final String details;

  Event({required this.name, required this.date, required this.location, required this.image, this.details = ''});
}

class EventCard extends StatelessWidget {
  final Event event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(event.name),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Tarih: ${event.date}'),
                      Text('Konum: ${event.location}'),
                      Text(event.details), // Etkinlik detayları
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Kapat'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image(image: event.image, height: 250, width: double.infinity, fit: BoxFit.cover,),
            ),
            ListTile(
              title: Text(event.name),
              subtitle: Text('${event.date} - ${event.location}'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}