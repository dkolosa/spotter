import 'package:flutter/material.dart';
import 'main.dart';

class ExerciseView extends StatelessWidget {
  ExerciseView({super.key});
  String? label = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spotter Exercises"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var resultLabel = await _showTextInputDialog(context);
          if (resultLabel != null) {
            label = resultLabel;
          }
        },
      ),
    );
  }

  final _textFieldController = TextEditingController();

  Future<String?> _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Exercise'),
            content: SingleChildScrollView(
              child: ListBody(children: <Widget>[
                TextField(
                  controller: _textFieldController,
                  decoration: const InputDecoration(hintText: "Name"),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _textFieldController,
                  decoration: const InputDecoration(hintText: "Weight (lb)"),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _textFieldController,
                  decoration: const InputDecoration(hintText: "Sets"),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _textFieldController,
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
                onPressed: () =>
                    Navigator.pop(context, _textFieldController.text),
              ),
            ],
          );
        });
  }
}
