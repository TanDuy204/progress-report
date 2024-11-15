import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_progressreport/controllers/task_controller.dart';
import 'package:intern_progressreport/model/tasks_model.dart';
import 'package:intl/intl.dart';

class UpdateTasks extends StatefulWidget {
  const UpdateTasks({super.key});

  @override
  State<UpdateTasks> createState() => _UpdateTasksState();
}

class _UpdateTasksState extends State<UpdateTasks> {
  TaskController taskController = Get.find<TaskController>();

  Widget _buildDocumentIcon(String title, TextEditingController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.grey.shade200,
            padding: EdgeInsets.symmetric(vertical: 22),
            child: Center(child: Text(title)),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextField(
            controller: controller,
            readOnly: true,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              suffixIcon: GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  ).then((value) {
                    if (value != null) {
                      controller.text = DateFormat('dd/MM/yyyy').format(value);
                    }
                  });
                },
                child: Icon(Icons.calendar_month_outlined),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String id = Get.arguments['id'];
    String title = Get.arguments['title'];
    String about = Get.arguments['about'];
    String createDay = Get.arguments['createDay'];
    String startDay = Get.arguments['startDay'];
    String endDay = Get.arguments['endDay'];
    String deadline = Get.arguments['deadline'];

    TextEditingController titleController = TextEditingController();
    TextEditingController aboutController = TextEditingController();
    TextEditingController createDayController = TextEditingController();
    TextEditingController startDayController = TextEditingController();
    TextEditingController endDayController = TextEditingController();
    TextEditingController deadlineController = TextEditingController();

    titleController.text = title;
    aboutController.text = about;
    createDayController.text = createDay;
    startDayController.text = startDay;
    endDayController.text = endDay;
    deadlineController.text = deadline;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Sửa Công Việc",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            "Hủy",
            style: TextStyle(color: Colors.blue),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final newTask = TasksModel(
                  id: id,
                  title: titleController.text,
                  about: aboutController.text,
                  createDay: createDay,
                  deadline: deadlineController.text,
                  startDay: startDayController.text,
                  endDay: endDayController.text);

              taskController.updateTask(id, newTask);
              Get.back();
            },
            child: Text(
              "Lưu",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 10, top: 20, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Thông Tin Công Việc",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: Column(
                children: [
                  _buildDocument("Tiêu đề", titleController),
                  _buildDocument("Mô tả", aboutController),
                  _buildDocumentIcon("Ngày bắt đầu", startDayController),
                  _buildDocumentIcon("Ngày kết thúc", endDayController),
                  _buildDocumentIcon("Thời hạn", deadlineController),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildDocument(String title, TextEditingController controller) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 1,
        child: Container(
          color: Colors.grey.shade200,
          padding: EdgeInsets.symmetric(vertical: 22),
          child: Center(child: Text(title)),
        ),
      ),
      Expanded(
        flex: 2,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(border: UnderlineInputBorder()),
        ),
      ),
    ],
  );
}
