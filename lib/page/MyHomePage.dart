import 'package:flutter/material.dart';
import 'package:infiniteloopers/ChatBubble.dart';
import 'package:infiniteloopers/page/CalenderPage.dart';
import 'package:infiniteloopers/page/Ekofit.dart';
import 'package:infiniteloopers/page/MyProfilePage.dart';
import 'package:infiniteloopers/page/OasisPage.dart';
import 'package:infiniteloopers/page/libraryPage.dart';
import 'package:infiniteloopers/page/FriendsPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isChatOpen = false;
  bool _isExpanded = false;
  bool _isHovered = false;

  String selectedDay = '21';
  List<Map<String, String>> events = [
    {'time': '09:00 AM', 'description': 'Physics Class (M201)'},
    {'time': '11:30 AM', 'description': 'Group Meeting (C406)'},
    {'time': '02:00 PM', 'description': 'Lab Session (E021)'},
  ];

  // Event data for each day
  final Map<String, List<Map<String, String>>> dayEvents = {
    '21': [
      {'time': '09:00 AM', 'description': 'Physics Class (M201)'},
      {'time': '11:30 AM', 'description': 'Yapay Zeka Klüp Etkinliği (C406)'},
      {'time': '02:00 PM', 'description': 'Lab Session (E021)'},
    ],
    '22': [
      {'time': '10:00 AM', 'description': 'Math Class (M202)'},
      {'time': '12:00 PM', 'description': 'Team Presentation (C407)'},
    ],
    '23': [
      {'time': '09:30 AM', 'description': 'History Class (M203)'},
      {'time': '01:00 PM', 'description': 'Workshop (E022)'},
    ],
    '24': [
      {'time': '11:00 AM', 'description': 'Art Class (M204)'},
      {'time': '03:00 PM', 'description': 'Seminar (C408)'},
    ],
    '25': [
      {'time': '09:00 AM', 'description': 'Literature Class (M205)'},
      {'time': '01:30 PM', 'description': 'Study Group (C409)'},
    ],
  };
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
                  _buildExpandableButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildChatButtonOrWindow(),
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
            Icons.update,
            'Arkadaşlarım',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FriendsPage()),
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
    return SizedBox(
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
          // Calendar Row with GestureDetector to select a day
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCalendarDay(
                  'Cmt', '21', selectedDay == '21', () => _onDaySelected('21')),
              _buildCalendarDay(
                  'Paz', '22', selectedDay == '22', () => _onDaySelected('22')),
              _buildCalendarDay(
                  'Pzt', '23', selectedDay == '23', () => _onDaySelected('23')),
              _buildCalendarDay(
                  'Sal', '24', selectedDay == '24', () => _onDaySelected('24')),
              _buildCalendarDay(
                  'Çar', '25', selectedDay == '25', () => _onDaySelected('25')),
            ],
          ),
          SizedBox(height: 20),

          // Cloud Icon with Temperature
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.cloud,
                size: 32,
                color: Colors.blue,
              ),
              SizedBox(width: 8),
              Text(
                '15°C',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          // Events Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ajandam',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // Show the events for the selected day
              for (var event in dayEvents[selectedDay]!)
                _buildEvent(event['time']!, event['description']!),
            ],
          ),
        ],
      ),
    );
  }

  void _onDaySelected(String day) {
    setState(() {
      selectedDay = day;
      events = dayEvents[day]!;
    });
  }

  Widget _buildCalendarDay(
      String day, String date, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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

  Widget _buildEvent(String time, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            Icons.event_note,
            color: Colors.teal,
          ),
          SizedBox(width: 8),
          Text(
            time,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableButton() {
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        width: double.infinity, // Button takes up the full width
        padding:
            EdgeInsets.symmetric(vertical: 18), // Increased padding for height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.red.shade200], // Gradient color
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 6), // More shadow for depth
            ),
          ],
        ),
        child: Column(
          children: [
            // Main button text
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: _isExpanded ? 22 : 19, // Larger text when expanded
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0), // Increased padding
                child: Container(
                  child: Text(
                    'Randevu Al',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            if (_isExpanded) // Only show the options when expanded
              Container(
                color: Colors.white, // Set background to white
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Left align the options
                  children: [
                    _buildOption(
                        'EKOFIT Randevusu', _navigateToEkofitRandevusu),
                    const Divider(
                      color: Colors.grey, // Divider color
                      thickness: 1, // Line thickness
                      indent: 0, // Optional indent for the divider
                      endIndent: 0, // Optional end indent for the divider
                    ),
                    _buildOption('Çalışma Alanı Randevusu',
                        _navigateToCalismaAlaniRandevusu),
                    const Divider(
                      color: Colors.grey, // Divider color
                      thickness: 1, // Line thickness
                      indent: 0, // Optional indent for the divider
                      endIndent: 0, // Optional end indent for the divider
                    ),
                    _buildOption('Cam Restoran Randevusu',
                        _navigateToCamRestoranRandevusu),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String text, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.transparent, // No background color
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              Icon(Icons.circle, size: 8, color: Colors.black), // Mini dot icon
              const SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Navigation Functions
  void _navigateToEkofitRandevusu() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Ekofit()), // Navigate to Ekofit page
    );
  }

  void _navigateToCalismaAlaniRandevusu() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LibraryPage()), // Navigate to Ekofit page
    );
  }

  void _navigateToCamRestoranRandevusu() {
    // Use Navigator to go to the Cam Restoran Randevusu page
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
              child: const Icon(Icons.chat, color: Colors.white, size: 28),
            ),
    );
  }

  Widget _buildChatWindow() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.chat_bubble, color: Colors.white),
                    const SizedBox(width: 8),
                    const Text(
                      'Sohbet Botu',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
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

          // Chat Messages Section
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ChatBubble(
                    message:
                        'Merhaba ben EKO-BOT! Size nasıl yardımcı olabilirim?',
                    isBot: true,
                  ),
                  const SizedBox(height: 10),
                  const ChatBubble(
                    message:
                        'Bana CE216 dersine nasıl çalışacağımı söyler misin?',
                    isBot: false,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          // Input Section
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Mesajınızı buraya yazın...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    // Send message action
                  },
                  icon: const Icon(Icons.send, color: Colors.orange),
                ),
              ],
            ),
          ),
        ],
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
