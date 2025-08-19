import 'dart:convert';

class TaskModel {
  final String id;
  String title;
  bool done;
  final DateTime createdAt;

  TaskModel({
    required this.id,
    required this.title,
    this.done = false,
    required this.createdAt,
  });

  void toggleDone() {
    done = !done;
  }

  // JSON encode/decode for storage
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'done': done,
        'createdAt': createdAt.toIso8601String(),
      };

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        title: json['title'],
        done: json['done'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  static String encode(List<TaskModel> tasks) =>
      json.encode(tasks.map((t) => t.toJson()).toList());

  static List<TaskModel> decode(String tasks) =>
      (json.decode(tasks) as List<dynamic>)
          .map((item) => TaskModel.fromJson(item))
          .toList();
}
