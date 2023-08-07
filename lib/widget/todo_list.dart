import 'package:flutter/material.dart';
import 'package:todo_app/modal/todo.dart';
import 'package:todo_app/screen/edit_todo_screen.dart';
import 'package:todo_app/widget/todo_card.dart';

class TodoList extends StatefulWidget {
  final List<Todo> todos;
  late final Function(List<Todo>) _handleChangeTodos;
  late final Function(Todo) _handleSaveTodo;
  late final Function(Todo) _handleDeleteTodo;

  TodoList({
    super.key,
    required this.todos,
    Function(Todo)? onSaveTodo,
    Function(Todo)? onDeleteTodo,
    Function(List<Todo>)? onChangeTodos,
  }) {
    _handleSaveTodo = onSaveTodo ?? (_) {};
    _handleDeleteTodo = onDeleteTodo ?? (_) {};
    _handleChangeTodos = onChangeTodos ?? (_) {};
  }

  @override
  State<StatefulWidget> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  _handleReoder(oldIndex, newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex--;
      }
      final todo = widget.todos.removeAt(oldIndex);
      widget.todos.insert(newIndex, todo);
      widget._handleChangeTodos(widget.todos);
    });
  }

  _handleOpenTodoScreen(BuildContext context, Todo todo) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditTodoScreen(
          todo: todo,
          onSave: widget._handleSaveTodo,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      onReorder: _handleReoder,
      children: widget.todos
          .map((todo) => TodoCard(
                key: Key(todo.id),
                todo: todo,
                onEdit: (todo) => _handleOpenTodoScreen(context, todo),
                onDelete: widget._handleDeleteTodo,
              ))
          .toList(),
    );
  }
}
