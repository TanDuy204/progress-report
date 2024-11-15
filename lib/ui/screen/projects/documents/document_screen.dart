import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_progressreport/components/add/add_documents.dart';
import 'package:intern_progressreport/controllers/document_controller.dart';

class DocumentScreen extends StatelessWidget {
  DocumentScreen({super.key});
  final DocumentController documentController = Get.put(DocumentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tài liệu'),
        actions: [
          _buildIconButtonAppbar(Icons.more_horiz, () {
            print("avcd");
          }),
          _buildIconButtonAppbar(Icons.search, () {
            print("avcd");
          }),
          _buildIconButtonAppbar(Icons.add, () {
            Get.to(AddDocuments(documentController: documentController));
          }),
        ],
      ),
      body: Container(
        color: Colors.grey.shade200,
        padding: EdgeInsets.only(top: 10),
        child: Obx(
          () => ListView.builder(
            itemCount: documentController.documents.length,
            itemBuilder: (context, index) {
              final document = documentController.documents[index];

              final imageName = document.images.isNotEmpty
                  ? document.images[0].path.split('/').last
                  : "No Image";

              final videoName = document.videos.isNotEmpty
                  ? document.videos[0].path.split('/').last
                  : "No Video";

              final fileName = document.files.isNotEmpty
                  ? document.files[0].path!.split('/').last
                  : "No File";

              return Container(
                padding: EdgeInsets.only(right: 10),
                color: Colors.white,
                child: Row(
                  children: [
                    if (document.images.isNotEmpty)
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: Image.file(
                          File(document.images[0].path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (document.videos.isNotEmpty)
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: Icon(Icons.video_library,
                            size: 40, color: Colors.blueAccent),
                      ),
                    if (document.files.isNotEmpty)
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: Icon(Icons.insert_drive_file,
                            size: 40, color: Colors.blueAccent),
                      ),

                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document.images.isNotEmpty
                              ? imageName
                              : (document.videos.isNotEmpty
                                  ? videoName
                                  : fileName),
                        ),
                        Text(
                          "Nguyen Duy - ${document.createDay}",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.delete_outline),
                                      title: Text("Xóa"),
                                      onTap: () {},
                                    ),
                                    ListTile(
                                      leading:
                                          Icon(Icons.arrow_downward_outlined),
                                      title: Text("Tải xuống"),
                                      onTap: () {},
                                    ),
                                    Divider(height: 1),
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text("Hủy"))
                                  ],
                                ),
                              );
                            });
                      },
                      child: Icon(
                        Icons.more_vert_outlined,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
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
