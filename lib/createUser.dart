import 'package:flutter/material.dart';

class CreateUserView extends StatelessWidget {
  const CreateUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User"),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Name"),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: TextField(
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Age"),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Height"),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Weight"),
            ),
          ),
        ],
      ),
    );
  }
}
