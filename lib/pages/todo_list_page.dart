// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_todo/data/todo_service.dart';
import 'package:flutter_application_todo/pages/todo_page.dart';

import '../models/todo.dart';

class TodoListPage extends StatefulWidget {
  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> todos = [];
  List<Todo> doneTodos = [];

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To `Do'),
        centerTitle: true,
        bottom: TabBar(
          //mainde tabcontroller vermistik burada tablarimizi veriyoruz
          tabs: [
            Tab(
                icon: Icon(
              Icons.check_box_outline_blank,
            )),
            Tab(
              icon: Icon(Icons.check),
            ),
          ],
        ),
      ),
      body: TabBarView(children: [
        getTodoList(todos),
        getTodoList(doneTodos),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TodoPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getTodoList(List<Todo> todos) {
    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(todos[index].title!),
              trailing: Checkbox(
                onChanged: (value) {
                  setState(() {
                    todos[index].isDone = value;
                  });
                },
                value: todos[index].isDone,
              ),
            ),
          );
        });
  }

  loadData() {
    setState(() {
      todos = TodoService.getTodos();
      doneTodos = TodoService.getDoneTodos();
    });
  }
}
