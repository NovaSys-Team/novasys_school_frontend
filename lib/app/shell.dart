import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child, required this.location});

  final Widget child;
  final String location;

  static const _paths = [
    AppRoutes.home,
    AppRoutes.trips,
    AppRoutes.notifications,
    AppRoutes.more,
  ];
  static const _titles = ['Home', 'Trips', 'Notifications', 'More'];

  @override
  Widget build(BuildContext context) {
    final index = _paths.indexOf(location);
    final selected = index < 0 ? 0 : index;
    return Scaffold(
      appBar: AppBar(title: Text(_titles[selected])),
      body: SafeArea(child: child),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        onDestinationSelected: (value) => context.go(_paths[value]),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.route_outlined),
            label: 'Trips',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_none),
            label: 'Notifications',
          ),
          NavigationDestination(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}
