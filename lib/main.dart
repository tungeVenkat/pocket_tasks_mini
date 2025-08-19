import 'package:flutter/material.dart';
import 'package:pocket_tasks_mini/ui/screens/task_home.dart';

void main() {
  runApp(const PocketTasksApp());
}

class PocketTasksApp extends StatelessWidget {
  const PocketTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket Tasks Mini',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Times New Roman',
      ),
      debugShowCheckedModeBanner: false,
      home: const TaskHome(),
    );
  }
}