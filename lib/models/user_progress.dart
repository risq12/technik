class UserProgress {
  const UserProgress({
    this.totalXp = 340,
    this.level = 3,
    this.learningStreakDays = 5,
    this.completedLessons = 12,
    this.totalLessons = 40,
  });

  final int totalXp;
  final int level;
  final int learningStreakDays;
  final int completedLessons;
  final int totalLessons;

  double get completion =>
      totalLessons == 0 ? 0 : completedLessons / totalLessons;

  int get xpToNextLevel => 500 - (totalXp % 500);
}
