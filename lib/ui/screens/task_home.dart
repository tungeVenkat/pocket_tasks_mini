import 'package:flutter/material.dart';
import 'package:pocket_tasks_mini/ui/widgets/add_task.dart';
import 'package:pocket_tasks_mini/ui/widgets/filter_task.dart';
import 'package:pocket_tasks_mini/ui/widgets/progress_ring.dart';
import 'package:pocket_tasks_mini/ui/widgets/search_box.dart';
import 'package:pocket_tasks_mini/ui/widgets/task_list_tile.dart';

class TaskHome extends StatelessWidget {
  const TaskHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C003E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress + Title
              Row(
                children: const [
                  ProgressRing(completed: 1, total: 3),
                  SizedBox(width: 12),
                  Text(
                    "PocketTasks",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),

              // Add Task
              const AddTaskWidget(),
              const SizedBox(height: 12),

              // Search Box
              const SearchBox(),
              const SizedBox(height: 16),

              // Filters
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  FilterTask(label: "All", isSelected: true),
                  SizedBox(width: 8),
                  FilterTask(label: "Active"),
                  SizedBox(width: 8),
                  FilterTask(label: "Done"),
                ],
              ),
              const SizedBox(height: 20),

              // Task List
              const TaskListTile(title: "Buy groceries", isDone: true),
              const TaskListTile(title: "Walk the dog", isDone: false),
              const TaskListTile(title: "Call Alice", isDone: false),
            ],
          ),
        ),
      ),
    );
  }
}
