import 'package:flutter/material.dart';

class LeaguePage extends StatelessWidget {
  const LeaguePage({super.key});

  

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
                      _LeftColumn(),
                      const SizedBox(height: 16),
                      _CenterColumn(),
                      const SizedBox(height: 16),
                      _RightColumn(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Expanded(flex: 3, child: _LeftColumn()),
                      SizedBox(width: 16),
                      Expanded(flex: 5, child: _CenterColumn()),
                      SizedBox(width: 16),
                      Expanded(flex: 3, child: _RightColumn()),
                    ],
                  );

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: content,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LeftColumn extends StatelessWidget {
  const _LeftColumn();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Твоя лига', style: textTheme.titleLarge),
        const SizedBox(height: 12),
        _CardShell(
          child: Row(
            children: [
              const CircleAvatar(
                radius: 26,
                backgroundColor: Colors.brown,
                child: Icon(Icons.military_tech, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bronze лига',
                      style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Играйте каждую неделю, чтобы удержаться и подняться выше.',
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
                child: const LinearProgressIndicator(
                  value: 0.75,
                  minHeight: 10,
                  backgroundColor: Colors.white12,
                  valueColor: AlwaysStoppedAnimation(Colors.lightGreenAccent),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('75%', style: textTheme.bodyLarge),
                  Text('5980', style: textTheme.bodyLarge),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Еще 2020 монет, чтобы войти в Silver лигу.',
                style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 12),
              _CountdownCard(highlight: true),
            ],
          ),
        ),
      ],
    );
  }
}

class _CenterColumn extends StatelessWidget {
  const _CenterColumn();

  static const List<_LeaderboardEntry> _entries = [
    _LeaderboardEntry(rank: 1, name: 'Алексей Смирнов', score: 12450),
    _LeaderboardEntry(rank: 2, name: 'Мария Иванова', score: 11870),
    _LeaderboardEntry(rank: 3, name: 'Дмитрий Ким', score: 10940),
    _LeaderboardEntry(rank: 4, name: 'Светлана Орлова', score: 9810),
    _LeaderboardEntry(rank: 5, name: 'Иван Петров', score: 9320),
    _LeaderboardEntry(rank: 6, name: 'Анна Соколова', score: 9050),
    _LeaderboardEntry(rank: 7, name: 'Сергей Лебедев', score: 8610),
    _LeaderboardEntry(rank: 8, name: 'Наталья Кравцова', score: 8325),
  ];

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
              ..._entries.map(
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
                            Expanded(child: Text(entry.name, style: textTheme.bodyLarge)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            entry.score.toString(),
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
  const _RightColumn();

  static const List<_RewardTier> _tiers = [
    _RewardTier(title: 'Bronze', subtitle: 'Мелочи', icon: Icons.military_tech, color: Colors.brown),
    _RewardTier(title: 'Silver', subtitle: 'Больше привилегий', icon: Icons.workspace_premium, color: Colors.blueGrey),
    _RewardTier(title: 'Gold', subtitle: 'Эксклюзивные награды', icon: Icons.emoji_events, color: Colors.amber),
    _RewardTier(title: 'Platinum', subtitle: 'Приглашения и бонусы', icon: Icons.star, color: Colors.cyan),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Награды лиг', style: textTheme.titleLarge),
        const SizedBox(height: 12),
        ..._tiers.map(
          (tier) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _CardShell(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: tier.color.withOpacity(0.25),
                    child: Icon(tier.icon, color: tier.color),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tier.title,
                        style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tier.subtitle,
                        style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        _CountdownCard(),
      ],
    );
  }
}

class _CountdownCard extends StatelessWidget {
  const _CountdownCard({this.highlight = false});

  final bool highlight;

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
            'Обновление через',
            style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 6),
          Text(
            '5 д. 12:08:27',
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

class _LeaderboardEntry {
  const _LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.score,
  });

  final int rank;
  final String name;
  final int score;

  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return (parts.first[0] + parts[1][0]).toUpperCase();
    }
    return name.substring(0, 2).toUpperCase();
  }
}

class _RewardTier {
  const _RewardTier({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
}
