import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_todo_app/presentation/pages/add_edit_task_page.dart';
import 'package:mini_todo_app/presentation/widgets/delete_dialog.dart';
import 'package:mini_todo_app/utils/app_constant.dart';
import '../../data/models/task_model.dart';
import '../controllers/task_controller.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    return Container(
      key: ValueKey(task.id),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        gradient: AppConstants.glassGradient,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.white24 : Colors.black12),
        color: isDark ? Colors.white12 : Colors.white.withOpacity(0.8),
      ),
      child: ListTile(
        leading: Icon(
          Icons.drag_handle,
          color: isDark ? Colors.white60 : Colors.grey[700],
        ),
        title: Text(
          task.title,
          style: TextStyle(
            color: theme.textTheme.titleLarge?.color,
            decoration: task.isDone ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle:
            task.description != null
                ? Text(
                  task.description!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                )
                : null,
        trailing: Wrap(
          spacing: 8,
          children: [
            Checkbox(
              value: task.isDone,
              onChanged: (_) => controller.toggleStatus(task),
              checkColor: Colors.white,
              activeColor: Colors.greenAccent,
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: isDark ? Colors.red[300] : Colors.redAccent,
              ),
              onPressed: () async {
                final confirm = await showConfirmDialog(
                  context: context,
                  title: 'Confirm Delete',
                  content: 'Are you sure you want to delete this task?',
                  confirmText: 'Delete',
                  confirmColor: Colors.red,
                );

                if (confirm) {
                  controller.deleteTask(task.id!);
                }
              },
            ),
          ],
        ),
        onTap: () {
          Get.to(
            () => const AddEditTaskPage(),
            arguments: task,
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 300),
          );
        },
      ),
    );
  }
}
