import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:spotter/model.dart';

import 'calender.dart';
import 'createUser.dart';
import 'exercises.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Exercise>(ExerciseAdapter());
  await Hive.openBox<Exercise>('exerciseBox');
  // await Hive.openBox('userBox');
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Today's Routine:",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {)},
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
