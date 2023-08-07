class Todo {
  late final String id;
  String title;
  String content;

  Todo({String? id, this.content = '', this.title = ''}) {
    this.id = id ?? DateTime.now().millisecond.toString();
  }

  bool get isEmpty {
    return title.isEmpty && content.isEmpty;
  }

  factory Todo.fromJson(Map json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'content': content};
}
