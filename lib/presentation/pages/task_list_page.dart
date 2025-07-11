import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../widgets/task_tile.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.find();
    final String filterType = Get.arguments ?? 'all';

    return Scaffold(
      appBar: AppBar(title: Text('${filterType.capitalizeFirst} Tasks')),
    body: Obx(() {
  final tasks = controller.filteredTasks(filterType);

  return tasks.isEmpty
      ? Center(
          child: Text(
            'No ${filterType.capitalizeFirst} tasks found.',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
        )
      : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ReorderableListView.builder(
            itemCount: tasks.length,
            onReorder: (oldIndex, newIndex) {
              if (filterType == 'all') {
                controller.reorderTasks(oldIndex, newIndex);
              } else {
                Get.snackbar(
                  'Reorder Disabled',
                  'You can only reorder in All Tasks view.',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskTile(key: ValueKey(task.id), task: task);
            },
          ),
        );
}),

    );
  }
}
