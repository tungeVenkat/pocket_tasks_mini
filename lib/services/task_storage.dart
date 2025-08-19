import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class TaskStorage {
  static const _storageKey = 'pocket_tasks_v1';

  Future<List<TaskModel>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_storageKey);
    if (data == null) return [];
    return TaskModel.decode(data);
  }

  Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, TaskModel.encode(tasks));
  }
}
