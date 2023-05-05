import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:spotter/model.dart';

class ExerciseView extends StatefulWidget {
  ExerciseView({super.key});
  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

var exerciseList = <String>["Test1"];

// var box = Hive.openBox<Exercise>('exerciseBox');

class _ExerciseViewState extends State<ExerciseView> {
  String label = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Spotter Exercises"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  Map<int, String>? resultLabel =
                      await _showTextInputDialog(context);

                  if (resultLabel != null) {
                    _addExercise();
                    setState(() {
                      label =
                          "${resultLabel[0]}   Weight: ${resultLabel[1]}  Sets: ${resultLabel[2]}   Reps: ${resultLabel[3]}";
                      exerciseList.add(label);
                    });
                  }
                },
                child: const Icon(Icons.add),
              ),
            )
          ],
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: exerciseList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: Text('${exerciseList[index]}'),
            );
          },
        ));
  }

  _addExercise() async {
    var exercise = Exercise(
        _textFieldControllerName.text,
        double.parse(_textFieldControllerWeight.text),
        int.parse(_textFieldControllerSet.text),
        int.parse(_textFieldControllerReps.text),
        _textFieldControllerMuscle.text);
    var box = Hive.box<Exercise>('exerciseBox');
    box.add(exercise);
  }

  _getExercise() async {
    var box = Hive.box<Exercise>('exerciseBox');
    var name = box.get('name');
    return name;
  }

  _getExercises() async {
    var box = Hive.box<Exercise>('exerciseBox');
    var allExercies = box.values;
    allExercies.toString();
    print(allExercies);
    return allExercies;
  }

  _updateExercise() async {
    var box = Hive.box<Exercise>('exerciseBox');
  }

  _deleteExercise() async {
    var box = Hive.box<Exercise>('exerciseBox');

    box.delete(_textFieldControllerName.text);
  }

  final _textFieldControllerName = TextEditingController();
  final _textFieldControllerSet = TextEditingController();
  final _textFieldControllerReps = TextEditingController();
  final _textFieldControllerWeight = TextEditingController();
  final _textFieldControllerMuscle = TextEditingController();

  Future<Map<int, String>?> _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Exercise'),
            content: SingleChildScrollView(
              child: ListBody(children: <Widget>[
                TextField(
                  controller: _textFieldControllerName,
                  decoration: const InputDecoration(hintText: "Name"),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _textFieldControllerWeight,
                  decoration: const InputDecoration(hintText: "Weight (lb)"),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _textFieldControllerSet,
                  decoration: const InputDecoration(hintText: "Sets"),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _textFieldControllerReps,
                  decoration: const InputDecoration(hintText: "Reps"),
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _textFieldControllerMuscle,
                  decoration: const InputDecoration(hintText: "Muscle Group"),
                ),
              ]),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () => {
                  Navigator.pop(context, {
                    0: _textFieldControllerName.text,
                    1: _textFieldControllerWeight.text,
                    2: _textFieldControllerSet.text,
                    3: _textFieldControllerReps.text,
                    4: _textFieldControllerMuscle.text,
                  }),
                },
              ),
            ],
          );
        });
  }
}
