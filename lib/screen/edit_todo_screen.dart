import 'package:flutter/material.dart';
import 'package:todo_app/modal/todo.dart';
import 'package:todo_app/widget/todo_form.dart';

class EditTodoScreen extends StatelessWidget {
  late final Todo todo;
  late final Function(Todo) _handleSave;

  EditTodoScreen({super.key, Todo? todo, Function(Todo)? onSave}) {
    this.todo = todo ?? Todo();
    this._handleSave = onSave ?? (_) {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),
      body: TodoForm(todo: todo),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleSave(todo),
        child: const Icon(Icons.save),
      ),
    );
  }
}
