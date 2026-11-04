enum LessonContentType { text, image, formula, interactive }

class Lesson {
  const Lesson({
    required this.id,
    required this.courseId,
    required this.title,
    required this.content,
    required this.order,
    this.estimatedMinutes = 5,
  });

  final String id;
  final String courseId;
  final String title;
  final String content;
  final int order;
  final int estimatedMinutes;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json['id'] as String,
        courseId: json['courseId'] as String,
        title: json['title'] as String,
        content: json['content'] as String,
        order: json['order'] as int,
        estimatedMinutes: json['estimatedMinutes'] as int? ?? 5,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'courseId': courseId,
        'title': title,
        'content': content,
        'order': order,
        'estimatedMinutes': estimatedMinutes,
      };
}
