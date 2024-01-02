import 'package:flutter/material.dart';
import 'login_page.dart'; // Giriş yapma sayfası için

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  int selectedStar = 0;
  final PageController _pageController = PageController(viewportFraction: 0.85);
  bool isLoggedIn = false; // Kullanıcı giriş durumu kontrolü için geçici bir değişken

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  double calculateAverageRating(List<Map<String, dynamic>> comments) {
    if (comments.isEmpty) return 0;
    double sum = 0;
    for (var comment in comments) {
      sum += comment['rating'] as int;
    }
    return sum / comments.length;
  }

  @override
  Widget build(BuildContext context) {
    final comments = [
      {'name': 'Ayşe Yılmaz', 'comment': 'Etkinlik çok güzeldi, herkese tavsiye ederim!', 'rating': 5},
      {'name': 'Mehmet Öz', 'comment': 'Harika bir atmosferdi, tekrar gitmek isterim.', 'rating': 4},
      // Daha fazla yorum eklenebilir...
    ];
    double averageRating = calculateAverageRating(comments);

    return Scaffold(
      appBar: AppBar(
        title: Text('Blog'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "20 Aralık'ta Kadıköy'de Efsane Bir Gece: Teoman ile Rock Rüzgarı",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 200,
              child: PageView(
                controller: _pageController,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4), // Sağ ve sol tarafta 8'er piksel boşluk
                    child: Image.network('https://www.kulturistanbul.net/wp-content/uploads/2022/06/2022-istanbul-konserleri-3-960x641.jpg', fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Image.network('https://staticb.yolcu360.com/blog/wp-content/uploads/2022/04/12154937/istanbul-konser-mekanlari.jpg', fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Image.network('https://blog.biletino.com/file/2022/03/Kapak-1.jpg', fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("İstanbul Anadolu Yakası'nın kalbi Kadıköy, geçtiğimiz 20 Aralık'ta, unutulmaz bir kış konserine ev sahipliği yaptı. Ücretsiz ve açık havada gerçekleşen bu özel etkinlikte, Türk rock müziğinin sevilen ismi Teoman sahne aldı.", style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < selectedStar ? Icons.star : Icons.star_border,
                      color: index < selectedStar ? Colors.orange : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedStar = index + 1;
                      });
                    },
                  );
                }),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Yorumunuzu yazın',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        if (!isLoggedIn) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Giriş Yap'),
                                content: Text('Giriş yapmadan yorum yapamazsınız.'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: Text('Giriş Yap'),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginPage()),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // Yorum gönderme işlevi
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Yorumlar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  ...comments.map((comment) {
                    final String name = comment['name'] as String;
                    final String commentText = comment['comment'] as String;
                    final int rating = comment['rating'] as int;

                    return Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          SizedBox(height: 4),
                          Text(commentText, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                          Row(
                            children: [
                              ...List.generate(rating, (index) => Icon(Icons.star, color: Colors.orange, size: 16)),
                              Text(' ($rating/5)', style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
