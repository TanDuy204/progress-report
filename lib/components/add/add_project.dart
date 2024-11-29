import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_progressreport/controllers/project_controller.dart';
import 'package:intern_progressreport/model/project_model.dart';
import 'package:intl/intl.dart';

class AddProject extends StatefulWidget {
  const AddProject({super.key});

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final ProjectController projectController = Get.find<ProjectController>();
  TextEditingController titleController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  static int currentIdIndex = 6;

  Widget _buildDocumentIcon(String title, TextEditingController controller) {
    return Row(
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
              suffixIcon: GestureDetector(
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1944),
                          lastDate: DateTime(2090))
                      .then((value) {
                    setState(() {
                      controller.text = DateFormat('dd/MM/yyyy').format(value!);
                    });
                  });
                },
                child: Icon(Icons.calendar_month_outlined),
              ),
              border: UnderlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            ),
          ),
        ),
      ],
    );
  }

  void _saveProject() {
    if (titleController.text.isNotEmpty &&
        userController.text.isNotEmpty &&
        startDateController.text.isNotEmpty &&
        endDateController.text.isNotEmpty) {
      // var uuid = Uuid();
      //final newID = projectController.generateNewID();

      String newID = 'To-$currentIdIndex';
      currentIdIndex++;

      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(now);

      final newProject = ProjectModel(
        id: newID,
        title: titleController.text,
        status: "Đang hoạt động",
        user: userController.text,
        startDay: startDateController.text,
        endDay: endDateController.text,
        about: descriptionController.text,
        createDay: formattedDate,
      );
      projectController.addProject(newProject);
      Get.snackbar("Thành công", "Thêm dự án thành công",
          snackPosition: SnackPosition.BOTTOM);
      Navigator.pop(context);
    } else {
      Get.snackbar("Lỗi", "Vui lòng nhập đầy đủ thông tin",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Thêm Dự Án",
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
              _saveProject();
            },
            child: Text(
              "Lưu",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
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
                    _buildDocument('Tên Dự Án', titleController),
                    _buildDocument('Người Tạo', userController),
                    _buildDocumentIcon(
                      'Ngày bắt đầu',
                      startDateController,
                    ),
                    _buildDocumentIcon(
                      'Ngày kết thúc',
                      endDateController,
                    ),
                    _buildDocument(
                        'Tổng quan về dự án ', descriptionController),
                  ],
                ),
              ),
            ],
          ),
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
