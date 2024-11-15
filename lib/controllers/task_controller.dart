import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intern_progressreport/model/tasks_model.dart';

class TaskController extends GetxController {
  var tasks = <TasksModel>[].obs;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    tasks.addAll(getTasks());
  }

  void addTasks(TasksModel task) {
    tasks.add(task);
  }

  void removeTasks(String id) {
    tasks.removeWhere((element) => element.id == id);
  }

  void updateTask(String id, TasksModel updateTasks) {
    var index = tasks.indexWhere(
      (element) => element.id == id,
    );
    if (index != -1) {
      tasks[index] = updateTasks;
    }
  }

  void updateDeadline(String id, String newDeadline) {
    var index = tasks.indexWhere(
      (element) => element.id == id,
    );
    if (index != -1) {
      tasks[index].deadline = newDeadline;
      tasks.refresh();
    }
  }

  Future<void> pickImageGallery(String id) async {
    final List<XFile>? images = await _picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      List<String> imagePaths = images.map((image) => image.path).toList();
      TasksModel? task = tasks.firstWhereOrNull((task) => task.id == id);

      if (task != null) {
        task.images ??= [];
        task.images!.addAll(imagePaths);
        tasks.refresh();
      }
    }
  }

  Future<void> pickImageCamera(String id) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      String imagePath = image.path;
      TasksModel? task = tasks.firstWhereOrNull((task) => task.id == id);
      if (task != null) {
        task.images ??= [];
        task.images!.add(imagePath);
        tasks.refresh();
      }
    }
  }

  Future<void> pickVideoGallery(String id) async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      String videoPath = video.path;
      TasksModel? task = tasks.firstWhereOrNull((task) => task.id == id);
      if (task != null) {
        task.videos ??= [];
        task.videos!.add(videoPath);
        tasks.refresh();
      }
    }
  }

  Future<void> pickFile(String id) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      List<String> filePaths = result.paths.whereType<String>().toList();
      print('duong dan: $filePaths');

      TasksModel? task = tasks.firstWhereOrNull((task) => task.id == id);
      if (task != null) {
        task.files ??= [];
        task.files!.addAll(filePaths);
        tasks.refresh();
      }
    }
  }

  void removeImage(String id, String imagePath) {
    TasksModel? task = tasks.firstWhereOrNull(
      (element) => element.id == id,
    );
    if (task != null) {
      task.images!.remove(imagePath);
      tasks.refresh();
    }
  }

  void removeVideo(String id, String videoPath) {
    TasksModel? task = tasks.firstWhereOrNull(
      (element) => element.id == id,
    );
    if (task != null) {
      task.videos!.remove(videoPath);
      tasks.refresh();
    }
  }

  void removeFile(String id, String filePath) {
    TasksModel? task = tasks.firstWhereOrNull(
      (element) => element.id == id,
    );
    if (task != null) {
      task.files!.remove(filePath);
      tasks.refresh();
    }
  }
}
