import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final Set<String> selectedSlots = {};
  final Set<String> selectedClasses = {};

  final List<String> slots = [
    '25th Dec 2024 Time: 13:00 PM',
    '25th Dec 2024 Time: 14:00 PM',
    '25th Dec 2024 Time: 15:00 PM',
    '25th Dec 2024 Time: 16:00 PM',
    '25th Dec 2024 Time: 17:00 PM',
  ];

  final List<String> emptyClasses = [
    'Classroom 101',
    'Classroom 202',
    'Classroom 303',
    'Lab 1',
    'Lab 2',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kütüphane'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Align content center
          children: [
            SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Kütüphane Doluluk Oranı',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.deepOrange, // Dark orange
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularProgressIndicator(
                        strokeWidth: 16,
                        value: 200 / 250,
                        backgroundColor: Colors.grey[200],
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '%80',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '200/250 dolu.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            // Study Area Selection
            SectionHeader(title: 'Çalışma Alanları'),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: slots.map((slot) {
                    final isSelected = selectedSlots.contains(slot);
                    return ListTile(
                      leading: Icon(
                        isSelected ? Icons.check_circle : Icons.circle_outlined,
                        color: isSelected ? Colors.green : Colors.grey,
                      ),
                      title: Text(
                        slot,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.green : Colors.black,
                        ),
                      ),
                      subtitle: Text('Grup Çalışma Alanları'),
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedSlots.remove(slot);
                          } else {
                            selectedSlots.add(slot);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 30),

            // Empty Classrooms
            SectionHeader(title: 'Boş Sınıflar'),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: emptyClasses.map((classroom) {
                    final isSelected = selectedClasses.contains(classroom);
                    return ListTile(
                      leading: Icon(
                        isSelected ? Icons.check_circle : Icons.circle_outlined,
                        color: isSelected ? Colors.green : Colors.grey,
                      ),
                      title: Text(
                        classroom,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.green : Colors.black,
                        ),
                      ),
                      subtitle: Text('Boş Sınıf:'),
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedClasses.remove(classroom);
                          } else {
                            selectedClasses.add(classroom);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 30),

            // Book Appointment Button
            Center(
              child: ElevatedButton(
                onPressed: selectedSlots.isEmpty && selectedClasses.isEmpty
                    ? null
                    : () {
                        _showConfirmationDialog(context);
                      },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Randevu Al'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Randevu Onayı'),
          content: Text(
            'Seçilen Sınıf:\n\n${selectedClasses.join("\n")}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('İptal Et'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSuccessSnackbar(context);
              },
              child: Text('Onayla'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        'Randevu Onaylandı.',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setState(() {
      selectedSlots.clear();
      selectedClasses.clear();
    });
  }
}

// Section Header Widget
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.deepOrange, // Dark orange
      ),
      textAlign: TextAlign.center,
    );
  }
}
