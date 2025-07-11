import 'package:get/get.dart';
import '../../data/models/task_model.dart';
import '../../core/database/task_db.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;
  var selectedDate = DateTime.now().obs;

  final db = TaskDB();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final allTasks = await db.getTasks();
    tasks.assignAll(allTasks);
  }

  List<TaskModel> get tasksForSelectedDate {
    final formatted = selectedDate.value.toIso8601String().substring(0, 10);
    return tasks.where((t) => t.date == formatted).toList();
  }

  void addTask(TaskModel task) async {
    await db.insert(task);
    fetchTasks();
  }

  void updateTask(TaskModel task) async {
    await db.update(task);
    fetchTasks();
  }

  void deleteTask(int id) async {
    await db.delete(id);
    fetchTasks();
  }

  void toggleStatus(TaskModel task) async {
    final updatedTask = task.copyWith(isDone: !task.isDone);
    await db.update(updatedTask);
    fetchTasks();
  }

  List<TaskModel> filteredTasks(String filter) {
    switch (filter) {
      case 'completed':
        return tasks.where((t) => t.isDone).toList();
      case 'pending':
        return tasks.where((t) => !t.isDone).toList();
      case 'all':
      default:
        return tasks;
    }
  }

void reorderTasks(int oldIndex, int newIndex) {
  if (oldIndex < newIndex) {
    newIndex -= 1;
  }
  final task = tasks.removeAt(oldIndex);
  tasks.insert(newIndex, task);
}

}
