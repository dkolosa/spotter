import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:spotter/model.dart';
import 'package:intl/intl.dart';

import 'utils.dart';

class ExerciseView extends StatefulWidget {
  ExerciseView({super.key});
  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  String label = "";
  DateFormat dateFormat = DateFormat('M-d-y');
  DBoperations _dbopetations = DBoperations();
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
                _dbopetations.deleteExercise();
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
                  _clearTextBox();
                  setState(() {});
                }
              },
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(2),
        itemCount: _dbopetations.getExercises().length,
        itemBuilder: (BuildContext context, int index) {
          var exerciseList = _dbopetations.getExercises();
          var name = exerciseList.elementAt(index).name;
          var weight = exerciseList.elementAt(index).weight.toString();
          var sets = exerciseList.elementAt(index).sets.toString();
          var reps = exerciseList.elementAt(index).reps.toString();
          var date = exerciseList.elementAt(index).date;
          return GestureDetector(
            onDoubleTap: () async {
              var exercise = _dbopetations.getExercise(index);
              _populateTextBoxes(exercise);
              var updatedValues = await _showTextInputDialog(context);
              if (updatedValues != null) {
                _updateExercise(index, updatedValues);
                setState(() {});
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              // width: 150,
              height: 50,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlueAccent),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Text(
                '$name,  $weight lbs,  Sets:$sets,  Reps:$reps, $date',
                textScaleFactor: 1.0,
                style: const TextStyle(
                  letterSpacing: 1.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _clearTextBox() {
    _textFieldControllerName.clear();
    _textFieldControllerWeight.clear();
    _textFieldControllerSet.clear();
    _textFieldControllerReps.clear();
    _textFieldControllerMuscle.clear();
  }

  _populateTextBoxes(Exercise exercise) {
    _textFieldControllerName.text = exercise.name;
    _textFieldControllerWeight.text = exercise.weight.toString();
    _textFieldControllerSet.text = exercise.sets.toString();
    _textFieldControllerReps.text = exercise.reps.toString();
  }

  _addExercise() {
    var exercise = Exercise(
        _textFieldControllerName.text,
        double.parse(_textFieldControllerWeight.text),
        int.parse(_textFieldControllerSet.text),
        int.parse(_textFieldControllerReps.text),
        _textFieldControllerMuscle.text,
        dateFormat.format(DateTime.now()));
    var box = Hive.box<Exercise>('exerciseBox');
    box.add(exercise);
  }

  // _getExercise(exerciseID) {
  //   var box = Hive.box<Exercise>('exerciseBox');
  //   var exercise = box.getAt(exerciseID);
  //   return exercise;
  // }

  // _getExercises() {
  //   var box = Hive.box<Exercise>('exerciseBox');
  //   final allExercies = box.values;
  //   return allExercies;
  // }

  // _getExercisesForDay(selectedDate) {
  //   var box = Hive.box<Exercise>('exerciseBox');
  //   var formattedDate = dateFormat.format(selectedDate);
  //   var fileredExercises =
  //       box.values.where((exercise) => exercise.date.contains(formattedDate));
  //   return fileredExercises;
  // }

  _updateExercise(index, updatedValues) async {
    var box = Hive.box<Exercise>('exerciseBox');

    var updatedExercise = Exercise(
      updatedValues[0],
      double.parse(updatedValues[1]),
      int.parse(updatedValues[2]),
      int.parse(updatedValues[3]),
      updatedValues[4],
      dateFormat.format(DateTime.now()),
    );
    box.putAt(index, updatedExercise);
  }

  // _deleteExercise() {
  //   var box = Hive.box<Exercise>('exerciseBox');
  //   box.deleteAll(box.keys);
  // }

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
