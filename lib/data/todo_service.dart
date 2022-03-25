import '../models/todo.dart';

class TodoService {
  static List<Todo> todos = [];

  static List<Todo> getTodos() {
    if (todos.isEmpty) {
      todos.add(Todo(
          id: 1,
          title: 'Kitap Oku',
          description: 'Enaz 50 syf',
          isDone: false));
      todos.add(Todo(
          id: 2, title: 'Spor Yap', description: 'Enaz 10 syf', isDone: false));
      todos.add(Todo(
          id: 3,
          title: 'cay ic',
          description: 'Enfdsfz 530 syf',
          isDone: false));
      todos.add(Todo(
          id: 4, title: 'temixlik', description: 'Edsfdsyf', isDone: false));
      todos.add(
          Todo(id: 5, title: 'ders', description: 'fdsafdyf', isDone: true));
    }
    return todos.where((element) => !element.isDone!).toList();
  }

  static List<Todo> getDoneTodos() {
    return todos.where((element) => element.isDone!).toList();
  }
}
