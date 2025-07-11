import 'package:get/get.dart';
import '../presentation/pages/dashboard_page.dart';
import '../presentation/pages/task_list_page.dart';
import '../presentation/pages/add_edit_task_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardPage(),
    ),
    GetPage(
      name: AppRoutes.tasks,
      page: () => const TaskListPage(),
    ),
    GetPage(
      name: AppRoutes.addEditTask,
      page: () => const AddEditTaskPage(),
    ),
  ];
}
