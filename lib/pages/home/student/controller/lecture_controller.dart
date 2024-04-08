class Lecture {
  final int lectureId;
  final String title;
  final String description;
  final String subject;
  final String date;
  final String time;
  final String duration;
  final bool isCompleted;

  Lecture({
    required this.lectureId,
    required this.title,
    required this.description,
    required this.subject,
    required this.date,
    required this.time,
    required this.duration,
    required this.isCompleted,
  });
}

class LectureData {
  List<Lecture> lectures = [
    Lecture(
      lectureId: 0,
      title: "Lecture 1",
      description: "This is the first lecture",
      subject: "Maths",
      date: "12/12/2021",
      time: "12:00",
      duration: "1 hour",
      isCompleted: false,
    ),
    Lecture(
      lectureId: 1,
      title: "Lecture 2",
      description: "This is the second lecture",
      subject: "Physics",
      date: "12/12/2021",
      time: "12:00",
      duration: "1 hour",
      isCompleted: false,
    ),
  ];
}
