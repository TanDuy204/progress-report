import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intern_progressreport/model/project_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectController extends GetxController {
  var projects = <ProjectModel>[].obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var address = ''.obs;

  @override
  void onInit() {
    super.onInit();
    projects.addAll(getProjects());
  }

  void addProject(ProjectModel project) {
    projects.add(project);
  }

  void removeProject(String id) {
    projects.removeWhere((project) => project.id == id);
  }

  void updateProject(String id, ProjectModel updateProject) {
    var index = projects.indexWhere((project) => project.id == id);
    if (index != -1) {
      projects[index] = updateProject;
    }
  }

  void updateProjectStatus(String projectId, String newStatus) {
    var index = projects.indexWhere((proj) => proj.id == projectId);
    if (index != -1) {
      projects[index].status = newStatus;
      projects.refresh();
    }
  }

  void updateProjectPercentage(String id, double newPercentage) {
    var index = projects.indexWhere((element) => element.id == id);
    if (index != -1) {
      projects[index].percentage = newPercentage;
      projects.refresh();
    }
  }

  Future<void> getCurrentLocation(ProjectModel project) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Dịch vụ định vị bị tắt");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Quyền truy cập vị trí đã bị từ chối");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Quyền truy cập vị trí đã bị từ chối vĩnh viễn, không thể yêu cầu quyền");
    }

    Position position = await Geolocator.getCurrentPosition();

    latitude.value = position.latitude;
    longitude.value = position.longitude;

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      address.value =
          '${place.street}, ${place.locality}, ${place.administrativeArea}';
    }

    project.address = address.value;
    print(address.value);
    projects.refresh();
  }

  Future<void> openMap() async {
    final Uri webUrl = Uri.parse(
        "https://maps.google.com/?q=${latitude.value},${longitude.value}");
    if (await canLaunchUrl(webUrl)) {
      await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch maps';
    }
  }
}
