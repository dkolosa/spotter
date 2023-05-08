import 'package:hive_flutter/adapters.dart';
import 'package:spotter/model.dart';
import 'package:intl/intl.dart';

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
