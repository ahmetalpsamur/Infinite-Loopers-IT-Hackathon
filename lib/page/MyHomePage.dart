import 'package:flutter/material.dart';
import 'package:infiniteloopers/page/CalenderPage.dart';
import 'package:infiniteloopers/page/MyProfilePage.dart';
import 'package:infiniteloopers/page/OasisPage.dart';
import 'package:infiniteloopers/page/libraryPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isChatOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderImage(),
                  const SizedBox(height: 20),
                  _buildSectionTitle('Etkinlik Takvimi'),
                  const SizedBox(height: 10),
                  _buildCalendar(),
                  const SizedBox(height: 20),
                  _buildSectionTitle('CAM Restoran'),
                  const SizedBox(height: 10),
                  _buildRestaurantCard(),
                ],
              ),
            ),
          ),
          _buildChatButtonOrWindow(),
        ],
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.orange),
            child: Text(
              'Menü',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          _buildDrawerItem(context, Icons.home, 'Ana Sayfa', () {}),
          _buildDrawerItem(
            context,
            Icons.calendar_today,
            'Ajandam',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendarPage()),
            ),
          ),
          _buildDrawerItem(
            context,
            Icons.update,
            'Oasis 2.0',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OasisPage()),
            ),
          ),
          _buildDrawerItem(
            context,
            Icons.local_library,
            'Kütüphane',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LibraryPage()),
            ),
          ),
          _buildDrawerItem(
            context,
            Icons.update,
            'QR Kodunuzu Oluşturun',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OasisPage()),
            ),
          ),
          _buildDrawerItem(
            context,
            Icons.support,
            'Destek',
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Container(
      width: double.infinity,
      child: Image.asset(
        'lib/media/slide1.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
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
              _buildCalendarDay('Cmt', '21', true),
              _buildCalendarDay('Paz', '22', false),
              _buildCalendarDay('Pzt', '23', false),
              _buildCalendarDay('Sal', '24', false),
              _buildCalendarDay('Çar', '25', false),
            ],
          ),
          SizedBox(height: 10),
          Text('Bugün için etkinlik yok.'),
        ],
      ),
    );
  }

  Widget _buildCalendarDay(String day, String date, bool isSelected) {
    return Column(
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
    );
  }

  Widget _buildRestaurantCard() {
    return Container(
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
    );
  }

  Widget _buildChatButtonOrWindow() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isChatOpen = !_isChatOpen;
          });
        },
        child: Icon(_isChatOpen ? Icons.close : Icons.chat),
      ),
    );
  }

  ListTile _buildDrawerItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }
}
