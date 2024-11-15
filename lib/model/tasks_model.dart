class TasksModel {
  String id;
  String title;
  String about;
  String createDay;
  String deadline;
  String startDay;
  String endDay;
  List<String>? images;
  List<String>? videos;
  List<String>? files;

  TasksModel({
    required this.id,
    required this.title,
    required this.about,
    required this.createDay,
    required this.deadline,
    required this.startDay,
    required this.endDay,
    this.images,
    this.files,
    this.videos,
  });
}

List<TasksModel> getTasks() {
  return [
    TasksModel(
        id: 'Ta-1',
        title: 'Thiết lập api cho dự án',
        about: 'Phân chia công việc',
        createDay: '12/9/2024 08:44',
        deadline: '25/12/2024',
        startDay: '21/12/2024',
        endDay: '27/12/2024'),
    TasksModel(
        id: 'Ta-2',
        title: 'Làm back_end',
        about: 'Phân chia công việc',
        createDay: '12/9/2024 08:44',
        deadline: '25/12/2024',
        startDay: '21/12/2024',
        endDay: '27/12/2024'),
    TasksModel(
        id: 'Ta-3',
        title: 'Làm font_end',
        about: 'Phân chia công việc',
        createDay: '12/9/2024 08:44',
        deadline: '25/12/2024',
        startDay: '21/12/2024',
        endDay: '27/12/2024'),
    TasksModel(
        id: 'Ta-4',
        title: 'Thiết kế UI',
        about: 'Phân chia công việc',
        createDay: '12/9/2024 08:44',
        deadline: '25/12/2024',
        startDay: '21/12/2024',
        endDay: '27/12/2024'),
  ];
}
