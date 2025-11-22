import 'package:app/features/auth/presentation/ui/auth_page.dart';
import 'package:app/main.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Home(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => AuthPage(),
    ),
  ],
);
