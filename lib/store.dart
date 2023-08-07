import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/modal/todo.dart';

const STORAGE_KEY = 'todos';

class Store {
  static Future<List<Todo>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonText = prefs.getString(STORAGE_KEY);

    if (jsonText == null || jsonText.isEmpty) {
      return [];
    }

    final List objectsJson = jsonDecode(jsonText);
    final List<Todo> todos =
        objectsJson.map((objectJson) => Todo.fromJson(objectJson)).toList();
    return todos;
  }

  static saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(STORAGE_KEY, jsonEncode(todos));
  }
}
