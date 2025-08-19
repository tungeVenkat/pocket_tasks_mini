import 'package:flutter/material.dart';

class TaskListTile extends StatelessWidget {
  final String title;
  final bool isDone;

  const TaskListTile({super.key, required this.title, this.isDone = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        isDone ? Icons.check_circle : Icons.circle_outlined,
        color: isDone ? Colors.green : Colors.white54,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDone ? Colors.green : Colors.white,
          decoration: isDone ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
}
