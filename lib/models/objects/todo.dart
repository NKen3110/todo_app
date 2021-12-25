const String tableTodo = "Todo";

class TodoFields {
  static const String id = "id";
  static const String name = "name";
  static const String status = "status";
  static const String createdDate = "createdDate";
}

class Todo {
  final int id;
  final String name;
  final bool status;
  final DateTime createdDate;

  Todo({this.id, this.name, this.status, this.createdDate});

  factory Todo.fromJson(Map<String, dynamic> data) {
    return Todo(
      id: data['id'] as int,
      name: data['name'] as String,
      status: data['status'] == '1',
      createdDate: DateTime.parse(data['createdDate'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        TodoFields.id: id,
        TodoFields.name: name,
        TodoFields.status: status ? '1' : '0',
        TodoFields.createdDate: createdDate.toIso8601String(),
      };
}
