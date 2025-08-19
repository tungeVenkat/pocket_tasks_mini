import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/task_model.dart';
import '../services/task_storage.dart';

enum TaskFilter { all, active, done }

class TaskProvider extends ChangeNotifier {
  final TaskStorage _storage = TaskStorage();
  final List<TaskModel> _tasks = [];
  TaskModel? _lastDeletedTask;
  int? _lastDeletedIndex;

  TaskFilter _currentFilter = TaskFilter.all;
  String _searchQuery = '';
  Timer? _debounce;

  List<TaskModel> get tasks => _tasks;
  TaskFilter get currentFilter => _currentFilter;

  List<TaskModel> get filteredTasks {
    Iterable<TaskModel> results = _tasks;

    // filter by status
    switch (_currentFilter) {
      case TaskFilter.active:
        results = results.where((t) => !t.done);
        break;
      case TaskFilter.done:
        results = results.where((t) => t.done);
        break;
      case TaskFilter.all:
        break;
    }

    // search filter
    if (_searchQuery.isNotEmpty) {
      results = results.where(
          (t) => t.title.toLowerCase().contains(_searchQuery.toLowerCase()));
    }

    return results.toList();
  }

  Future<void> loadTasks() async {
    final loaded = await _storage.loadTasks();
    _tasks.clear();
    _tasks.addAll(loaded);
    notifyListeners();
  }

  Future<void> _persist() async {
    await _storage.saveTasks(_tasks);
  }

  void addTask(String title) {
    if (title.trim().isEmpty) return;
    final task = TaskModel(
      id: const Uuid().v4(),
      title: title,
      createdAt: DateTime.now(),
    );
    _tasks.add(task);
    _persist();
    notifyListeners();
  }

  void toggleTask(String id) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index].done = !_tasks[index].done;
      _persist();
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _lastDeletedTask = _tasks[index];
      _lastDeletedIndex = index;
      _tasks.removeAt(index);
      _persist();
      notifyListeners();
    }
  }

  void undoDelete() {
    if (_lastDeletedTask != null && _lastDeletedIndex != null) {
      _tasks.insert(_lastDeletedIndex!, _lastDeletedTask!);
      _lastDeletedTask = null;
      _lastDeletedIndex = null;
      _persist();
      notifyListeners();
    }
  }

  void updateFilter(TaskFilter filter) {
    _currentFilter = filter;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _searchQuery = query;
      notifyListeners();
    });
  }
}
