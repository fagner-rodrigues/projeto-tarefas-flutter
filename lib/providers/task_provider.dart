import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> getTasksForDay(DateTime day) {
    // Filtra pelo dia
    final tasksForDay = _tasks.where((task) {
      return task.date.year == day.year &&
          task.date.month == day.month &&
          task.date.day == day.day;
    }).toList();

    // Separa pendentes e concluídas
    final pending = tasksForDay.where((task) => !task.isDone).toList();
    final completed = tasksForDay.where((task) => task.isDone).toList();

    // Ordena alfabeticamente
    pending.sort((a, b) => a.title.compareTo(b.title));
    completed.sort((a, b) => a.title.compareTo(b.title));

    // Junta tudo (Pendentes primeiro)
    return [...pending, ...completed];
  }

  void addTask(String title, DateTime date) {
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      date: date,
    );
    _tasks.add(newTask);
    notifyListeners();
  }

  void toggleTaskStatus(String id) {
    final task = _tasks.firstWhere((t) => t.id == id);
    task.isDone = !task.isDone;
    notifyListeners();
  }

  void removeTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}
