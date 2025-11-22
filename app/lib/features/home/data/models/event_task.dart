

class EventTask {
  final int id;
  final String name;
  final String description;
  final int coinReward;
  final String taskType;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? expiresAt;

  EventTask({
    required this.id,
    required this.name,
    required this.description,
    required this.coinReward,
    required this.taskType,
    required this.isActive,
    this.createdAt,
    this.expiresAt,
  });

  factory EventTask.fromJson(Map<String, dynamic> json) {
    return EventTask(
      id: json['id'] ?? json['task_id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      coinReward: json['coin_reward'] ?? 0,
      taskType: json['task_type'] ?? '',
      isActive: json['is_active'] ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      expiresAt: json['expires_at'] != null
          ? DateTime.tryParse(json['expires_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'coin_reward': coinReward,
      'task_type': taskType,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
      'expires_at': expiresAt?.toIso8601String(),
    };
  }
}
