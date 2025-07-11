import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_todo_app/presentation/controllers/theme_controller.dart';
import 'package:mini_todo_app/routes/app_pages.dart';
import 'package:mini_todo_app/routes/app_routes.dart';
import 'package:mini_todo_app/presentation/pages/dashboard_page.dart';
import 'package:mini_todo_app/utils/app_theme.dart'; // <-- add this

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() => GetMaterialApp(
          title: 'Mini To-do App',
          themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.dashboard,
          getPages: AppPages.pages,
          home: const DashboardPage(),
        ));
  }
}
