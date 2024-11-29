import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_progressreport/controllers/project_controller.dart';
import 'package:intern_progressreport/ui/screen/projects/projectDetail.dart';

import '../../components/add/add_project.dart';
import '../../pie_chart.dart';

class Project extends StatelessWidget {
  Project({super.key});

  final ProjectController projectController = Get.put(ProjectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dự Án",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: <Widget>[
          _buildIconButtonAppbar(Icons.more_horiz, () {
            print("avcd");
          }),
          _buildIconButtonAppbar(Icons.search, () {
            print("avcd");
          }),
          _buildIconButtonAppbar(Icons.add, () {
            Get.to(AddProject());
          }),
        ],
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Các Dự Án Chưa Nhóm",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _project(projectController)
            ],
          ),
        ),
      ),
    );
  }
}

Widget _project(ProjectController projectController) {
  return Expanded(
    child: Obx(
      () {
        var projects = projectController.projects;
        return ListView.builder(
          itemCount: projects.length,
          itemBuilder: (context, index) {
            var project = projects[index];
            return GestureDetector(
              onTap: () {
                projectController.getCurrentLocation(project);
                Get.to(ProjectDetail(projectController: projectController),
                    arguments: {
                      'id': project.id,
                      'title': project.title,
                      'status': project.status,
                      'user': project.user,
                      'createDay': project.createDay,
                      'startDay': project.startDay,
                      'endDay': project.endDay,
                      'about': project.about,
                      'percentage': project.percentage,
                    });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom:
                          BorderSide(color: Colors.grey.shade200, width: 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.id,
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        Text(
                          project.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(project.status),
                      ],
                    ),
                    Column(
                      children: [
                        PieChartProgress(percentage: project.percentage),
                        Text('${project.percentage.toInt()}%'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ),
  );
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
