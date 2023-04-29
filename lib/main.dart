import 'package:flutter/material.dart';

import 'calender.dart';
import 'createUser.dart';
import 'exercises.dart';

void main() {
  runApp(Spotter());
}

class Spotter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Spotter",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar:
            AppBar(backgroundColor: Colors.blue, title: const Text("Spotter")),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Today's Routine:")],
        ),
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CalenderView()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.run_circle),
                title: const Text("Exercises"),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ExerciseView()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text("My Profile"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CreateUserView()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
