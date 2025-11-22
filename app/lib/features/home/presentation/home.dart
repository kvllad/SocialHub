import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: navigationShell.currentIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Brainrot Project'),
          bottom: TabBar(
            onTap: (index) => navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            ),
            tabs: const [
              Tab(icon: Icon(Icons.home), text: 'Главная'),
              Tab(icon: Icon(Icons.emoji_events), text: 'Лига'),
              Tab(icon: Icon(Icons.shopping_bag), text: 'Магазин'),
              Tab(icon: Icon(Icons.event), text: 'Мероприятия'),
            ],
          ),
        ),
        body: navigationShell,
      ),
    );
  }
}
