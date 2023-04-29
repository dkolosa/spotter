import 'package:flutter/material.dart';

class ExerciseView extends StatefulWidget {
  ExerciseView({super.key});

  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

var exerciseList = <String>["Test1"];

class _ExerciseViewState extends State<ExerciseView> {
  String label = "";

  String name = "";
  String reps = "";
  String sets = "";
  String weight = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spotter Exercises"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[for (var item in exerciseList) Text(item)],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Map<int, String>? resultLabel = await _showTextInputDialog(context);
          if (resultLabel != null) {
            setState(() {
              label =
                  "Name: ${resultLabel[0]} Weight: ${resultLabel[1]} Sets: ${resultLabel[2]} Reps: ${resultLabel[3]}";
              exerciseList.add(label);
            });
          }
        },
      ),
    );
  }

  final _textFieldControllerName = TextEditingController();
  final _textFieldControllerSet = TextEditingController();
  final _textFieldControllerReps = TextEditingController();
  final _textFieldControllerWeight = TextEditingController();

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
                    3: _textFieldControllerReps.text
                  }),
                },
              ),
            ],
          );
        });
  }
}
