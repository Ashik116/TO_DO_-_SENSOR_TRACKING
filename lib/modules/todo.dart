class Todo {
  int? id;
  String title;
  String details;
  DateTime dueDate;
  bool isCompleted;

  Todo({
    this.id,
    required this.title,
    required this.details,
    required this.dueDate,
    this.isCompleted = false,
  });

  // Convert a Todo into a Map. The keys must correspond to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'dueDate': dueDate.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  // Convert a Map into a Todo
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      details: map['details'],
      dueDate: DateTime.parse(map['dueDate']),
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
