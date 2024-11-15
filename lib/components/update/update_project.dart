import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_progressreport/controllers/project_controller.dart';
import 'package:intern_progressreport/model/project_model.dart';
import 'package:intl/intl.dart';

class UpdateProject extends StatefulWidget {
  const UpdateProject({super.key});

  @override
  State<UpdateProject> createState() => _UpdateProjectState();
}

class _UpdateProjectState extends State<UpdateProject> {
  final ProjectController projectController = Get.find<ProjectController>();

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
            readOnly: true,
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2050),
                  ).then((value) {
                    if (value != null) {
                      controller.text = DateFormat('dd/MM/yyyy').format(value);
                    }
                  });
                },
                child: Icon(Icons.calendar_month_outlined),
              ),
              border: UnderlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String title = Get.arguments['title'];
    String user = Get.arguments['user'];
    String status = Get.arguments['status'];
    String startDay = Get.arguments['startDay'];
    String endDay = Get.arguments['endDay'];
    String about = Get.arguments['about'];
    String projectId = Get.arguments['id'];
    double percentage = Get.arguments['percentage'];
    String createDay = Get.arguments['createDay'];

    final TextEditingController titleController = TextEditingController();
    final TextEditingController userController = TextEditingController();
    final TextEditingController startDayController = TextEditingController();
    final TextEditingController endDayController = TextEditingController();
    final TextEditingController aboutController = TextEditingController();

    titleController.text = title;
    userController.text = user;
    startDayController.text = startDay;
    endDayController.text = endDay;
    aboutController.text = about;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Sửa Dự Án",
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
              final updateProjects = ProjectModel(
                id: projectId,
                title: titleController.text,
                status: status,
                user: userController.text,
                startDay: startDayController.text,
                endDay: endDayController.text,
                about: aboutController.text,
                createDay: createDay,
                percentage: percentage,
              );

              projectController.updateProject(projectId, updateProjects);

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
              "Thông Tin Dự Án",
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
                  _buildDocument("Tên dự Án", titleController),
                  _buildDocument("Người sở hữu", userController),
                  _buildDocumentIcon("Ngày bắt đầu", startDayController),
                  _buildDocumentIcon("Ngày kết thúc", endDayController),
                  _buildDocument("Mô tả dự án", aboutController),
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
