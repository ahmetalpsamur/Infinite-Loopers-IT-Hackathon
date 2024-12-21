import 'package:flutter/material.dart';
import 'package:infiniteloopers/page/CalenderPage.dart';
import 'package:infiniteloopers/page/MyProfilePage.dart';
import 'package:infiniteloopers/page/OasisPage.dart';
import 'package:infiniteloopers/page/libraryPage.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get today's date
    final today = DateTime.now();
    final todayDay = today.day;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text(
                'Menü',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Ana Sayfa'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Ajandam'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.update),
              title: Text('Oasis 2.0'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OasisPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.local_library),
              title: Text('Kütüphane'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LibraryPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.update),
              title: Text('QR Kodunuzu Oluşturun'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OasisPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.support),
              title: Text('Destek'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.orange.shade600,
        title: Text(
          'MyIEU',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'My Profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProfilePage()),
                );
              } else if (value == 'Log Out') {
                // Handle log out
              }
            },
            icon: Icon(Icons.account_circle, color: Colors.black),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'My Profile',
                  child: Text('Profilim'),
                ),
                PopupMenuItem(
                  value: 'Log Out',
                  child: Text('Çıkış Yap'),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Image.asset(
                  'lib/media/slide1.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Etkinlik Takvimi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCalendarDay('Cmt', '21', todayDay == 21, context),
                        _buildCalendarDay('Paz', '22', todayDay == 22, context),
                        _buildCalendarDay('Pzt', '23', todayDay == 23, context),
                        _buildCalendarDay('Sal', '24', todayDay == 24, context),
                        _buildCalendarDay('Çar', '25', todayDay == 25, context),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text('Bugün için etkinlik yok.'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'CAM Restoran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pink, Colors.redAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Usta şeflerimizin özenle hazırladığı menümüzde, her damak zevkine uygun seçenekler bulunmaktadır.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.redAccent,
                      ),
                      child: Text('Reservasyon Yap'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                child: Image.asset(
                  'lib/media/ekofit.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarDay(
      String day, String date, bool isSelected, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to CalendarPage when clicked
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CalendarPage()),
        );
      },
      child: Column(
        children: [
          Text(day, style: TextStyle(color: Colors.grey)),
          SizedBox(height: 5),
          CircleAvatar(
            backgroundColor: isSelected ? Colors.orange : Colors.grey[200],
            child: Text(
              date,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
