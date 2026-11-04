class TechnicalCategory {
  const TechnicalCategory({
    required this.id,
    required this.namePl,
    required this.nameEn,
    required this.descriptionPl,
    required this.descriptionEn,
    required this.iconCodePoint,
    required this.courseCount,
    required this.lessonCount,
  });

  final String id;
  final String namePl;
  final String nameEn;
  final String descriptionPl;
  final String descriptionEn;
  final int iconCodePoint;
  final int courseCount;
  final int lessonCount;

  String name(bool english) => english ? nameEn : namePl;
  String description(bool english) =>
      english ? descriptionEn : descriptionPl;

  factory TechnicalCategory.fromJson(Map<String, dynamic> json) {
    return TechnicalCategory(
      id: json['id'] as String,
      namePl: json['namePl'] as String,
      nameEn: json['nameEn'] as String,
      descriptionPl: json['descriptionPl'] as String,
      descriptionEn: json['descriptionEn'] as String,
      iconCodePoint: json['iconCodePoint'] as int,
      courseCount: json['courseCount'] as int? ?? 0,
      lessonCount: json['lessonCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'namePl': namePl,
        'nameEn': nameEn,
        'descriptionPl': descriptionPl,
        'descriptionEn': descriptionEn,
        'iconCodePoint': iconCodePoint,
        'courseCount': courseCount,
        'lessonCount': lessonCount,
      };
}
