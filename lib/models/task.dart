class Task {
  final int? id;
  final String title;
  final DateTime  date;
  bool completed;

  Task({
    required this.id,
    required this.title, 
    required this.date, 
    this.completed = false,
  });

    // Convierte Task a Map para guardar en SQLite
  Map<String, dynamic> toMap() {
    return { 
      'title': title,
      'completed': completed ? 1 : 0, 
      'date_in':  date.toIso8601String(), 
    };
  }

  // Convierte Map de SQLite a Task
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id:  map['id'] ,
      title: map['title'],
      completed: map['completed'] == 1,
      date: DateTime.parse(map['date_in'])
    );
  }
}