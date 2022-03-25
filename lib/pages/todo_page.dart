// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  final titleField = TextFormField(
    decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
  );
  final descriptionField = TextFormField(
    maxLines: 5,
    decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
  );
  final saveButton = ElevatedButton(onPressed: () {}, child: Text('Save'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New To Do'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: titleField,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: descriptionField,
          ),
          saveButton,
        ],
      ),
    );
  }
}
