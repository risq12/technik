class Course {
  const Course({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.level,
    required this.lessonIds,
  });

  final String id;
  final String categoryId;
  final String title;
  final String description;
  final int level;
  final List<String> lessonIds;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json['id'] as String,
        categoryId: json['categoryId'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        level: json['level'] as int,
        lessonIds: List<String>.from(json['lessonIds'] as List),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoryId': categoryId,
        'title': title,
        'description': description,
        'level': level,
        'lessonIds': lessonIds,
      };
}
