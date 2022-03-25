// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_todo/data/todo_service.dart';
import 'package:flutter_application_todo/pages/todo_page.dart';

import '../models/todo.dart';
import 'todo_detail.dart';

class TodoListPage extends StatefulWidget {
  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  TodoService service = TodoService.instance;
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
                  context, MaterialPageRoute(builder: (context) => TodoPage()))
              .then((value) => loadData());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getTodoList(List<Todo> todos) {
    return todos.isEmpty
        ? Center(child: Text('Liste Bos'))
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(todos[index].title!),
                  subtitle: Text(todos[index].description!),
                  onTap: () {
                    goToDetail(todos[index]);
                  },
                  trailing: Checkbox(
                    onChanged: (value) {
                      todos[index].isDone = value;
                      service
                          .updateIsDone(todos[index])
                          .then((value) => loadData());
                    },
                    value: todos[index].isDone,
                  ),
                ),
              );
            });
  }

  loadData() {
    service.getTodos(true).then((value) {
      setState(() {
        todos = value;
      });
    });
    service.getTodos(false).then((value) {
      setState(() {
        doneTodos = value;
      });
    });
  }

  void goToDetail(Todo todo) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TodoDetail(todo)));
    if (result != null) {
      if (result) {
        loadData();
      }
    }
  }
}
