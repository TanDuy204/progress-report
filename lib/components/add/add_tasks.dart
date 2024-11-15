import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_progressreport/controllers/task_controller.dart';
import 'package:intern_progressreport/model/tasks_model.dart';
import 'package:intl/intl.dart';

class AddTasks extends StatefulWidget {
  const AddTasks({super.key});

  @override
  State<AddTasks> createState() => _AddTasksState();
}

class _AddTasksState extends State<AddTasks> {
  final TaskController taskController = Get.find<TaskController>();
  TextEditingController titleController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  TextEditingController startDayController = TextEditingController();
  TextEditingController endDayController = TextEditingController();
  TextEditingController fileController = TextEditingController();

  static int currentIndex = 5;

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
                          lastDate: DateTime(2070))
                      .then((value) {
                    setState(() {
                      controller.text = DateFormat('dd/MM/yyyy').format(value!);
                    });
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

  Widget _buildDocumentIcon1(String title, TextEditingController controller) {
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
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Tập tin', style: TextStyle(fontSize: 20)),
                              SizedBox(height: 5),
                              Text('Scan Tài liệu',
                                  style: TextStyle(fontSize: 20)),
                              SizedBox(height: 5),
                              Text('Thư viện hỉnh ảnh',
                                  style: TextStyle(fontSize: 20)),
                              SizedBox(height: 5),
                              Divider(),
                              Text('Hủy', style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        );
                      });
                },
                child: Icon(Icons.add),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _saveTask() {
    if (titleController.text.isNotEmpty &&
        aboutController.text.isNotEmpty &&
        deadlineController.text.isNotEmpty &&
        startDayController.text.isNotEmpty &&
        endDayController.text.isNotEmpty) {
      String newID = 'Ta-$currentIndex';
      currentIndex++;

      DateTime now = DateTime.now();
      String formatted = DateFormat('dd/MM/yyyy HH:mm').format(now);

      final newTask = TasksModel(
          id: newID,
          title: titleController.text,
          about: aboutController.text,
          createDay: formatted,
          deadline: deadlineController.text,
          startDay: startDayController.text,
          endDay: endDayController.text);

      taskController.addTasks(newTask);
      Get.back();
      Get.snackbar('Thành công', 'Thêm công việc thành công');
    } else {
      Get.snackbar('Lỗi', 'Vui lòng nhập đầy đủ thông tin!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Thêm Công Việc",
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
              _saveTask();
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
                  _buildDocumentIcon("Thời hạn", deadlineController),
                  _buildDocumentIcon("Ngày bắt đầu", startDayController),
                  _buildDocumentIcon("Ngày kết thúc", endDayController),
                  _buildDocumentIcon1("Tệp tin đính kèm", fileController),
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
