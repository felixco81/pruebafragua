import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:test_app/models/task.dart';
import '../models/task.dart';
import 'package:uuid/uuid.dart';
import '../services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final taskService = TaskService();

  late List<Task> _tasks = [];

  List<Task> get tasks => List.unmodifiable(_tasks);

  int get selectedCount => _tasks.where((t) => t.completed).length;

  Future<void> loadTasks() async {
    print("CARGADO DATA.....");
    _tasks = await taskService.getTasks();
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    final task = Task(id: null, title: title, date: DateTime.now());
    await taskService.addTask(task);
    await loadTasks();
    notifyListeners();
  }

   Future<void>    toggleTask(int id) async {
    final task = _tasks.firstWhere((t) => t.id == id);
    task.completed = !task.completed;
     await taskService.setCompletedTask(task.id ?? 0 , task.completed);
    notifyListeners();
  }

  Future<void> removeTask(int id) async {
    await taskService.deleteTask(id);
     await loadTasks();
    notifyListeners();
  }

   Future<void> clearCompleted() async {
   var ids =  _tasks.where((t) => t.completed).map((t)=>t.id!).toList();
     await taskService.deleteSelectedTasks(ids);
     await loadTasks();
    notifyListeners();
  }
}
