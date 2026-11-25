import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.directions_bus_outlined, size: 80),
                const SizedBox(height: 32),
                Text(
                  'Welcome',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 12),
                const Text('Explore the parent school transport experience.'),
                const SizedBox(height: 24),
                const Text(
                  'UI demo only. Use made-up details. No real accounts are created or messages sent.',
                ),
                const SizedBox(height: 32),
                FilledButton(
                  onPressed: () => context.push(AppRoutes.signup),
                  child: const Text('Create account'),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => context.push(AppRoutes.login),
                  child: const Text('Log in'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
