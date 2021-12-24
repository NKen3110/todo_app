import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:todo_app/models/objects/todo.dart';
import 'package:todo_app/services/datasource/database.dart';

class TodoRepository {
  Future<List<Todo>> getAllTodo() async {
    List<Todo> list;
    if (!kIsWeb) {
      final results = await SQLiteDbProvider.instance.get("Todo");
      print("DOneaa - $results");
      list = results.isNotEmpty
          ? results.map((json) => Todo.fromJson(json)).toList()
          : [];
    }

    return list;
  }

  Future<List<Todo>> getTodoByStatus(bool status) async {
    final results =
        await SQLiteDbProvider.instance.getWithParam("Todo", "status", status);
    print("DOneaa - $results");
    List<Todo> list = results.isNotEmpty
        ? results.map((json) => Todo.fromJson(json)).toList()
        : [];

    return list;
  }

  Future<int> createTask(String name, bool statusTask) async {
    final results = await SQLiteDbProvider.instance.create("Todo",
        Todo(name: name, status: statusTask, createdDate: DateTime.now()));
    return results;
  }

  Future<int> updateTask(Todo todo) async {
    Todo newTodo = Todo(
        id: todo.id,
        name: todo.name,
        status: !todo.status,
        createdDate: todo.createdDate);
    final results = await SQLiteDbProvider.instance.update("Todo", newTodo);
    return results;
  }

  Future<int> deleteTask(Todo todo) async {
    final results = await SQLiteDbProvider.instance.delete("Todo", todo);
    return results;
  }
}
