class Lecture {
  final int lectureId;
  final String title;
  final String description;
  final String subject;
  final String date;
  final String time;
  final String lecturer;
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
    required this.lecturer,
    required this.isCompleted,
  });
}

class Quiz {
  final String quizId;
  final String question;
  final List options;
  final String correctAnswer;

  Quiz({
    required this.quizId,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

class CourseData {
  List course = [
    Lecture(
      lectureId: 0,
      title: "Lecture 1",
      description: "This is the first lecture",
      subject: "Maths",
      date: "12/12/2021",
      time: "12:00",
      duration: "1 hour",
      lecturer: "Chintan Dodia",
      isCompleted: false,
    ),
    Quiz(
        quizId: "1",
        question: "Capital of India",
        options: ["Delhi", "Mumbai", "Benguluru", "Telenga"],
        correctAnswer: "Delhi"),
    Lecture(
      lectureId: 1,
      title: "Lecture 2",
      description: "This is the second lecture",
      subject: "Physics",
      date: "12/12/2021",
      time: "12:00",
      duration: "1 hour",
      lecturer: "Jainam Barbhaya",
      isCompleted: false,
    ),
  ];
}
