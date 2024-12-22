import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  List<String> hobbies = [
    "Edebiyat",
    "Oyun",
    "Yazılım",
    "Yüzme",
    "Seyahat",
    "Müzik",
    "Fotoğrafçılık",
    "Yemek",
    "Çizim",
    "Spor",
    "Yazarlık",
    "Dans"
  ];

  List<String> selectedHobbies = [];

  @override
  void initState() {
    super.initState();
    _loadSelectedHobbies();
  }

  Future<void> _loadSelectedHobbies() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedHobbies = prefs.getStringList('selectedHobbies') ?? [];
    });
  }

  Future<void> _saveSelectedHobbies() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selectedHobbies', selectedHobbies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profilim'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      'lib/media/İzmir_Ekonomi_Üniversitesi_logo.png'), // Replace with your image asset
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EKO BOT',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Bilgisayar Mühendisliği',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Profili Düzenle'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(),
            Text(
              'Hakkımda',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Teknoloji benim tutkum.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Divider(),
            Text(
              'Hobilerim',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: hobbies.map((hobby) {
                final isSelected = selectedHobbies.contains(hobby);
                return ChoiceChip(
                  label: Text(hobby),
                  selected: isSelected,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.grey[200],
                  onSelected: (bool selected) {
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
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _saveSelectedHobbies();
                  Navigator.pop(context);
                },
                child: Text('Kaydet ve Çık'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
