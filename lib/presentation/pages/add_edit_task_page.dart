import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/task_model.dart';
import '../controllers/task_controller.dart';

class AddEditTaskPage extends StatelessWidget {
  const AddEditTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.find();
    final TaskModel? task = Get.arguments;

    final titleController = TextEditingController(text: task?.title ?? '');
    final descController = TextEditingController(text: task?.description ?? '');
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(task == null ? 'Add Task' : 'Edit Task'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task == null ? "Create New Task" : "Update Your Task",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                filled: true,
                fillColor: isDark ? Colors.white10 : Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                filled: true,
                fillColor: isDark ? Colors.white10 : Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  final title = titleController.text.trim();
                  final description = descController.text.trim();

                  if (title.isEmpty) {
                    Get.snackbar(
                      'Title Required',
                      'Please enter a task title.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.redAccent.withOpacity(0.8),
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 2),
                    );
                    return;
                  }

                  final newTask = TaskModel(
                    id: task?.id,
                    title: title,
                    description: description,
                    isDone: task?.isDone ?? false,
                    date:
                        task?.date ??
                        controller.selectedDate.value
                            .toIso8601String()
                            .substring(0, 10),
                  );

                  if (task == null) {
                    controller.addTask(newTask);
                    Get.back();
                    Get.snackbar(
                      'Task Added',
                      'Your task was successfully created.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green.withOpacity(0.8),
                      colorText: Colors.white,
                    );
                  } else {
                    controller.updateTask(newTask);
                    Get.back();
                    Get.snackbar(
                      'Task Updated',
                      'Your changes have been saved.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.blue.withOpacity(0.8),
                      colorText: Colors.white,
                    );
                  }
                },

                child: Text(
                  task == null ? 'Add Task' : 'Update Task',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
