import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My IEU',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'myIEU Menu',
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
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.support),
              title: Text('Destek'),
              onTap: () {},
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
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Hoşgeldiniz'),
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
            icon: Icon(Icons.account_circle, color: Colors.white),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'My Profile',
                  child: Text('My Profile'),
                ),
                PopupMenuItem(
                  value: 'Log Out',
                  child: Text('Log Out'),
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
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tek tıkla QR kodunuzu tasarlayın!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.qr_code,
                      color: Colors.blue,
                    ),
                  ],
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
            ],
          ),
        ),
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
}

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final List<String> hobbies = [
    'Reading',
    'Gaming',
    'Cooking',
    'Traveling',
    'Sports'
  ];
  final Set<String> selectedHobbies = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: Fikri Barça Bulut',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Hobbies:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: hobbies.map((hobby) {
                final isSelected = selectedHobbies.contains(hobby);
                return ChoiceChip(
                  label: Text(hobby),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedHobbies.add(hobby);
                      } else {
                        selectedHobbies.remove(hobby);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class OasisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oasis 2.0'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Oasis 2.0',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Exam Dates'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Assignments'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Başarılı Olduğunuz Ders Adedi',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          CircularProgressIndicator(
                            value: 37 / 45,
                            backgroundColor: Colors.grey[200],
                            color: Colors.green,
                          ),
                          SizedBox(height: 10),
                          Text('37 of 45'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Mevcut AKTS',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          CircularProgressIndicator(
                            value: 226 / 240,
                            backgroundColor: Colors.grey[200],
                            color: Colors.blue,
                          ),
                          SizedBox(height: 10),
                          Text('226 of 240'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Haftalık Ders Programı',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Table(
                  border: TableBorder.all(color: Colors.grey),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.blue[50]),
                      children: [
                        Center(child: Text('Pazartesi')),
                        Center(child: Text('Salı')),
                        Center(child: Text('Çarşamba')),
                        Center(child: Text('Perşembe')),
                        Center(child: Text('Cuma')),
                      ],
                    ),
                    TableRow(
                      children: [
                        Center(child: Text('SE 115')),
                        Center(child: Text('SE 115')),
                        Center(child: Text('SE 115')),
                        Center(child: Text('')),
                        Center(child: Text('')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upcoming Exam Dates',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.event, color: Colors.blue),
                    title: Text('Math 101 - 25th Dec 2024'),
                    subtitle: Text('Time: 10:00 AM'),
                  ),
                  ListTile(
                    leading: Icon(Icons.event, color: Colors.blue),
                    title: Text('Physics 202 - 27th Dec 2024'),
                    subtitle: Text('Time: 2:00 PM'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Assignment Deadlines',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.assignment, color: Colors.green),
                    title: Text('Essay on AI - 23rd Dec 2024'),
                    subtitle: Text('Submit via portal'),
                  ),
                  ListTile(
                    leading: Icon(Icons.assignment, color: Colors.green),
                    title: Text('Group Project - 30th Dec 2024'),
                    subtitle: Text('Submit presentation slides'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
