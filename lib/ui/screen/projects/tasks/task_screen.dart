import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_progressreport/components/add/add_tasks.dart';
import 'package:intern_progressreport/controllers/task_controller.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    String titleProject = Get.arguments?['title'] ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text("Công Việc"),
        actions: <Widget>[
          _buildIconButtonAppbar(Icons.more_horiz, () {
            print("avcd");
          }),
          _buildIconButtonAppbar(Icons.search, () {
            print("avcd");
          }),
          _buildIconButtonAppbar(Icons.add, () {
            Get.to(AddTasks());
          }),
        ],
      ),
      body: Container(
        width: double.infinity,
        color: Colors.grey.shade200,
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tổng quát",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 15),
            _buildListTasks(taskController, titleProject)
          ],
        ),
      ),
    );
  }
}

Widget _buildIconButtonAppbar(IconData icon, Function onTap) {
  return GestureDetector(
    onTap: () => onTap(),
    child: Container(
      height: 40,
      width: 40,
      decoration:
          BoxDecoration(color: Colors.cyanAccent, shape: BoxShape.circle),
      margin: EdgeInsets.only(right: 15),
      child: Icon(icon),
    ),
  );
}

Widget _buildListTasks(TaskController taskController, String titleProject) {
  return Expanded(child: Obx(
    () {
      var tasks = taskController.tasks;
      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          var task = tasks[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed('/taskDetail', arguments: {
                'id': task.id,
                'title': task.title,
                'about': task.about,
                'createDay': task.createDay,
                'deadline': task.deadline,
                'startDay': task.startDay,
                'endDay': task.endDay,
                'titleProject': titleProject,
              });
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.id,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    task.title,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    task.deadline,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/onboarding_1.png'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  ));
}
