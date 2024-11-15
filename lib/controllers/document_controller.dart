import 'package:get/get.dart';
import 'package:intern_progressreport/model/document_model.dart';

class DocumentController extends GetxController {
  var documents = <DocumentModel>[].obs;

  void addDocument(DocumentModel document) {
    documents.add(document);
  }
}
