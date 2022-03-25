// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../data/todo_service.dart';
import '../models/todo.dart';

class TodoDetail extends StatefulWidget {
  Todo todo;
  TodoDetail(this.todo);
  @override
  State<TodoDetail> createState() => _TodoDetailState(this.todo);
}

enum Options { delete, update }

class _TodoDetailState extends State<TodoDetail> {
  Todo todo;
  _TodoDetailState(this.todo);
  TodoService service = TodoService.instance;
  final titleController = TextEditingController();
  final desController = TextEditingController();

  @override
  void initState() {
    titleController.text = todo.title!;
    desController.text = todo.description!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit : ${todo.title}'),
      ),
      body: buildTodDetail(),
    );
  }

  buildTodDetail() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: titleField(),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: descriptionField(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            updateButton(),
            deleteButton(),
          ],
        ),
      ],
    );
  }

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await service.delete(Todo(id: todo.id));
        Navigator.pop(context, true);
        break;
      case Options.update:
        await service.updateIsDone(Todo(
            id: todo.id,
            title: titleController.text,
            description: desController.text,
            isDone: todo.isDone));
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  Widget titleField() {
    return TextFormField(
      controller: titleController,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
  }

  descriptionField() {
    return TextFormField(
      controller: desController,
      maxLines: 5,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
  }

  deleteButton() {
    return ElevatedButton(
        onPressed: () {
          selectProcess(Options.delete);
        },
        child: Text('Delete'));
  }

  updateButton() {
    return ElevatedButton(
        onPressed: () {
          selectProcess(Options.update);
        },
        child: Text('Update'));
  }
}
