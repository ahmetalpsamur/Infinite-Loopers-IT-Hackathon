import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  List<String> hobbies = [
    "Reading",
    "Gaming",
    "Programming",
    "Swimming",
    "Traveling",
    "Music",
    "Photography",
    "Cooking",
    "Drawing",
    "Sports",
    "Writing",
    "Dancing"
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
        title: Text('My Profile'),
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
                      'assets/profile_picture.png'), // Replace with your image asset
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Computer Engineering Student',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Edit Profile'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(),
            Text(
              'About Me',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Passionate about technology and innovation. Always eager to learn and take on new challenges.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Divider(),
            Text(
              'Hobbies',
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
                child: Text('Save and Exit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
