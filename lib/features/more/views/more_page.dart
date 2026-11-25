import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../auth/controllers/demo_auth_controller.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const ListTile(
        leading: Icon(Icons.person_outline),
        title: Text('Parent demo session'),
        subtitle: Text(
          'Local state only. Restarting the app clears the session.',
        ),
      ),
      const ListTile(
        leading: Icon(Icons.info_outline),
        title: Text('About this prototype'),
        subtitle: Text(
          'Neutral wireframes for team development. No real authentication, tracking, or payments.',
        ),
      ),
      const SizedBox(height: 24),
      OutlinedButton.icon(
        onPressed: () {
          demoAuth.reset();
          context.go(AppRoutes.welcome);
        },
        icon: const Icon(Icons.logout),
        label: const Text('End demo session'),
      ),
    ],
  );
}
