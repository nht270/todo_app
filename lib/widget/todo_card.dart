import 'package:flutter/material.dart';
import 'package:todo_app/modal/todo.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  late final Function(Todo) _handleDelete;
  late final Function(Todo) _handleEdit;
  final ButtonStyle buttonStyle = const ButtonStyle(
    minimumSize: MaterialStatePropertyAll(Size(48, 48)),
    maximumSize: MaterialStatePropertyAll(Size(48, 48)),
  );

  TodoCard(
      {super.key,
      required this.todo,
      Function(Todo)? onDelete,
      Function(Todo)? onEdit}) {
    _handleDelete = onDelete ?? (_) {};
    _handleEdit = onEdit ?? (_) {};
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title.isEmpty ? 'Untitle' : todo.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(todo.content),
                ],
              ),
            ),
            TextButton(
              style: buttonStyle,
              onPressed: () => _handleEdit(todo),
              child: const Icon(Icons.edit),
            ),
            TextButton(
              style: buttonStyle,
              onPressed: () => _handleDelete(todo),
              child: const Icon(Icons.delete),
            ),
            const SizedBox(width: 28),
          ],
        ),
      ),
    );
  }
}
