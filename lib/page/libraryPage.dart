import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  // Seçili çalışma alanlarını tutan bir Set
  final Set<String> selectedSlots = {};
  final Set<String> selectedClasses = {};

  // Örnek çalışma saatleri
  final List<String> slots = [
    '25th Dec 2024 Time: 13:00 PM',
    '25th Dec 2024 Time: 14:00 PM',
    '25th Dec 2024 Time: 15:00 PM',
    '25th Dec 2024 Time: 16:00 PM',
    '25th Dec 2024 Time: 17:00 PM',
  ];

  // Örnek boş sınıflar
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
        title: Text('Library'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Library Dashboard',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 30),

            // Kütüphane Doluluk Oranı
            SectionHeader(title: 'Kütüphane Doluluk Oranı'),
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
                      ),
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
                      '200 of 250 people',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            // Çalışma Alanı Seçimi
            SectionHeader(title: 'Kütüphane Çalışma Alanı'),
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
                      subtitle: Text('Grup Çalışma Yeri'),
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

            // Boş Sınıflar
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
                      subtitle: Text('Boş Sınıf'),
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

            // Randevu Al Butonu
            Center(
              child: ElevatedButton(
                onPressed: selectedSlots.isEmpty && selectedClasses.isEmpty
                    ? null
                    : () {
                  _showConfirmationDialog(context);
                },
                child: Text('Randevu Al'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Onay diyaloğunu göstermek için bir yöntem
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Randevu Onayı'),
          content: Text(
            'Seçtiğiniz çalışma saatleri:\n\n${selectedSlots.join("\n")}\n\n'
                'Seçtiğiniz boş sınıflar:\n\n${selectedClasses.join("\n")}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('İptal'),
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

  // Başarılı işlem için Snackbar gösterimi
  void _showSuccessSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        'Randevular başarıyla alındı!',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // Seçimleri temizleme
    setState(() {
      selectedSlots.clear();
      selectedClasses.clear();
    });
  }
}

// Bölüm Başlığı Widget'ı
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
    );
  }
}
