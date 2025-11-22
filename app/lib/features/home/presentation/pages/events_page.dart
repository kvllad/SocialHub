import 'package:flutter/material.dart';
import '../../data/models/event_task.dart';
import '../../data/models/task_stats.dart';
import '../../data/repos/home_repository.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  int streak = 0;

  final HomeRepository _repository = HomeRepository();

  List<EventTask> allTasks = [];
  List<EventTask> completedTasks = [];
  TaskStats? stats;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);
    await Future.wait([
      loadAllTasks(),
      loadMyCompletions(),
      loadStats(),
    ]);
    setState(() => isLoading = false);
  }

  Future<void> loadAllTasks() async {
    final tasks = await _repository.getAllTasks();
    setState(() {
      allTasks = tasks;
    });
  }

  Future<void> loadMyCompletions() async {
    final tasks = await _repository.getMyCompletions();
    setState(() {
      completedTasks = tasks;
    });
  }

  Future<void> loadStats() async {
    final taskStats = await _repository.getStats();
    setState(() {
      stats = taskStats;
    });
  }

  Future<void> requestNewTask() async {
    final newTask = await _repository.requestAITask();
    if (newTask != null) {
      setState(() {
        allTasks.add(
          EventTask(
            id: newTask.task_id,
            name: newTask.name,
            description: 'Новая сгенерированная задача',
            coinReward: newTask.coin_reward,
            taskType: 'АИ',
            isActive: true,
          ),
        );
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Новое задание получено!')),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ошибка получения задания')),
        );
      }
    }
  }

  Future<void> completeTask(int id) async {
    final success = await _repository.completeTask(id);
    if (success) {
      setState(() {
        final task = allTasks.firstWhere((t) => t.id == id);
        allTasks.removeWhere((t) => t.id == id);
        completedTasks.insert(0, task);
      });
      await loadStats();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Задание выполнено!')),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ошибка выполнения задания')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('События'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Все задачи'),
              Tab(text: 'Мои выполнения'),
            ],
          ),
        ),
        body: Column(
          children: [
            _buildStatsRow(),
            Expanded(
              child: TabBarView(
                children: [
                  _buildAllTasksTab(),
                  _buildCompletedTasksTab(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: requestNewTask,
          icon: const Icon(Icons.add),
          label: const Text('Получить новое событие'),
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    if (stats == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            'Сегодня',
            stats!.completedToday.toString(),
            Icons.today,
          ),
          _buildStatItem(
            'За всё время',
            stats!.totalCompleted.toString(),
            Icons.check_circle,
          ),
          _buildStatItem(
            'Наград заработано',
            stats!.totalCoinsEarned.toString(),
            Icons.monetization_on,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildAllTasksTab() {
    if (allTasks.isEmpty) {
      return const Center(
        child: Text('Нет доступных заданий'),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: buildTaskCards(allTasks, isCompleted: false),
      ),
    );
  }

  Widget _buildCompletedTasksTab() {
    if (completedTasks.isEmpty) {
      return const Center(
        child: Text('Нет выполненных заданий'),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: buildCompletedCards(completedTasks),
      ),
    );
  }

  List<Widget> buildTaskCards(List<EventTask> tasks, {required bool isCompleted}) {
    return tasks.map((task) => _buildTaskCard(task, isCompleted: isCompleted)).toList();
  }

  List<Widget> buildCompletedCards(List<EventTask> tasks) {
    return tasks.map((task) => _buildTaskCard(task, isCompleted: true)).toList();
  }

  Widget _buildTaskCard(EventTask task, {required bool isCompleted}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    task.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.monetization_on, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        '+${task.coinReward}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              task.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
            if (task.expiresAt != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.timer, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    'Истекает: ${_formatDateTime(task.expiresAt!)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            if (!isCompleted)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => completeTask(task.id),
                  icon: const Icon(Icons.check),
                  label: const Text('Выполнить'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      'Выполнено',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = dateTime.difference(now);

    if (difference.isNegative) {
      return 'Истекло';
    }

    if (difference.inDays > 0) {
      return '${difference.inDays} дн.';
    }

    if (difference.inHours > 0) {
      return '${difference.inHours} ч.';
    }

    return '${difference.inMinutes} мин.';
  }
}
