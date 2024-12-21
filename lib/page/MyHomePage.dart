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
          _buildDrawerItem(
              context, Icons.home, 'Ana Sayfa', () {}), // Example handler
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
            Icons.support,
            'Destek',
                () {}, // Example handler
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.orange.shade600,
      title: const Text(
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
          icon: const Icon(Icons.account_circle, color: Colors.black),
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: 'My Profile',
                child: Text('Profilim'),
              ),
              const PopupMenuItem(
                value: 'Log Out',
                child: Text('Çıkış Yap'),
              ),
            ];
          },
        ),
      ],
    );
  }

  Widget _buildHeaderImage() {
    return Image.asset(
      'lib/media/slide1.png', // Ensure this path is valid
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
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
          const SizedBox(height: 10),
          const Text('Bugün için etkinlik yok.'),
        ],
      ),
    );
  }

  Widget _buildRestaurantCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.pink, Colors.redAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Usta şeflerimizin özenle hazırladığı menümüzde, her damak zevkine uygun seçenekler bulunmaktadır.',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.redAccent,
            ),
            child: const Text('Reservasyon Yap'),
          ),
        ],
      ),
    );
  }

  Widget _buildChatButtonOrWindow() {
    return Positioned(
      bottom: 16,
      right: 16,
      child: _isChatOpen
          ? _buildChatWindow()
          : FloatingActionButton(
        onPressed: () {
          setState(() {
            _isChatOpen = true;
          });
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.chat),
      ),
    );
  }

  Widget _buildChatWindow() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sohbet Botu',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _isChatOpen = false;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Merhaba! Size nasıl yardımcı olabilirim?',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Mesajınızı buraya yazın...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (text) {
                // Handle chat input submission
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarDay(String day, String date, bool isSelected) {
    return Column(
      children: [
        Text(day, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 5),
        CircleAvatar(
          radius: 16,
          backgroundColor: isSelected ? Colors.orange : Colors.grey[300],
          child: Text(
            date,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
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
}
