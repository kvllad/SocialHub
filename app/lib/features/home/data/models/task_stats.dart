class TaskStats {
  final int totalCompleted;
  final int totalCoinsEarned;
  final int completedToday;

  TaskStats({
    required this.totalCompleted,
    required this.totalCoinsEarned,
    required this.completedToday,
  });

  factory TaskStats.fromJson(Map<String, dynamic> json) {
    return TaskStats(
      totalCompleted: json['total_completed'] ?? 0,
      totalCoinsEarned: json['total_coins_earned'] ?? 0,
      completedToday: json['completed_today'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_completed': totalCompleted,
      'total_coins_earned': totalCoinsEarned,
      'completed_today': completedToday,
    };
  }
}
