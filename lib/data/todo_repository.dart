import 'dart:math';

import 'package:hello_bloc/models/todo.dart';

abstract class TodoRepository {
  Future<Todo> fetchTodo();
  Future<Todo> fetchDetailedTodo(String name);
}

class TodoImpRepository implements TodoRepository {
  double cachedTempCelsius;

  @override
  Future<Todo> fetchTodo() {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
      () {
        
        // Return "fetched" weather
        return Todo(
          name: "Hello Indy",
          detail: "สวัสดี อินดี้ ลูฟี่"
        );
      },
    );
  }

  @override
  Future<Todo> fetchDetailedTodo(String name) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return Todo(
          name: name,
          detail: "บ้าไปแล้ว"
        );
      },
    );
  }
}

class NetworkError extends Error {}
