import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intern_progressreport/controllers/document_controller.dart';
import 'package:intern_progressreport/model/document_model.dart';
import 'package:intl/intl.dart';

class AddDocuments extends StatefulWidget {
  final DocumentController documentController;
  const AddDocuments({super.key, required this.documentController});

  @override
  State<AddDocuments> createState() => _AddDocumentsState();
}

class _AddDocumentsState extends State<AddDocuments> {
  final ImagePicker _picker = ImagePicker();
  final List<File> _images = [];
  final List<File> _video = [];
  final List<PlatformFile> _files = [];

  Future<void> _pickImage() async {
    final List<XFile> image = await _picker.pickMultiImage();
    setState(() {
      _images.addAll(image.map((e) => File(e.path)));
    });
  }

  Future<void> _pickCamera() async {
    final XFile? camera = await _picker.pickImage(source: ImageSource.camera);
    if (camera != null) {
      setState(() {
        _images.add(File(camera.path));
      });
    }
  }

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _video.add(File(video.path));
      });
    }
  }

  Future<void> _pickFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _files.addAll(result.files);
      });
    }
  }

  void _saveDocument() {
    DateTime now = DateTime.now();
    String fommatedDay = DateFormat('dd/MM/yyyy HH:mm').format(now);

    DocumentModel newDocument = DocumentModel(
      id: '1',
      createDay: fommatedDay,
      images: _images,
      videos: _video,
      files: _files,
    );

    widget.documentController.addDocument(newDocument);
    Get.back();
  }

  Widget _buildDocumentIcon(String title) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              color: Colors.grey,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 22),
              child: Text(title),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 7, bottom: 7),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  (_images.length + _video.length + _files.length) + 1,
                  (index) {
                    if (index ==
                        _images.length + _video.length + _files.length) {
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: Text("Chọn ảnh"),
                                      leading: Icon(Icons.camera_alt_outlined),
                                      onTap: () {
                                        _pickImage();
                                        Get.back();
                                      },
                                    ),
                                    ListTile(
                                      title: Text("Chụp ảnh"),
                                      leading: Icon(Icons.image_outlined),
                                      onTap: () {
                                        _pickCamera();
                                        Get.back();
                                      },
                                    ),
                                    ListTile(
                                      title: Text("Video"),
                                      leading:
                                          Icon(Icons.video_library_outlined),
                                      onTap: () {
                                        _pickVideo();
                                        Get.back();
                                      },
                                    ),
                                    ListTile(
                                      title: Text("Tập tin"),
                                      leading: Icon(Icons.file_copy_outlined),
                                      onTap: () {
                                        _pickFile();
                                        Get.back();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.blueAccent,
                            size: 30,
                          ),
                        ),
                      );
                    }
                    if (index < _images.length) {
                      return SizedBox(
                        height: 75,
                        width: 75,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else if (index < _images.length + _video.length) {
                      return Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.video_library_outlined,
                          color: Colors.blueAccent,
                          size: 30,
                        ),
                      );
                    } else {
                      return Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.file_copy_outlined,
                          color: Colors.blueAccent,
                          size: 30,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Thêm Tài Liệu",
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
            onPressed: _saveDocument, // Lưu tài liệu
            child: Text(
              "Lưu",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Thông Tin Tài Liệu",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade100, width: 2),
            ),
            child: Column(
              children: [
                _buildDocument('Dự Án'),
                _buildDocumentIcon('Chọn tập tin'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildDocument(String title) {
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: double.infinity,
            color: Colors.grey,
            padding: EdgeInsets.symmetric(vertical: 22),
            child: Center(child: Text(title)),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextField(
            decoration: InputDecoration(border: UnderlineInputBorder()),
          ),
        ),
      ],
    ),
  );
}
