import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(Spotter());
}

class Spotter extends StatelessWidget {
  Spotter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar:
            AppBar(backgroundColor: Colors.blue, title: const Text("Spotter")),
        body: CalenderView(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {print("Pressed!")},
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text("Menu"),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text("Today"),
                onTap: () {
                  print("goto main");
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_month),
                title: const Text("Calander"),
                onTap: () {
                  print("goto Calander");
                },
              ),
              ListTile(
                leading: const Icon(Icons.run_circle),
                title: const Text("Exercises"),
                onTap: () {
                  print("goto Excersies");
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text("Profile"),
                onTap: () {
                  print("goto Profile");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CalenderView extends StatefulWidget {
  CalenderView({
    super.key,
  });

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  DateTime _focusedDay = DateTime.now();

  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
