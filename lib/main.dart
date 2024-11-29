import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_progressreport/controllers/auth_controller.dart';
import 'package:intern_progressreport/controllers/auth_middleware.dart';
import 'package:intern_progressreport/controllers/project_controller.dart';
import 'package:intern_progressreport/controllers/task_controller.dart';
import 'package:intern_progressreport/ui/main/bottomTab.dart';
import 'package:intern_progressreport/ui/screen/login/login.dart';
import 'package:intern_progressreport/ui/screen/projects/documents/document_screen.dart';
import 'package:intern_progressreport/ui/screen/projects/projectDetail.dart';
import 'package:intern_progressreport/ui/screen/projects/tasks/task_detail/task_detail.dart';
import 'package:intern_progressreport/ui/screen/projects/tasks/task_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool("isLoggerIn") ?? true;
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    final ProjectController projectController = Get.put(ProjectController());
    final TaskController taskController = Get.put(TaskController());
    final AuthController authController = Get.put(AuthController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: isLoggedIn ? '/page' : '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
        ),
        GetPage(
            name: '/page',
            page: () => MainPage(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/projectDetail',
            page: () => ProjectDetail(projectController: projectController)),
        GetPage(name: '/document', page: () => DocumentScreen()),
        GetPage(name: '/task', page: () => TaskScreen()),
        GetPage(
            name: '/taskDetail',
            page: () => TaskDetail(taskController: taskController)),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
