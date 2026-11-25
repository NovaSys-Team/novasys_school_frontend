import 'package:go_router/go_router.dart';

import '../features/auth/views/auth_form_page.dart';
import '../features/auth/views/splash_page.dart';
import '../features/auth/views/verify_page.dart';
import '../features/auth/views/welcome_page.dart';
import '../features/more/views/more_page.dart';
import '../features/parent/views/home_page.dart';
import '../features/parent/views/notifications_page.dart';
import '../features/parent/views/trips_page.dart';
import 'routes.dart';
import 'shell.dart';

export 'routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.root,
  routes: [
    GoRoute(
      path: AppRoutes.root,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: AppRoutes.signup,
      builder: (context, state) => const AuthFormPage(isSignup: true),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const AuthFormPage(isSignup: false),
    ),
    GoRoute(
      path: AppRoutes.verify,
      builder: (context, state) => const VerifyPage(),
    ),
    ShellRoute(
      builder: (context, state, child) =>
          AppShell(location: state.uri.path, child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.trips,
          builder: (context, state) => const TripsPage(),
        ),
        GoRoute(
          path: AppRoutes.notifications,
          builder: (context, state) => const NotificationsPage(),
        ),
        GoRoute(
          path: AppRoutes.more,
          builder: (context, state) => const MorePage(),
        ),
      ],
    ),
  ],
);
