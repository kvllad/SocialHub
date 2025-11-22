import 'package:app/features/auth/presentation/pages/login_page.dart';
import 'package:app/features/auth/presentation/pages/register_page.dart';
import 'package:app/features/home/presentation/home.dart';
import 'package:app/features/home/presentation/pages/events_page.dart';
import 'package:app/features/home/presentation/pages/league_page.dart';
import 'package:app/features/home/presentation/pages/main_page.dart';
import 'package:app/features/home/presentation/pages/shop_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => Home(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home/main',
              builder: (context, state) => const MainPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home/league',
              builder: (context, state) => const LeaguePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home/shop',
              builder: (context, state) => const ShopPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home/events',
              builder: (context, state) => const EventsPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/home',
      redirect: (_, __) => '/home/main',
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
  ],
);
