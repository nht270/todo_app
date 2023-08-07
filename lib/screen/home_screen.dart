import 'package:flutter/material.dart';
import 'package:todo_app/modal/todo.dart';
import 'package:todo_app/screen/edit_todo_screen.dart';
import 'package:todo_app/store.dart';
import 'package:todo_app/widget/todo_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    Store.getTodos().then((todos) {
      setState(() {
        _todos.addAll(todos);
      });
    });
  }

  _handleOpenTodoScreen(BuildContext context, [Todo? todo]) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditTodoScreen(
          todo: todo,
          onSave: _handleSaveTodo,
        ),
      ),
    );
  }

  _handleSaveTodo(Todo newTodo) {
    if (newTodo.isEmpty) {
      return;
    }

    setState(() {
      final indexOfTodo = _todos.indexWhere((todo) => todo.id == newTodo.id);

      if (indexOfTodo < 0) {
        _todos.add(newTodo);
      } else {
        _todos.removeAt(indexOfTodo);
        _todos.insert(indexOfTodo, newTodo);
      }

      Store.saveTodos(_todos);
    });

    _handleBack();
  }

  _handleBack() {
    Navigator.pop(context);
  }

  _handleDeleteTodo(Todo todoDelete) {
    setState(() {
      _todos.removeWhere((todo) => todo.id == todoDelete.id);
      Store.saveTodos(_todos);
    });

    _handleBack();
  }

  _handleWarningDeleteTodo(Todo todo) {
    final cancelButton = TextButton(
      onPressed: () => _handleBack(),
      child: const Text('Cancel'),
    );

    final confirmButton = TextButton(
      onPressed: () => _handleDeleteTodo(todo),
      child: const Text('OK'),
    );

    final alert = AlertDialog(
      title: const Text('Delete warning'),
      content: const Text('Do you want delete this todo?'),
      actions: [cancelButton, confirmButton],
    );

    showDialog(context: context, builder: (context) => alert);
  }

  _handleChangeToDo(List<Todo> todos) {
    Store.saveTodos(todos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: _todos.isEmpty
          ? const Center(child: Text('Not have a todo'))
          : TodoList(
              todos: _todos,
              onSaveTodo: _handleSaveTodo,
              onDeleteTodo: _handleWarningDeleteTodo,
              onChangeTodos: _handleChangeToDo,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleOpenTodoScreen(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
