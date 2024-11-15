import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_progressreport/components/update/update_tasks.dart';
import 'package:intern_progressreport/controllers/task_controller.dart';
import 'package:intern_progressreport/model/tasks_model.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';

class TaskDetail extends StatefulWidget {
  final TaskController taskController;
  TaskDetail({super.key, required this.taskController});

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  String deadline = '';

  @override
  void initState() {
    super.initState();
    deadline = Get.arguments['deadline'];
  }

  @override
  Widget build(BuildContext context) {
    String id = Get.arguments['id'];
    String title = Get.arguments['title'];
    String about = Get.arguments['about'];
    String createDay = Get.arguments['createDay'];
    String startDay = Get.arguments['startDay'];
    String endDay = Get.arguments['endDay'];
    String titleProject = Get.arguments['titleProject'];

    Widget _buildImageDocuments(String taskId) {
      return Obx(
        () {
          TasksModel? task = widget.taskController.tasks
              .firstWhereOrNull((task) => task.id == taskId);
          if (task == null ||
              (task.images == null &&
                  task.videos == null &&
                  task.files == null)) {
            return SizedBox.shrink();
          }
          int totalItems = (task.images?.length ?? 0) +
              (task.videos?.length ?? 0) +
              (task.files?.length ?? 0);

          return SingleChildScrollView(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: totalItems,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.6),
              itemBuilder: (context, index) {
                if (index < (task.images?.length ?? 0)) {
                  return _buildImageItem(
                      task.images![index], index, id, widget.taskController);
                } else if (index <
                    (task.images?.length ?? 0) + (task.videos?.length ?? 0)) {
                  int videoIndex = index - (task.images?.length ?? 0);
                  return _buildVideoItem(task.videos![videoIndex], videoIndex,
                      widget.taskController, id);
                } else {
                  int fileIndex = index -
                      (task.images?.length ?? 0) -
                      (task.videos?.length ?? 0);
                  return _buildFileItem(task.files![fileIndex], fileIndex,
                      widget.taskController, id);
                }
              },
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          _buildIconButtonAppbar(
            Icons.delete_outline,
            () {
              Get.defaultDialog(
                title: "Xác nhận xóa",
                middleText: "Bạn có chắc chắn xóa công việc không?",
                onCancel: () => Get.back,
                onConfirm: () {
                  widget.taskController.removeTasks(id);
                  Get.back();
                  Get.back();
                  Get.snackbar('Thành công', 'Bạn đã xóa công việc');
                },
              );
            },
          ),
          _buildIconButtonAppbar(Icons.edit_outlined, () {
            Get.to(UpdateTasks(), arguments: {
              'id': id,
              'title': title,
              'about': about,
              'createDay': createDay,
              'deadline': deadline,
              'startDay': startDay,
              'endDay': endDay,
            });
          }),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Thông Tin Công Việc",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(UpdateTasks(), arguments: {
                            'id': id,
                            'title': title,
                            'about': about,
                            'createDay': createDay,
                            'deadline': deadline,
                            'startDay': startDay,
                            'endDay': endDay,
                          });
                        },
                        child: Text(
                          "Sửa",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 60),
                  Row(
                    children: [
                      Text(
                        "Chi tiết",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600),
                      ),
                      SizedBox(width: 40),
                      Text(
                        "Hoạt động",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Obx(
                () {
                  var task = widget.taskController.tasks.firstWhere(
                    (element) => element.id == id,
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildEndDrawer("Tên dự án", titleProject),
                      _buildEndDrawer("Tạo bởi", "UserName"),
                      _buildEndDrawer("Ngày tạo", task.createDay),
                      _buildEndDrawer("Ngày bắt đầu", task.startDay),
                      _buildEndDrawer("Ngày kết thúc", task.endDay),
                      _buildEndDrawer("Thời hạn ", task.deadline),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Obx(
                () {
                  var task = widget.taskController.tasks.firstWhere(
                    (element) => element.id == id,
                    orElse: () => TasksModel(
                        id: '',
                        title: '',
                        about: '',
                        createDay: '',
                        deadline: '',
                        startDay: '',
                        endDay: ''),
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            task.title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/onboarding_1.png'),
                          ),
                        ],
                      ),
                      Text(
                        task.id,
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade700),
                      ),
                      Text(
                        task.about,
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade700),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2100),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    deadline =
                                        DateFormat('dd/MM/yyyy').format(value);
                                  });
                                  widget.taskController
                                      .updateDeadline(id, deadline);
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              side: BorderSide(color: Colors.grey, width: 1),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.calendar_today_outlined),
                                SizedBox(width: 10),
                                Text(deadline),
                              ],
                            ),
                          ),
                          Builder(
                            builder: (context) => GestureDetector(
                              onTap: Scaffold.of(context).openEndDrawer,
                              child: Icon(
                                Icons.menu,
                                color: Colors.lightBlue.shade900,
                                size: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 25, top: 15),
              child: Column(
                children: [
                  _buildComponents("Công Việc Con", () {}),
                  SizedBox(height: 20),
                  _buildComponents("Nhận Xét", () {}),
                  SizedBox(height: 20),
                  _buildComponents("Tài Liệu", () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                onTap: () {
                                  widget.taskController.pickImageGallery(id);
                                  Get.back();
                                },
                                title: Text("Ảnh"),
                                leading: Icon(Icons.image_outlined),
                              ),
                              ListTile(
                                onTap: () {
                                  widget.taskController.pickImageCamera(id);
                                },
                                title: Text("chụp ảnh"),
                                leading: Icon(Icons.camera_alt_outlined),
                              ),
                              ListTile(
                                onTap: () {
                                  widget.taskController.pickFile(id);
                                  Get.back();
                                },
                                title: Text("Tập tin"),
                                leading: Icon(Icons.file_copy_outlined),
                              ),
                              ListTile(
                                onTap: () {
                                  widget.taskController.pickVideoGallery(id);
                                  Get.back();
                                },
                                title: Text("video"),
                                leading: Icon(Icons.video_library_outlined),
                              )
                            ],
                          );
                        });
                  }),
                  _buildImageDocuments(id)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TaskController>(
        'taskController', widget.taskController));
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

