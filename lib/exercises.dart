import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:spotter/model.dart';

class ExerciseView extends StatefulWidget {
  ExerciseView({super.key});
  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

// var exerciseList = <String>["Test1"];

// var box = Hive.openBox<Exercise>('exerciseBox');
class _ExerciseViewState extends State<ExerciseView> {
  String label = "";
  // var List<Exercise> exerciseList;
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
                  _deleteExercise();
                  setState(() {});
                },
                child: const Icon(Icons.delete_forever),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  Map<int, String>? resultLabel =
                      await _showTextInputDialog(context);
                  if (resultLabel != null) {
                    _addExercise();
                    setState(() {});
                  }
                },
                child: const Icon(Icons.add),
              ),
            )
          ],
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(3),
          itemCount: _getExercises().length,
          itemBuilder: (BuildContext context, int index) {
            var exerciseList = _getExercises();
            var name = exerciseList.elementAt(index).name;
            var weight = exerciseList.elementAt(index).weight.toString();
            var reps = exerciseList.elementAt(index).sets.toString();
            var sets = exerciseList.elementAt(index).reps.toString();
            return SizedBox(
              height: 50,
              child: Text(
                '${name},   ${weight} lbs,   Sets:${sets},   Reps:${reps}',
                textScaleFactor: 1.5,
                style: const TextStyle(
                  letterSpacing: 1.5,
                ),
              ),
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

  _getExercises() {
    var box = Hive.box<Exercise>('exerciseBox');
    final allExercies = box.values;
    return allExercies;
  }

  _updateExercise() async {
    var box = Hive.box<Exercise>('exerciseBox');
  }

  _deleteExercise() async {
    var box = Hive.box<Exercise>('exerciseBox');
    box.deleteAll(box.keys);
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
