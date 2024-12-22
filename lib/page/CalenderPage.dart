import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Takvim',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: CalendarHomePage(),
    );
  }
}

class CalendarHomePage extends StatefulWidget {
  const CalendarHomePage({super.key});

  @override
  _CalendarHomePageState createState() => _CalendarHomePageState();
}

class _CalendarHomePageState extends State<CalendarHomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<String, List<Map<String, dynamic>>> _events = {};
  DateTime _selectedDate = DateTime.now();
  List<String> hobbies = [
    "Reading", "Gaming", "Programming", "Swimming", "Traveling",
    "Music", "Photography", "Cooking", "Drawing", "Sports", "Writing", "Dancing"
  ];
  List<String> participants = [];
  List<String> selectedHobbies = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
    _loadParticipants();
  }

  Future<void> _loadEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEvents = prefs.getString('events');
    if (storedEvents != null) {
      setState(() {
        _events = Map<String, List<Map<String, dynamic>>>.from(
          json.decode(storedEvents) as Map<String, dynamic>,
        );
      });
    }
  }

  Future<void> _loadParticipants() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedParticipants = prefs.getString('participants');
    if (storedParticipants != null) {
      setState(() {
        participants = List<String>.from(json.decode(storedParticipants));
      });
    }
  }

  Future<void> _saveEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('events', json.encode(_events));
  }

  Future<void> _saveParticipants() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('participants', json.encode(participants));
  }

  void _addEvent(String eventTitle, DateTime fullDate,
      List<String> participants, List<String> hobbies) {
    String dateKey = fullDate.toIso8601String().split('T')[0];
    if (_events[dateKey] == null) {
      _events[dateKey] = [];
    }
    setState(() {
      _events[dateKey]!.add({
        'title': eventTitle,
        'time': fullDate.toIso8601String(),
        'participants': participants,
        'hobbies': hobbies
      });
    });
    _saveEvents();
  }

  void _removeEvent(String dateKey, int index) {
    setState(() {
      _events[dateKey]?.removeAt(index);
    });
    _saveEvents();
  }

  void _showAddParticipantsDialog(BuildContext context) {
    List<String> friends = [
      "Ali", "Bora", "Ceyda"
    ]; // Replace with dynamic friend list if needed
    List<String> selectedParticipants = [];
    TextEditingController searchController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Arkadaşlar Ekle',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Arkadaş Ara',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: selectedParticipants.map((participant) {
                  return Chip(
                    label: Text(participant),
                    onDeleted: () {
                      setState(() {
                        selectedParticipants.remove(participant);
                      });
                    },
                  );
                }).toList(),
              ),
              Expanded(
                child: ListView(
                  children: friends
                      .where((friend) =>
                      friend
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase()))
                      .map(
                        (friend) => ListTile(
                      title: Text(friend),
                      trailing: IconButton(
                        icon: Icon(
                          selectedParticipants.contains(friend)
                              ? Icons.check_circle
                              : Icons.add_circle,
                          color: selectedParticipants.contains(friend)
                              ? Colors.green
                              : Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            if (selectedParticipants.contains(friend)) {
                              selectedParticipants.remove(friend);
                            } else {
                              selectedParticipants.add(friend);
                            }
                          });
                        },
                      ),
                    ),
                  )
                      .toList(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, selectedParticipants);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Text(
                    'Ekle',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).then((selected) {
      if (selected != null && selected is List<String>) {
        setState(() {
          participants = selected;
        });
        _saveParticipants();
      }
    });
  }

  void _showAddEventDialog() {
    TimeOfDay? pickedTime;
    List<String> selectedHobbies = [];
    TextEditingController eventTitleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Etkinlik Ekle.'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: eventTitleController,
                  decoration: InputDecoration(hintText: 'Etkinlik Adı'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {});
                  },
                  child: Text('Zaman Seçin'),
                ),
                if (pickedTime != null)
                  Text('Zaman: ${pickedTime!.format(context)}'),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _showAddParticipantsDialog(context);
                  },
                  child: Text('Katılımcıları Ekle'),
                ),
                if (participants.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text('Katılımcılar:'),
                      ...participants.map((p) => Text('- $p')),
                    ],
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
                      selectedColor: Colors.indigo,
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
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                String eventTitle = eventTitleController.text;
                if (pickedTime != null && eventTitle.isNotEmpty) {
                  DateTime eventDateTime = DateTime(
                    _selectedDate.year,
                    _selectedDate.month,
                    _selectedDate.day,
                    pickedTime!.hour,
                    pickedTime!.minute,
                  );
                  _addEvent(
                      eventTitle, eventDateTime, participants, selectedHobbies);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Etkinlik ve zaman gir.')),
                  );
                }
              },
              child: Text('Etkinlik Ekle'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Takvim'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDate,
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            eventLoader: (day) {
              String dateKey = day.toIso8601String().split('T')[0];
              return _events[dateKey]
                  ?.map((event) => event['title'])
                  .toList() ?? [];
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.orange.shade100,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildEventList() {
    String dateKey = _selectedDate.toIso8601String().split('T')[0];
    List events = _events[dateKey] ?? [];

    if (events.isEmpty) {
      return Center(
        child: Text(
          'Bugün için etkinlik yok.',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      );
    }

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        var event = events[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            title: Text(event['title']),
            subtitle: Text(
              "Zaman: ${DateTime.parse(event['time']).hour.toString().padLeft(2, '0')}:${DateTime.parse(event['time']).minute.toString().padLeft(2, '0')}\n"
                  "Katılımcılar: ${(event['participants'] as List<String>).join(', ')}\n"
                  "Hobiler: ${(event['hobbies'] as List<String>).join(', ')}",
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.indigo),
              onPressed: () => _removeEvent(dateKey, index),
            ),
          ),
        );
      },
    );
  }
}
