import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final accent = const Color(0xFF22C55E);
    final cardColor = const Color(0xFF111217);
    final textTheme = Theme.of(context).textTheme;
    final borderColor = Colors.white.withOpacity(0.06);

    final categories = [
      'Попапы',
      'Мега',
      'Аксессуары',
      'Коллекции',
      'Мерч',
      'Рандом',
    ];

    final sections = [
      const _ShopSection(
        title: 'Начальная лига',
        products: [
          _ShopProduct(
            name: 'Карта-приглашение',
            price: '1 рип',
            buttonLabel: 'Получить',
            available: true,
            icon: Icons.credit_card,
          ),
          _ShopProduct(
            name: 'Бейдж с ником',
            price: '1 рип',
            buttonLabel: 'Получить',
            available: true,
            icon: Icons.person_outline,
          ),
          _ShopProduct(
            name: 'Шоппер SC',
            price: '2 рипа',
            buttonLabel: 'Получить',
            available: true,
            icon: Icons.shopping_bag_outlined,
          ),
        ],
      ),
      const _ShopSection(
        title: 'Серебряная лига',
        products: [
          _ShopProduct(
            name: 'Набор патчей',
            price: '2 рипа',
            buttonLabel: 'Повысить лигу',
            available: false,
            icon: Icons.layers,
          ),
          _ShopProduct(
            name: 'Кепка Social Hub',
            price: '3 рипа',
            buttonLabel: 'Повысить лигу',
            available: false,
            icon: Icons.emoji_people,
          ),
          _ShopProduct(
            name: 'Купон на эвент',
            price: '4 рипа',
            buttonLabel: 'Повысить лигу',
            available: false,
            icon: Icons.event_available,
          ),
        ],
      ),
      _ShopSection(
        title: 'Доступно в Золотой лиге',
        tagColor: accent,
        products: const [
          _ShopProduct(
            name: 'Магнит Social Hub',
            price: '1 рип',
            buttonLabel: 'Повысить лигу',
            available: false,
            icon: Icons.bolt,
          ),
          _ShopProduct(
            name: 'Худи SC Limited',
            price: '3 рипа',
            buttonLabel: 'Повысить лигу',
            available: false,
            icon: Icons.checkroom,
          ),
          _ShopProduct(
            name: 'Набор наклеек',
            price: '2 рипа',
            buttonLabel: 'Повысить лигу',
            available: false,
            icon: Icons.emoji_emotions,
          ),
        ],
      ),
    ];

    final rulesBlock = [
      'Награды выдаются один раз в неделю.',
      'Обмен возможен только в текущей лиге.',
      'После апгрейда прогресс сохраняется.',
      'Количество предметов ограничено.',
    ];

    final history = const [
      _HistoryEntry(
        title: 'Магнит • @mila • 1 мин назад',
        delta: '-1 рип',
      ),
      _HistoryEntry(
        title: 'Худи • @andrew • 12 мин назад',
        delta: '-3 рипа',
      ),
      _HistoryEntry(
        title: 'Наклейки • @danya • 28 мин назад',
        delta: '-2 рипа',
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 260,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _leagueCard(textTheme, cardColor, borderColor, accent),
                        const SizedBox(height: 16),
                        _placeholderCard(cardColor, borderColor),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _headerRow(textTheme, accent, cardColor, borderColor),
                        const SizedBox(height: 16),
                        _categoriesRow(categories, accent, cardColor, borderColor),
                        const SizedBox(height: 24),
                        for (final section in sections) ...[
                          _sectionBlock(
                            section,
                            textTheme,
                            cardColor,
                            borderColor,
                            accent,
                          ),
                          const SizedBox(height: 24),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  SizedBox(
                    width: 280,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _rulesCard(
                          title: 'Правила магазина',
                          lines: rulesBlock,
                          cardColor: cardColor,
                          borderColor: borderColor,
                        ),
                        const SizedBox(height: 16),
                        _historyCard(
                          title: 'Последние обмены',
                          entries: history,
                          cardColor: cardColor,
                          borderColor: borderColor,
                          accent: accent,
                        ),
                        const SizedBox(height: 16),
                        _rulesCard(
                          title: 'Правила магазина',
                          lines: rulesBlock,
                          cardColor: cardColor,
                          borderColor: borderColor,
                        ),
                        const SizedBox(height: 16),
                        _historyCard(
                          title: 'Последние обмены',
                          entries: history,
                          cardColor: cardColor,
                          borderColor: borderColor,
                          accent: accent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _headerRow(
  TextTheme textTheme,
  Color accent,
  Color cardColor,
  Color borderColor,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Магазин наград',
        style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Icon(Icons.sort, color: accent, size: 18),
            const SizedBox(width: 8),
            Text(
              'Сортировать по ...',
              style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
          ],
        ),
      ),
    ],
  );
}

Widget _categoriesRow(
  List<String> categories,
  Color accent,
  Color cardColor,
  Color borderColor,
) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (int i = 0; i < categories.length; i++) ...[
          _chip(
            categories[i],
            isActive: i == 0,
            accent: accent,
            cardColor: cardColor,
            borderColor: borderColor,
          ),
          if (i != categories.length - 1) const SizedBox(width: 12),
        ],
      ],
    ),
  );
}

