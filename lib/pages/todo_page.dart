// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_todo/data/todo_service.dart';

import '../models/todo.dart';

class TodoPage extends StatelessWidget {
  TodoService todoService = TodoService.instance;
  final titleController = TextEditingController();
  final desController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final titleField = TextFormField(
      controller: titleController,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
    final descriptionField = TextFormField(
      controller: desController,
      maxLines: 5,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
    final saveButton = ElevatedButton(
        onPressed: () {
          todoService
              .addTodo(Todo(
                  id: null,
                  title: titleController.text,
                  description: desController.text,
                  isDone: false))
              .then((value) => Navigator.pop(context));
        },
        child: Text('Save'));

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
