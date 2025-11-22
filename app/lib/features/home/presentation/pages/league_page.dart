import 'package:app/core/logger/logger.dart';
import 'package:app/core/network/dio_module.dart';
import 'package:app/di.dart';
import 'package:app/features/auth/data/data/user_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LeaguePage extends StatefulWidget {
  const LeaguePage({super.key});

  @override
  State<LeaguePage> createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> {
  MyLeagueState? _myLeague;
  List<LeaderboardEntry> _leaderboard = const [];
  List<LeagueInfo> _allLeagues = const [];
  List<LeagueHistoryEntry> _history = const [];

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    setState(() => _loading = true);
    await Future.wait([
      loadMyLeague(),
      loadLeaderboard(),
      loadAllLeagues(),
      loadLeagueHistory(),
    ]);
    if (mounted) {
      setState(() => _loading = false);
    }
  }

  Future<void> loadMyLeague() async {
    try {
      final token = await getIt<UserData>().getToken();
      if (token == null || token.isEmpty) {
        _redirectToRegister();
        return;
      }

      final response = await dio.get('/leagues/my-league', queryParameters: {'token': token});
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final state = MyLeagueState.fromJson(Map<String, dynamic>.from(response.data as Map));
        if (mounted) setState(() => _myLeague = state);
      } else {
        _showError('Не удалось загрузить лигу');
      }
    } on DioException catch (e) {
      _handleDioError(e, 'Не удалось загрузить лигу');
    } catch (e) {
      logger.e('loadMyLeague error: $e');
      _showError('Не удалось загрузить лигу');
    }
  }

  Future<void> loadLeaderboard() async {
    try {
      final token = await getIt<UserData>().getToken();
      if (token == null || token.isEmpty) {
        _redirectToRegister();
        return;
      }

      final response = await dio.get('/leagues/leaderboard', queryParameters: {'token': token});
      if (response.statusCode == 200 && response.data is List) {
        final entries = (response.data as List)
            .whereType<Map<String, dynamic>>()
            .map(LeaderboardEntry.fromJson)
            .toList();
        if (mounted) setState(() => _leaderboard = entries);
      } else {
        _showError('Не удалось загрузить таблицу');
      }
    } on DioException catch (e) {
      _handleDioError(e, 'Не удалось загрузить таблицу');
    } catch (e) {
      logger.e('loadLeaderboard error: $e');
      _showError('Не удалось загрузить таблицу');
    }
  }

  Future<void> loadAllLeagues() async {
    try {
      final response = await dio.get('/leagues/all-leagues');
      if (response.statusCode == 200 && response.data is List) {
        final leagues = (response.data as List)
            .whereType<Map<String, dynamic>>()
            .map(LeagueInfo.fromJson)
            .toList()
          ..sort((a, b) => a.level.compareTo(b.level));
        if (mounted) setState(() => _allLeagues = leagues);
      } else {
        _showError('Не удалось загрузить награды лиг');
      }
    } on DioException catch (e) {
      _handleDioError(e, 'Не удалось загрузить награды лиг');
    } catch (e) {
      logger.e('loadAllLeagues error: $e');
      _showError('Не удалось загрузить награды лиг');
    }
  }

  Future<void> loadLeagueHistory({int limit = 10}) async {
    try {
      final token = await getIt<UserData>().getToken();
      if (token == null || token.isEmpty) {
        _redirectToRegister();
        return;
      }

      final response = await dio.get(
        '/leagues/history',
        queryParameters: {'token': token, 'limit': limit},
      );
      if (response.statusCode == 200 && response.data is List) {
        final history = (response.data as List)
            .whereType<Map<String, dynamic>>()
            .map(LeagueHistoryEntry.fromJson)
            .toList();
        if (mounted) setState(() => _history = history);
      } else {
        _showError('Не удалось загрузить историю лиг');
      }
    } on DioException catch (e) {
      _handleDioError(e, 'Не удалось загрузить историю лиг');
    } catch (e) {
      logger.e('loadLeagueHistory error: $e');
      _showError('Не удалось загрузить историю лиг');
    }
  }

  void _handleDioError(DioException e, String fallback) {
    final code = e.response?.statusCode ?? 0;
    logger.e('$fallback: $e');
    if (code == 401 || code == 403 || code == 422) {
      _redirectToRegister();
      return;
    }
    _showError(fallback);
  }

  void _redirectToRegister() {
    if (!mounted) return;
    context.go('/register');
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 1100;
            final content = isCompact
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LeftColumn(myLeague: _myLeague),
                      const SizedBox(height: 16),
                      _CenterColumn(entries: _leaderboard),
                      const SizedBox(height: 16),
                      _RightColumn(leagues: _allLeagues, myLeague: _myLeague),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: _LeftColumn(myLeague: _myLeague)),
                      const SizedBox(width: 16),
                      Expanded(flex: 5, child: _CenterColumn(entries: _leaderboard)),
                      const SizedBox(width: 16),
                      Expanded(flex: 3, child: _RightColumn(leagues: _allLeagues, myLeague: _myLeague)),
                    ],
                  );

            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: content,
                  ),
                ),
                if (_loading)
                  const Positioned.fill(
                    child: ColoredBox(
                      color: Colors.black38,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LeftColumn extends StatelessWidget {
  const _LeftColumn({required this.myLeague});

  final MyLeagueState? myLeague;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final league = myLeague?.league;
    final progress = (myLeague?.progress ?? 0).clamp(0.0, 1.0);
    final weeklyCoins = myLeague?.weeklyCoins ?? 0;
    final rank = myLeague?.rank ?? 0;
    final total = myLeague?.totalParticipants ?? 0;
    final weekEnd = myLeague?.weekEnd;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Твоя лига', style: textTheme.titleLarge),
        const SizedBox(height: 12),
        _CardShell(
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: Colors.brown,
                child: Text(
                  league?.colorEmoji ?? '🥉',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      league?.name ?? 'Лига не найдена',
                      style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      league != null
                          ? 'Ваш уровень: ${league.level}'
                          : 'Играйте каждую неделю, чтобы удержаться и подняться выше.',
                      style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _CardShell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Прогресс за неделю', style: textTheme.titleMedium),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  backgroundColor: Colors.white12,
                  valueColor: const AlwaysStoppedAnimation(Colors.lightGreenAccent),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${(progress * 100).round()}%', style: textTheme.bodyLarge),
                  Text('$weeklyCoins', style: textTheme.bodyLarge),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Ранг: $rank из $total участников',
                style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 12),
              _CountdownCard(
                highlight: true,
                label: 'Обновление через',
                value: weekEnd != null ? _formatCountdown(weekEnd) : '—',
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatCountdown(DateTime end) {
    final now = DateTime.now();
    final diff = end.difference(now).isNegative ? Duration.zero : end.difference(now);
    final days = diff.inDays;
    final hours = diff.inHours.remainder(24).toString().padLeft(2, '0');
    final minutes = diff.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = diff.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$days д. $hours:$minutes:$seconds';
  }
}

class _CenterColumn extends StatelessWidget {
  const _CenterColumn({required this.entries});

  final List<LeaderboardEntry> entries;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Турнирная таблица', style: textTheme.titleLarge),
        const SizedBox(height: 12),
        _CardShell(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Ранг',
                      style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      'Участник',
                      style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Очки',
                        style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, color: Colors.white12),
              const SizedBox(height: 4),
              if (entries.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text('Нет данных', style: textTheme.bodyMedium?.copyWith(color: Colors.white54)),
                )
              else
                ...entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            entry.rank.toString(),
                            style: textTheme.bodyLarge,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.white10,
                                child: Text(
                                  entry.initials,
                                  style: textTheme.labelLarge,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  '${entry.name} ${entry.surname}',
                                  style: textTheme.bodyLarge,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              entry.weeklyCoins.toString(),
                              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RightColumn extends StatelessWidget {
  const _RightColumn({required this.leagues, required this.myLeague});

  final List<LeagueInfo> leagues;
  final MyLeagueState? myLeague;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final weekEnd = myLeague?.weekEnd;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Награды лиг', style: textTheme.titleLarge),
        const SizedBox(height: 12),
        if (leagues.isEmpty)
          _CardShell(
            child: Text(
              'Нет данных',
              style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
            ),
          )
        else
          ...leagues.map(
            (tier) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _CardShell(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white10,
                      child: Text(
                        tier.colorEmoji,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tier.name,
                          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Уровень: ${tier.level}',
                          style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        _CountdownCard(
          label: 'Обновление через',
          value: weekEnd != null ? _formatCountdown(weekEnd) : '—',
        ),
      ],
    );
  }

  String _formatCountdown(DateTime end) {
    final now = DateTime.now();
    final diff = end.difference(now).isNegative ? Duration.zero : end.difference(now);
    final days = diff.inDays;
    final hours = diff.inHours.remainder(24).toString().padLeft(2, '0');
    final minutes = diff.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = diff.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$days д. $hours:$minutes:$seconds';
  }
}

class _CountdownCard extends StatelessWidget {
  const _CountdownCard({this.highlight = false, required this.label, required this.value});

  final bool highlight;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = highlight ? Colors.greenAccent : Colors.blueAccent;
    return _CardShell(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      borderColor: color.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: textTheme.headlineSmall?.copyWith(color: color, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  const _CardShell({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderColor,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor ?? Colors.white12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: padding,
      child: child,
    );
  }
}

class MyLeagueState {
  MyLeagueState({
    required this.inLeague,
    required this.league,
    required this.weeklyCoins,
    required this.rank,
    required this.totalParticipants,
    required this.weekStart,
    required this.weekEnd,
  });

  final bool inLeague;
  final LeagueInfo league;
  final int weeklyCoins;
  final int rank;
  final int totalParticipants;
  final DateTime weekStart;
  final DateTime weekEnd;

  factory MyLeagueState.fromJson(Map<String, dynamic> json) {
    return MyLeagueState(
      inLeague: json['in_league'] as bool? ?? false,
      league: LeagueInfo.fromJson(Map<String, dynamic>.from(json['league'] as Map? ?? {})),
      weeklyCoins: json['weekly_coins'] as int? ?? 0,
      rank: json['rank'] as int? ?? 0,
      totalParticipants: json['total_participants'] as int? ?? 0,
      weekStart: DateTime.tryParse(json['week_start'] as String? ?? '') ?? DateTime.now(),
      weekEnd: DateTime.tryParse(json['week_end'] as String? ?? '') ?? DateTime.now(),
    );
  }

  double get progress {
    if (totalParticipants <= 0 || rank <= 0) return 0;
    return 1 - (rank - 1) / totalParticipants;
  }
}

class LeagueInfo {
  const LeagueInfo({
    required this.id,
    required this.level,
    required this.name,
    required this.colorEmoji,
  });

  final int id;
  final int level;
  final String name;
  final String colorEmoji;

  factory LeagueInfo.fromJson(Map<String, dynamic> json) => LeagueInfo(
        id: json['id'] as int? ?? 0,
        level: json['level'] as int? ?? 0,
        name: json['name'] as String? ?? '—',
        colorEmoji: json['color_emoji'] as String? ?? '🏅',
      );
}

class LeaderboardEntry {
  const LeaderboardEntry({
    required this.rank,
    required this.userId,
    required this.name,
    required this.surname,
    required this.weeklyCoins,
    required this.totalParticipants,
  });

  final int rank;
  final int userId;
  final String name;
  final String surname;
  final int weeklyCoins;
  final int totalParticipants;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) => LeaderboardEntry(
        rank: json['rank'] as int? ?? 0,
        userId: json['user_id'] as int? ?? 0,
        name: json['name'] as String? ?? '',
        surname: json['surname'] as String? ?? '',
        weeklyCoins: json['weekly_coins'] as int? ?? 0,
        totalParticipants: json['total_participants'] as int? ?? 0,
      );

  String get initials {
    if (name.isEmpty && surname.isEmpty) return 'XX';
    final first = name.isNotEmpty ? name[0] : '';
    final last = surname.isNotEmpty ? surname[0] : '';
    final result = (first + last).trim();
    return result.isEmpty ? '??' : result.toUpperCase();
  }
}

class LeagueHistoryEntry {
  const LeagueHistoryEntry({
    required this.weekStart,
    required this.weekEnd,
    required this.leagueName,
    required this.leagueLevel,
    required this.weeklyCoins,
    required this.finalRank,
    required this.totalParticipants,
    required this.percentile,
    required this.promoted,
    required this.nextLeagueName,
  });

  final DateTime weekStart;
  final DateTime weekEnd;
  final String leagueName;
  final int leagueLevel;
  final int weeklyCoins;
  final int finalRank;
  final int totalParticipants;
  final double percentile;
  final bool promoted;
  final String nextLeagueName;

  factory LeagueHistoryEntry.fromJson(Map<String, dynamic> json) => LeagueHistoryEntry(
        weekStart: DateTime.tryParse(json['week_start'] as String? ?? '') ?? DateTime.now(),
        weekEnd: DateTime.tryParse(json['week_end'] as String? ?? '') ?? DateTime.now(),
        leagueName: json['league_name'] as String? ?? '',
        leagueLevel: json['league_level'] as int? ?? 0,
        weeklyCoins: json['weekly_coins'] as int? ?? 0,
        finalRank: json['final_rank'] as int? ?? 0,
        totalParticipants: json['total_participants'] as int? ?? 0,
        percentile: (json['percentile'] as num?)?.toDouble() ?? 0,
        promoted: json['promoted'] as bool? ?? false,
        nextLeagueName: json['next_league_name'] as String? ?? '',
      );
}
