import 'package:flutter/material.dart';

class OasisPage extends StatelessWidget {
  const OasisPage({super.key});

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