Widget _chip(
  String label, {
  required bool isActive,
  required Color accent,
  required Color cardColor,
  required Color borderColor,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: isActive ? accent.withOpacity(0.12) : cardColor,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: isActive ? accent : borderColor),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: isActive ? accent : Colors.white,
      ),
    ),
  );
}

Widget _sectionBlock(
  _ShopSection section,
  TextTheme textTheme,
  Color cardColor,
  Color borderColor,
  Color accent,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            section.title,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          if (section.tagColor != null) ...[
            const SizedBox(width: 8),
            _dot(color: section.tagColor!),
          ],
        ],
      ),
      const SizedBox(height: 12),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < section.products.length; i++) ...[
              _productCard(
                product: section.products[i],
                cardColor: cardColor,
                borderColor: borderColor,
                accent: accent,
              ),
              if (i != section.products.length - 1) const SizedBox(width: 16),
            ],
          ],
        ),
      ),
    ],
  );
}

Widget _productCard({
  required _ShopProduct product,
  required Color cardColor,
  required Color borderColor,
  required Color accent,
}) {
  final buttonColor = product.available ? accent : const Color(0xFF2C2F36);
  final buttonTextColor = product.available ? Colors.black : Colors.white70;

  return Container(
    width: 210,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 110,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1D23),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Icon(product.icon, size: 36, color: accent),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            _dot(color: accent),
            const SizedBox(width: 6),
            Text(
              product.price,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.greenAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 100,),
        SizedBox(
          width: double.infinity,
          height: 40,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: buttonColor,
              foregroundColor: buttonTextColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              product.buttonLabel,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _leagueCard(
  TextTheme textTheme,
  Color cardColor,
  Color borderColor,
  Color accent,
) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: borderColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Твоя лига',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 89, 62, 0), Color.fromARGB(255, 89, 62, 0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(Icons.workspace_premium, color: Colors.black),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Бронзовая',
                  style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  'Награды доступны',
                  style: textTheme.bodySmall?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF15181F),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _dot(color: accent),
                  const SizedBox(width: 8),
                  Text(
                    'Доступно в: 39:03 мин',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: accent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _dot(color: accent),
                  const SizedBox(width: 8),
                  Text(
                    '1 260 орг',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: accent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Обменивай рипы на награды. Повышай лигу, чтобы открывать новые категории и получать бонус XP.',
          style: textTheme.bodySmall?.copyWith(color: Colors.white70),
        ),
      ],
    ),
  );
}

Widget _placeholderCard(Color cardColor, Color borderColor) {
  return Container(
    height: 120,
    decoration: BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: borderColor),
    ),
    child: const Center(
      child: Text(
        'Лига бонус',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.white70,
        ),
      ),
    ),
  );
}

Widget _rulesCard({
  required String title,
  required List<String> lines,
  required Color cardColor,
  required Color borderColor,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        const SizedBox(height: 12),
        for (final line in lines) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• ', style: TextStyle(color: Colors.white54)),
              Expanded(
                child: Text(
                  line,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
        ],
      ],
    ),
  );
}

Widget _historyCard({
  required String title,
  required List<_HistoryEntry> entries,
  required Color cardColor,
  required Color borderColor,
  required Color accent,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        const SizedBox(height: 12),
        for (final entry in entries) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(
                entry.delta,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
        Text(
          'Смотреть все',
          style: TextStyle(
            color: accent,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget _dot({Color color = Colors.green, double size = 8}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

class _ShopSection {
  const _ShopSection({
    required this.title,
    this.tagColor,
    required this.products,
  });

  final String title;
  final Color? tagColor;
  final List<_ShopProduct> products;
}

class _ShopProduct {
  const _ShopProduct({
    required this.name,
    required this.price,
    required this.buttonLabel,
    required this.available,
    required this.icon,
  });

  final String name;
  final String price;
  final String buttonLabel;
  final bool available;
  final IconData icon;
}

class _HistoryEntry {
  const _HistoryEntry({
    required this.title,
    required this.delta,
  });

  final String title;
  final String delta;
}
