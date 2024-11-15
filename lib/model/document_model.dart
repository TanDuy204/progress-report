import 'dart:io';

import 'package:file_picker/file_picker.dart';

class DocumentModel {
  String id;
  String createDay;
  List<File> images;
  List<File> videos;
  List<PlatformFile> files;

  DocumentModel({
    required this.id,
    required this.createDay,
    required this.images,
    required this.videos,
    required this.files,
  });
}
