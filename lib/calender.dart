import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:spotter/model.dart';
import 'package:intl/intl.dart';
import 'exercises.dart';
import 'utils.dart';

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
  DBoperations _dBoperations = DBoperations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calender"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                var resultLabel = await _showTextInputDialog(context);
                if (resultLabel != null) {
                  _dBoperations.addExercise(resultLabel.elementAt(0));
                  _clearTextBox();
                  setState(() {});
                }
              },
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TableCalendar(
                firstDay: DateTime.utc(2010),
                lastDay: DateTime.utc(2040),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: _onDaySelected,
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                }),
            const SizedBox(height: 0.8),
            Expanded(
                child: ListView.builder(
              padding: const EdgeInsets.all(2),
              itemCount: _dBoperations.getExercisesForDay(_selectedDay).length,
              itemBuilder: (BuildContext context, int index) {
                var exerciseList =
                    _dBoperations.getExercisesForDay(_selectedDay);
                var name = exerciseList.elementAt(index).name;
                var weight = exerciseList.elementAt(index).weight.toString();
                var sets = exerciseList.elementAt(index).sets.toString();
                var reps = exerciseList.elementAt(index).reps.toString();
                return GestureDetector(
                  onDoubleTap: () async {
                    final exercise = _dBoperations.getExercise(index);
                    _populateTextBoxes(exercise);
                    var updatedValues = await _showTextInputDialog(context);
                    if (updatedValues != null) {
                      _dBoperations.updateExercise(
                          index, updatedValues.elementAt(0));
                      setState(() {});
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(10.0),
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightBlueAccent),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      '$name,  $weight lbs,  Sets:$sets,  Reps:$reps',
                      textScaleFactor: 1.0,
                      style: const TextStyle(
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  final _textFieldControllerName = TextEditingController();
  final _textFieldControllerSet = TextEditingController();
  final _textFieldControllerReps = TextEditingController();
  final _textFieldControllerWeight = TextEditingController();
  final _textFieldControllerMuscle = TextEditingController();

  _showTextInputDialog(BuildContext context) async {
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
                    Exercise(
                        _textFieldControllerName.text,
                        double.parse(_textFieldControllerWeight.text),
                        int.parse(_textFieldControllerSet.text),
                        int.parse(_textFieldControllerReps.text),
                        _textFieldControllerMuscle.text,
                        dateFormat.format(_selectedDay))
                  }),
                },
              ),
            ],
          );
        });
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

  _onDaySelected(selectedDay, focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }
}
