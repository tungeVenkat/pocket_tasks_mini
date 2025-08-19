import 'package:flutter/material.dart';
import 'package:pocket_tasks_mini/ui/widgets/add_task.dart';
import 'package:pocket_tasks_mini/ui/widgets/filter_task.dart';
import 'package:pocket_tasks_mini/ui/widgets/progress_ring.dart';
import 'package:pocket_tasks_mini/ui/widgets/search_box.dart';
import 'package:pocket_tasks_mini/ui/widgets/task_list_tile.dart';
import 'package:pocket_tasks_mini/utils/constants.dart';
import 'package:provider/provider.dart';
import '../../providers/task_provider.dart';
import '../../utils/app_colors.dart';

class TaskHome extends StatelessWidget {
  const TaskHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider()..loadTasks(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Consumer<TaskProvider>(
              builder: (context, provider, _) {
                final tasks = provider.filteredTasks;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress + Title
                    Row(
                      children: [
                        ProgressRing(
                          completed: provider.tasks.where((t) => t.done).length,
                          total: provider.tasks.length,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          AppConstants.appName,
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
                    AddTaskWidget(
                      onAdd: (title) => provider.addTask(title),
                    ),
                    const SizedBox(height: 12),

                    // Search Box
                    SearchBox(
                      onChanged: (query) => provider.updateSearchQuery(query),
                    ),
                    const SizedBox(height: 16),

                    // Filters
                    Row(
                      children: [
                        FilterTask(
                          label: "All",
                          isSelected: provider.currentFilter == TaskFilter.all,
                          onTap: () => provider.updateFilter(TaskFilter.all),
                        ),
                        const SizedBox(width: 8),
                        FilterTask(
                          label: "Active",
                          isSelected:
                              provider.currentFilter == TaskFilter.active,
                          onTap: () => provider.updateFilter(TaskFilter.active),
                        ),
                        const SizedBox(width: 8),
                        FilterTask(
                          label: "Done",
                          isSelected: provider.currentFilter == TaskFilter.done,
                          onTap: () => provider.updateFilter(TaskFilter.done),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Task List
                    Expanded(
                      child: tasks.isEmpty
                          ? const Center(
                              child: Text(
                                "No tasks found",
                                style: TextStyle(color: Colors.white70),
                              ),
                            )
                          : ListView.builder(
                              itemCount: tasks.length,
                              itemBuilder: (context, index) {
                                final task = tasks[index];

                                return Dismissible(
                                  key: ValueKey(task.id),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (_) {
                                    provider.deleteTask(task.id);

                                    // Show undo snackbar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text("Task deleted"),
                                        action: SnackBarAction(
                                          label: "UNDO",
                                          onPressed: () {
                                            provider.undoDelete();
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: const Icon(Icons.delete,
                                        color: Colors.white),
                                  ),
                                  child: TaskListTile(
                                    title: task.title,
                                    isDone: task.done,
                                    onToggle: () =>
                                        provider.toggleTask(task.id),
                                    onDelete: () {
                                      provider.deleteTask(task.id);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Text("Task deleted"),
                                          action: SnackBarAction(
                                            label: "UNDO",
                                            onPressed: () {
                                              provider.undoDelete();
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
