import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.orange,
        primaryColor: Colors.indigo.shade100,
      ),
      home: FriendsPage(),
    );
  }
}

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  List<Map<String, String>> friends = [
    {'name': 'Ali', 'status': 'Online'},
    {'name': 'Bora', 'status': 'Uzakta'},
    {'name': 'Ceyda', 'status': 'Offline'},
  ];

  String? selectedFriend;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Arkadaşlar',
          textAlign: TextAlign.start,
        ),
        backgroundColor: Colors.indigo.shade300,
      ),
      body: Row(
        children: [
          // Friends List
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[300],
              child: ListView.builder(
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  final friend = friends[index];
                  return ListTile(
                    title: Text(
                      friend['name']!,
                      style: TextStyle(color: Colors.grey.shade900),
                    ),
                    subtitle: Text(
                      friend['status']!,
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    leading: CircleAvatar(
                      child: Text(friend['name']![0]),
                      backgroundColor: Colors.orange.shade600,
                    ),
                    onTap: () {
                      setState(() {
                        selectedFriend = friend['name'];
                      });
                    },
                    selected: selectedFriend == friend['name'],
                    selectedTileColor: Colors.grey.shade900,
                  );
                },
              ),
            ),
          ),

          // Chat Panel
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey.shade200,
              child: selectedFriend == null
                  ? Center(
                      child: Text(
                        'Select a friend to chat with',
                        style: TextStyle(color: Colors.black54),
                      ),
                    )
                  : Column(
                      children: [
                        // Chat Header
                        Container(
                          padding: EdgeInsets.all(16.0),
                          color: Colors.indigo.shade200,
                          child: Row(
                            children: [
                              CircleAvatar(
                                child: Text(selectedFriend![0]),
                                backgroundColor: Colors.orange.shade600,
                              ),
                              SizedBox(width: 10),
                              Text(
                                selectedFriend!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Messages List
                        Expanded(
                          child: ListView(
                            children: [
                              ListTile(
                                title: Text(
                                  'Hello!',
                                  style: TextStyle(color: Colors.grey.shade900),
                                ),
                                subtitle: Text(
                                  '10:00 AM',
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  'Hi there!',
                                  style: TextStyle(color: Colors.grey.shade900),
                                ),
                                subtitle: Text(
                                  '10:05 AM',
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Message Input
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Mesaj yaz...',
                                    hintStyle: TextStyle(color: Colors.black54),
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Send message logic
                                },
                                icon: Icon(Icons.send,
                                    color: Colors.deepOrangeAccent),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
