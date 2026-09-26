class Student {
  const Student({
    required this.name,
    required this.grade,
    required this.overallScore,
    required this.strongTopic,
    required this.focusTopic,
    required this.homeworkDone,
    required this.homeworkTotal,
  });

  final String name;
  final int grade;
  final int overallScore;
  final String strongTopic;
  final String focusTopic;
  final int homeworkDone;
  final int homeworkTotal;
}
