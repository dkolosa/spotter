import 'package:hive_flutter/adapters.dart';
import 'package:spotter/model.dart';
import 'package:intl/intl.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

DateFormat dateFormat = DateFormat('M-d-y');

class DBoperations {
  Iterable<Exercise> getExercisesForDay(selectedDay) {
    var box = Hive.box<Exercise>('exerciseBox');
    var formattedDate = dateFormat.format(selectedDay);
    var fileredExercises =
        box.values.where((exercise) => exercise.date.contains(formattedDate));
    return fileredExercises;
  }

  getExercise(exerciseID) {
    var box = Hive.box<Exercise>('exerciseBox');
    var exercise = box.getAt(exerciseID);
    return exercise;
  }

  Iterable<Exercise> getExercises() {
    var box = Hive.box<Exercise>('exerciseBox');
    final allExercies = box.values;
    return allExercies;
  }

  void addExercise(exercise) {
    var box = Hive.box<Exercise>('exerciseBox');
    box.add(exercise);
  }

  void deleteAllExercises() {
    var box = Hive.box<Exercise>('exerciseBox');
    box.deleteAll(box.keys);
  }

  void deleteExercise(index) {
    var box = Hive.box<Exercise>('exerciseBox');
    box.deleteAt(index);
  }

  void updateExercise(index, updatedValues) async {
    var box = Hive.box<Exercise>('exerciseBox');

    box.putAt(index, updatedValues);
  }
}

void export_data() {
  var db_ops = DBoperations();
  var exercises = db_ops.getExercises();

  _writeFile(exercises);
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  var today = DateTime.now();
  var filename = '$path/Spotter-export-$today.csv';
  return File(filename);
}

void _writeFile(Iterable<Exercise> exercises) async {
  final file = await _localFile;

  var sink = file.openWrite();

  sink.writeln('exercise, weight, sets, reps, date');
  for (var exercise in exercises) {
    sink.writeln(
        '${exercise.name}, ${exercise.weight}, ${exercise.sets}, ${exercise.reps}, ${exercise.date}');
  }
  sink.close();
}
