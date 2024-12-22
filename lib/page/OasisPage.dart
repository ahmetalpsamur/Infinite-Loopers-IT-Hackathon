import 'package:flutter/material.dart';

class OasisPage extends StatelessWidget {
  const OasisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Oasis 2.0',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Sınav Tarihleri'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Ödevler'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Progress Cards
            Row(
              children: [
                Expanded(
                  child: _buildProgressCard(
                    title: 'Başarılı Olduğunuz Ders Adedi',
                    value: 37 / 45,
                    text: '37 of 45',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildProgressCard(
                    title: 'Mevcut AKTS',
                    value: 226 / 240,
                    text: '226 of 240',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Weekly Schedule
            _buildSectionHeader('Haftalık Ders Programı'),
            const SizedBox(height: 10),
            _buildTable(),

            const SizedBox(height: 20),

            // Upcoming Exams
            _buildColoredContainer(
              title: 'Yaklaşan Sınavlar',
              items: [
                _buildListTile(
                  icon: Icons.event,
                  color: Colors.orange,
                  title: 'Math 101 - 25th Dec 2024',
                  subtitle: 'Time: 10:00 AM',
                ),
                _buildListTile(
                  icon: Icons.event,
                  color: Colors.orange,
                  title: 'Physics 202 - 27th Dec 2024',
                  subtitle: 'Time: 2:00 PM',
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Assignment Deadlines
            _buildColoredContainer(
              title: 'Yaklaşan Ödevler',
              items: [
                _buildListTile(
                  icon: Icons.assignment,
                  color: Colors.green,
                  title: 'Essay on AI - 23rd Dec 2024',
                  subtitle: 'Submit via portal',
                ),
                _buildListTile(
                  icon: Icons.assignment,
                  color: Colors.green,
                  title: 'Group Project - 30th Dec 2024',
                  subtitle: 'Submit presentation slides',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard({
    required String title,
    required double value,
    required String text,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            CircularProgressIndicator(
              value: value,
              backgroundColor: Colors.grey[200],
              color: Colors.orange,
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.orange,
      ),
    );
  }

  Widget _buildTable() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          border: TableBorder.all(color: Colors.grey),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.orange[50]),
              children: const [
                Center(child: Text('Pzt')),
                Center(child: Text('Sal')),
                Center(child: Text('Çar')),
                Center(child: Text('Per')),
                Center(child: Text('Cum')),
              ],
            ),
            const TableRow(
              children: [
                Center(child: Text('SE 115')),
                Center(child: Text('SE 116')),
                Center(child: Text('SE 117')),
                Center(child: Text('')),
                Center(child: Text('')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColoredContainer({
    required String title,
    required List<Widget> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(height: 10),
          ...items,
        ],
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
