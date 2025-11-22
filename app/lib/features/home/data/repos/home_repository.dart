import 'package:app/features/home/data/models/ai_task.dart';
import 'package:dio/dio.dart';
import '../models/event_task.dart';
import '../models/task_stats.dart';
import '../../../../core/network/dio_module.dart';

class HomeRepository {
  final Dio _dio = dio;

  // Получить все задачи
  Future<List<EventTask>> getAllTasks() async {
    try {
      final response = await _dio.get('/tasks/available');
      final List<dynamic> data = response.data;
      return data.map((json) => EventTask.fromJson(json)).toList();
    } catch (e) {
      print('Error loading all tasks: $e');
      return [];
    }
  }

  // Получить мои выполненные задачи
  Future<List<EventTask>> getMyCompletions() async {
    try {
      final response = await _dio.get('/tasks/my-completions');
      final List<dynamic> data = response.data;
      return data.map((json) => EventTask.fromJson(json)).toList();
    } catch (e) {
      print('Error loading my completions: $e');
      return [];
    }
  }

  // Получить статистику
  Future<TaskStats?> getStats() async {
    try {
      final response = await _dio.get('/tasks/stats');
      return TaskStats.fromJson(response.data);
    } catch (e) {
      print('Error loading stats: $e');
      return null;
    }
  }

  // Запросить новое случайное задание
  Future<AiTask?> requestAITask() async {
    try {
      final response = await _dio.post('/tasks/generate-personal');
      return AiTask.fromJson(response.data);
    } catch (e) {
      print('Error requesting random task: $e');
      return null;
    }
  }

  // Завершить задание
  Future<bool> completeTask(int taskId) async {
    try {
      await _dio.post('/tasks/$taskId/complete');
      return true;
    } catch (e) {
      print('Error completing task: $e');
      return false;
    }
  }
}
