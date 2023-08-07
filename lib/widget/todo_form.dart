import 'package:flutter/material.dart';
import 'package:todo_app/modal/todo.dart';

class TodoForm extends StatelessWidget {
  late final Todo todo;
  final titleTextStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  TodoForm({super.key, Todo? todo}) : this.todo = todo ?? Todo();

  _handleChangeTitle(String title) {
    todo.title = title;
  }

  _handleChangeContent(String content) {
    todo.content = content;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          TextFormField(
            initialValue: todo.title,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Type your title',
              hintStyle: titleTextStyle.merge(
                TextStyle(color: Colors.grey.shade300),
              ),
            ),
            style: titleTextStyle,
            onChanged: _handleChangeTitle,
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'Type something'),
            maxLines: null,
            initialValue: todo.content,
            onChanged: _handleChangeContent,
          ),
        ],
      ),
    );
  }
}
