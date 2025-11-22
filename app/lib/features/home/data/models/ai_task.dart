import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_task.freezed.dart';
part 'ai_task.g.dart';

@freezed
abstract class AiTask with _$AiTask {
  const factory AiTask({
    required int task_id,
    required String name,
    required int coin_reward,
    required String expires_at,
  }) = _AiTask;

  factory AiTask.fromJson(Map<String, dynamic> json) => _$AiTaskFromJson(json);
}
