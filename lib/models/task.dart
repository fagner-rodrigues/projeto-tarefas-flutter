class Task {
  String id;
  String title;
  DateTime date;
  bool isDone;

  Task({
    required this.id,
    required this.title,
    required this.date,
    this.isDone = false,
  });
}
