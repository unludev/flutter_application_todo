// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/todo.dart';

class TodoService {
  static TodoService instance = TodoService._internal();
  TodoService._internal();
  factory TodoService() {
    return instance;
  }

  Future<List<Todo>> getTodos(bool isDone) async {
    final mapList = await getTodoMaps();
    final List<Todo> todoList = [];

    for (var element in mapList) {
      todoList.add(Todo.fromMap(element));
    }

    if (isDone) {
      return todoList.where((element) => !element.isDone!).toList();
    }

    return todoList.where((element) => element.isDone!).toList();
  }

  Future<List<Map<String, dynamic>>> getTodoMaps() async {
    Database? db = await this.db;
    return await db!.query('todos');
  }

  Database? _db;

  Future<Database?> get db async {
    _db ??= await _initDb();
    return _db;
  }

  Future<Database?> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'todo.db';
    final todoDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return todoDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT,' // id kendi kendine artacak
        'title TEXT, description TEXT, isDone INT)');
  }

  Future<int> addTodo(Todo todo) async {
    Database? db = await this.db;
    return await db!.insert('todos', todo.toMap());
  }

  Future<int> updateIsDone(Todo todo) async {
    Database? db = await this.db;
    return await db!
        .update('todos', todo.toMap(), where: 'id=?', whereArgs: [todo.id]);
  }

  Future<int> delete(Todo todo) async {
    Database? db = await this.db;
    return await db!.delete('todos', where: 'id=?', whereArgs: [todo.id]);
  }
}
