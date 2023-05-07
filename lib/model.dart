import 'dart:ffi';

import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 1)
class Exercise {
  @HiveField(0)
  String name = "";

  @HiveField(1)
  double weight;

  @HiveField(2)
  int reps;

  @HiveField(3)
  int sets;

  @HiveField(4)
  String muscleGroups = "";

  @HiveField(5)
  String date = "";

  Exercise(
    this.name,
    this.weight,
    this.sets,
    this.reps,
    this.muscleGroups,
    this.date,
  );
}

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  String name = "";

  @HiveField(2)
  int age = 0;

  @HiveField(3)
  Float weight;

  @HiveField(4)
  List<Exercise> exercises;

  User(this.name, this.age, this.weight, this.exercises);
}
