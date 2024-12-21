import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calendar App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: CalendarHomePage(),
    );
  }
}

class CalendarHomePage extends StatefulWidget {
  @override
  _CalendarHomePageState createState() => _CalendarHomePageState();
}

class _CalendarHomePageState extends State<CalendarHomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<String, List<Map<String, dynamic>>> _events = {};
  DateTime _selectedDate = DateTime.now();
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
    _loadEvents();
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

  Future<void> _saveEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('events', json.encode(_events));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modern Calendar'),
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
                      .toList() ??
                  [];
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.indigoAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.indigo,
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
          'No events for this day.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
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
              "Time: ${DateTime.parse(event['time']).hour.toString().padLeft(2, '0')}:${DateTime.parse(event['time']).minute.toString().padLeft(2, '0')}\n"
              "Participants: ${(event['participants'] as List<String>).join(', ')}\n"
              "Hobbies: ${(event['hobbies'] as List<String>).join(', ')}",
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

  void _showAddEventDialog() {
    TimeOfDay? pickedTime;
    List<String> participants = [];
    List<String> selectedHobbies = [];
    TextEditingController participantController = TextEditingController();
    TextEditingController eventTitleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Add Event'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: eventTitleController,
                  decoration: InputDecoration(hintText: 'Event Title'),
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
                  child: Text('Pick Time'),
                ),
                if (pickedTime != null)
                  Text('Selected Time: ${pickedTime!.format(context)}'),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: participantController,
                        decoration:
                            InputDecoration(hintText: 'Add Participant'),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        if (participantController.text.isNotEmpty) {
                          setState(() {
                            participants.add(participantController.text);
                            participantController.clear();
                          });
                        }
                      },
                    ),
                  ],
                ),
                if (participants.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text('Participants:'),
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
              child: Text('Cancel'),
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
                    SnackBar(
                        content: Text(
                            'Please enter an event title and pick a time.')),
                  );
                }
              },
              child: Text('Add Event'),
            ),
          ],
        ),
      ),
    );
  }
}
