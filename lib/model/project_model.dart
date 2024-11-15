class ProjectModel {
  String id;
  String title;
  String status;
  String user;
  String createDay;
  String startDay;
  String endDay;
  String about;
  double percentage;
  String? address;

  ProjectModel(
      {required this.id,
      required this.title,
      required this.status,
      required this.user,
      required this.createDay,
      required this.startDay,
      required this.endDay,
      required this.about,
      this.percentage = 0.0,
      this.address});
}

List<ProjectModel> getProjects() {
  return [
    ProjectModel(
      id: "To-1",
      title: "Dự Án Môi Trường",
      status: "Đang hoạt động",
      user: "Nguyễn Duy",
      createDay: '20/01/2022',
      startDay: "20/1/2022",
      endDay: "20/2/2022",
      about: '',
    ),
    ProjectModel(
      id: "To-2",
      title: "Dự Api",
      status: "Đang hoạt động",
      user: "Nguyễn Duy",
      createDay: '20/01/2022',
      startDay: "20/1/2022",
      endDay: "20/2/2022",
      about: '',
    ),
    ProjectModel(
      id: "To-3",
      title: "Dự án cơ sở dữ liệu",
      status: "Đang hoạt động",
      user: "Nguyễn Duy",
      createDay: '20/01/2022',
      startDay: "20/1/2022",
      endDay: "20/2/2022",
      about: '',
    ),
    ProjectModel(
      id: "To-4",
      title: "Dự án nhập hàng",
      status: "Đang hoạt động",
      user: "Nguyễn Duy",
      createDay: '20/01/2022',
      startDay: "20/1/2022",
      endDay: "20/2/2022",
      about: '',
    ),
    ProjectModel(
      id: "To-5",
      title: "Dự án hoạt đông môi trường",
      status: "Đang hoạt động",
      user: "Nguyễn Duy",
      createDay: '20/01/2022',
      startDay: "20/1/2022",
      endDay: "20/2/2022",
      about: '',
    ),
  ];
}