Widget _buildComponents(String title, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      GestureDetector(
        onTap: () => onTap(),
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.blueAccent,
        ),
      ),
    ],
  );
}

Widget _buildEndDrawer(String a, String b) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        a,
        style: TextStyle(color: Colors.grey),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        b, //truyền từ màn hình project
        style: TextStyle(color: Colors.blue),
      ),
      SizedBox(
        height: 10,
      ),
      Divider(),
    ],
  );
}

Widget _buildVideoItem(
    String videoPath, int index, TaskController taskController, String taskId) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          OpenFile.open(videoPath);
        },
        child: SizedBox(
          height: 130,
          child: Icon(
            Icons.video_library,
            size: 50,
            color: Colors.blueAccent,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Video ${index + 1}"),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    taskController.removeVideo(taskId, videoPath);
                  },
                  child: Text("Xóa"),
                ),
                PopupMenuItem(
                  child: Text("Tải xuống"),
                ),
              ],
            )
          ],
        ),
      )
    ],
  );
}

Widget _buildFileItem(
    String filePath, int index, TaskController taskController, String id) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          OpenFile.open(filePath);
        },
        child: SizedBox(
          height: 130,
          child: Icon(
            Icons.insert_drive_file,
            size: 50,
            color: Colors.blueAccent,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("File ${index + 1}"),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    taskController.removeFile(id, filePath);
                  },
                  child: Text("Xóa"),
                ),
                PopupMenuItem(
                  child: Text("Tải xuống"),
                ),
              ],
            )
          ],
        ),
      )
    ],
  );
}

Widget _buildImageItem(
    String imagePath, int index, String taskId, TaskController taskController) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          OpenFile.open(imagePath);
        },
        child: Image.file(
          File(imagePath),
          height: 130,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Hình ảnh ${index + 1}"),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    taskController.removeImage(taskId, imagePath);
                  },
                  child: Text("Xóa"),
                ),
                PopupMenuItem(
                  child: Text("Tải xuống"),
                ),
              ],
            )
          ],
        ),
      )
    ],
  );
}
