// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mini_todo_app/presentation/controllers/theme_controller.dart';
import 'package:mini_todo_app/presentation/widgets/delete_dialog.dart';
import 'package:mini_todo_app/routes/app_routes.dart';
import 'package:mini_todo_app/utils/app_constant.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/task_controller.dart';
import '../widgets/task_tile.dart';
import '../widgets/stats_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TaskController());
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor(context),
      appBar: AppBar(
        backgroundColor: AppConstants.appBarColor(context),
        title: const Text("Dashboard"),
        actions: [
          Obx(() {
            final isDark = Get.find<ThemeController>().isDarkMode.value;
            return IconButton(
              icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
              onPressed: () => Get.find<ThemeController>().toggleTheme(),
              tooltip: 'Toggle Theme',
            );
          }),
        ],
      ),

      body: Obx(() {
        final tasks = controller.tasks;
        final completed = tasks.where((t) => t.isDone).length;
        final pending = tasks.where((t) => !t.isDone).length;
        final total = tasks.length;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2020),
                lastDay: DateTime.utc(2030),
                focusedDay: controller.selectedDate.value,
                selectedDayPredicate:
                    (day) => isSameDay(controller.selectedDate.value, day),
                onDaySelected: (selected, focused) {
                  controller.selectedDate.value = selected;
                },
                calendarFormat: CalendarFormat.week,
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      StatsCard(
                        title: "Total",
                        count: total,
                        color: Colors.blue,
                        width: width,
                        onTap:
                            () =>
                                Get.toNamed(AppRoutes.tasks, arguments: 'all'),
                      ),
                      StatsCard(
                        title: "Completed",
                        count: completed,
                        color: Colors.green,
                        width: width,
                        onTap:
                            () => Get.toNamed(
                              AppRoutes.tasks,
                              arguments: 'completed',
                            ),
                      ),
                      StatsCard(
                        title: "Pending",
                        count: pending,
                        color: Colors.redAccent,
                        width: width,
                        onTap:
                            () => Get.toNamed(
                              AppRoutes.tasks,
                              arguments: 'pending',
                            ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tasks on ${DateFormat.yMMMd().format(controller.selectedDate.value)}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 8),
              controller.tasksForSelectedDate.isEmpty
                  ? const Text("No tasks for this day.")
                  : Expanded(
                    child: ReorderableListView.builder(
                      itemCount: controller.tasksForSelectedDate.length,
                      onReorder: (oldIndex, newIndex) {
                        final fullList = controller.tasks;
                        final taskList = controller.tasksForSelectedDate;
                        final task = taskList[oldIndex];
                        final originalIndex = fullList.indexWhere(
                          (t) => t.id == task.id,
                        );
                        final newTaskIndexInFiltered =
                            newIndex > oldIndex ? newIndex - 1 : newIndex;
                        final newTask = taskList[newTaskIndexInFiltered];
                        final newIndexInFullList = fullList.indexWhere(
                          (t) => t.id == newTask.id,
                        );

                        controller.reorderTasks(
                          originalIndex,
                          newIndexInFullList,
                        );
                      },
                      itemBuilder: (context, index) {
                        final task = controller.tasksForSelectedDate[index];
                        return Dismissible(
                          key: ValueKey(task.id),
                          background: Container(color: Colors.red),
                          confirmDismiss: (_) async {
                            final confirm = await showConfirmDialog(
                              context: context,
                              title: 'Confirm Delete',
                              content:
                                  'Are you sure you want to delete this task?',
                              confirmText: 'Delete',
                              confirmColor: Colors.red,
                            );

                            if (confirm) {
                              controller.deleteTask(task.id!);
                              return true;
                            }
                            return false;
                          },
                          child: TaskTile(task: task),
                        );
                      },
                    ),
                  ),
            ],
          ),
        );
      }),
      floatingActionButton: RawMaterialButton(
        onPressed: () => Get.toNamed(AppRoutes.addEditTask),
        fillColor:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(0.1)
                : AppConstants.appBarColor(context).withOpacity(0.9),
        elevation: 0,
        constraints: const BoxConstraints.tightFor(width: 56, height: 56),
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
