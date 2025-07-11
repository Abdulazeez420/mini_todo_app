class TaskModel {
  int? id;
  String title;
  String? description;
  String date;
  bool isDone;

  TaskModel({
    this.id,
    required this.title,
    this.description,
    required this.date,
    this.isDone = false,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) => TaskModel(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        date: map['date'],
        isDone: map['isDone'] == 1,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'date': date,
        'isDone': isDone ? 1 : 0,
      };

  /// ✅ Add this method to support `copyWith`
  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    String? date,
    bool? isDone,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
    );
  }
}
