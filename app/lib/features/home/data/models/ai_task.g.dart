// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiTask _$AiTaskFromJson(Map<String, dynamic> json) => _AiTask(
  task_id: (json['task_id'] as num).toInt(),
  name: json['name'] as String,
  coin_reward: (json['coin_reward'] as num).toInt(),
  expires_at: json['expires_at'] as String,
);

Map<String, dynamic> _$AiTaskToJson(_AiTask instance) => <String, dynamic>{
  'task_id': instance.task_id,
  'name': instance.name,
  'coin_reward': instance.coin_reward,
  'expires_at': instance.expires_at,
};
