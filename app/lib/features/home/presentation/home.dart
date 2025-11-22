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
          title: const Text('Social Hub'),
          bottom: TabBar(
            onTap: (index) => navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            ),
            tabs: const [
              Tab(text: 'Главная'),
              Tab(text: 'Лига'),
              Tab(text: 'Магазин'),
              Tab(text: 'Задания'),
            ],
          ),
        ),
        body: navigationShell,
      ),
    );
  }
}
