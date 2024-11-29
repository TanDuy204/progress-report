import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_progressreport/controllers/project_controller.dart';
import 'package:intern_progressreport/model/project_model.dart';
import 'package:intern_progressreport/ui/screen/projects/tasks/task_screen.dart';
import 'package:intern_progressreport/ui/screen/projects/users/user_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../components/update/update_project.dart';
import 'comments/comment_screen.dart';

class ProjectDetail extends StatefulWidget {
  final ProjectController projectController;

  const ProjectDetail({super.key, required this.projectController});

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  Color getColorStatus(String status) {
    switch (status) {
      case "Đang hoạt động":
        return Colors.blueAccent;
      case "Trì hoãn":
        return Colors.orangeAccent;
      case "Đã hoàn thành":
        return Colors.greenAccent;
      default:
        return Colors.grey;
    }
  }

  Widget _buildEndDrawerPercent(String label, String id) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(
          height: 10,
        ),
        Obx(
          () {
            var project = widget.projectController.projects.firstWhere(
              (element) => element.id == id,
            );
            return Row(
              children: [
                Slider(
                  value: project.percentage,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  activeColor: Colors.blueAccent,
                  onChanged: (value) {
                    setState(() {
                      project.percentage = value;
                    });
                    widget.projectController
                        .updateProjectPercentage(id, project.percentage);
                  },
                ),
                Text('${project.percentage.toInt()}%'),
              ],
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String id = Get.arguments['id'];
    String title = Get.arguments['title'];
    String status = Get.arguments['status'];
    String user = Get.arguments['user'];
    String createDay = Get.arguments['createDay'];
    String startDay = Get.arguments['startDay'];
    String endDay = Get.arguments['endDay'];
    String about = Get.arguments['about'];
    double percentage = Get.arguments['percentage'];

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          _buildIconButtonAppbar(Icons.delete_outline, () {
            Get.defaultDialog(
                title: "Xác nhận xóa",
                middleText: "Bạn có chắc chắn xóa dự án này không?",
                onCancel: () {
                  Get.back();
                },
                onConfirm: () {
                  widget.projectController.removeProject(id);
                  Get.back();
                  Get.back();
                  Get.snackbar("Thành công", "Xóa dự án thành công",
                      snackPosition: SnackPosition.BOTTOM);
                  Get.back();
                });
          }),
          _buildIconButtonAppbar(Icons.edit_outlined, () {
            Get.to(UpdateProject(), arguments: {
              'id': id,
              'title': title,
              'status': status,
              'user': user,
              'createDay': createDay,
              'startDay': startDay,
              'endDay': endDay,
              'about': about,
              'percentage': percentage,
            });
          }),
        ],
      ),
      endDrawer: Drawer(child: Obx(
        () {
          var project = widget.projectController.projects.firstWhere(
            (element) => element.id == id,
          );
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Thông Tin Dự Án",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(UpdateProject(), arguments: {
                              'id': id,
                              'title': title,
                              'status': status,
                              'user': user,
                              'createDay': createDay,
                              'startDay': startDay,
                              'endDay': endDay,
                              'about': about,
                              'percentage': percentage,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: Column(
                        children: [
                          CircularPercentIndicator(
                            radius: 35,
                            backgroundColor: Colors.grey.shade400,
                            progressColor: Colors.blueAccent,
                            center: Text('${project.percentage.toInt()}%'),
                            percent: project.percentage / 100,
                            animationDuration: 1000,
                            animation: true,
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                          Text('Dự án')
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildEndDrawer('Tên dự án', project.title),
                    _buildEndDrawer('Chủ sở hữu', project.user),
                    _buildEndDrawer('Ngày tạo', project.createDay),
                    _buildEndDrawer('Ngày bắt đầu', project.startDay),
                    _buildEndDrawer('Ngày kết thúc', project.endDay),
                    _buildEndDrawer('Địa chỉ', project.address.toString()),
                    _buildEndDrawerPercent('% Hoàn tất', id),
                    _buildEndDrawerMap('Map', widget.projectController, project)
                  ],
                ),
              )
            ],
          );
        },
      )),
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        color: Colors.grey.shade200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Obx(
                () {
                  var project = widget.projectController.projects.firstWhere(
                    (proj) => proj.id == id,
                    orElse: () => ProjectModel(
                        id: '',
                        title: '',
                        about: '',
                        endDay: '',
                        startDay: '',
                        status: '',
                        user: '',
                        createDay: ''),
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(project.id),
                      Text(
                        project.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(project.about),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: getColorStatus(project.status),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: EdgeInsets.only(bottom: 20),
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        buildStatus(
                                            context, "Đang hoạt động", id),
                                        buildStatus(context, 'Trì hoãn', id),
                                        buildStatus(
                                            context, 'Đã hoàn thành', id)
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Obx(
                              () {
                                var project = widget.projectController.projects
                                    .firstWhere(
                                  (proj) => proj.id == id,
                                  orElse: () => ProjectModel(
                                      id: '',
                                      title: '',
                                      about: '',
                                      endDay: '',
                                      startDay: '',
                                      status: '',
                                      user: '',
                                      createDay: ''),
                                );
                                return Text(project.status);
                              },
                            ),
                          ),
                          Expanded(child: Container()),
                          Builder(
                            builder: (context) => GestureDetector(
                              onTap: Scaffold.of(context).openEndDrawer,
                              child: Icon(
                                Icons.menu,
                                color: Colors.lightBlue.shade900,
                                size: 35,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _category(Icons.grid_view, "Nhận xét", () {
                    Get.to(CommentScreen(), arguments: {'projectID': id});
                  }),
                  Divider(),
                  _category(Icons.calendar_today, "Công việc", () {
                    Get.to(TaskScreen(), arguments: {
                      'id': id,
                      'title': title,
                      'status': status,
                      'user': user,
                      'starDay': startDay,
                      'endDay': endDay,
                      'about': about,
                    });
                  }),
                  Divider(),
                  _category(Icons.file_copy_outlined, "Tài liệu", () {
                    Get.toNamed('/document');
                  }),
                  Divider(),
                  _category(Icons.person, "Người dùng", () {
                    Get.to(UserScreen());
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatus(BuildContext context, String newStatus, String projectId) {
    return GestureDetector(
      onTap: () {
        widget.projectController.updateProjectStatus(projectId, newStatus);
        Get.back();
      },
      child: Text(
        newStatus,
        style: TextStyle(
          fontSize: 20,
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

Widget _category(IconData icon, String label, Function onTap) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      color: Colors.white,
      child: Row(
        children: [
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: Colors.grey.shade200, shape: BoxShape.circle),
            child: Icon(
              icon,
              color: Colors.cyan,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(label)
        ],
      ),
    ),
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
        b,
        style: TextStyle(color: Colors.blue),
      ),
      SizedBox(
        height: 10,
      ),
      Divider(),
    ],
  );
}

Widget _buildEndDrawerMap(
    String a, ProjectController project, ProjectModel projects) {
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
      GestureDetector(
        onTap: () {
          project.openMap();
        },
        child: Text(
          'Mở gogole map',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Divider(),
    ],
  );
}
