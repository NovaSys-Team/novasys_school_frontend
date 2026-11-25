import 'package:flutter/material.dart';

import '../../../core/widgets/wireframe_panel.dart';
import '../../auth/controllers/demo_auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      Text(
        demoAuth.name.isEmpty ? 'Hello, parent' : 'Hello, ${demoAuth.name}',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      const SizedBox(height: 8),
      const Text('Parent UI prototype - All panels are placeholders.'),
      const SizedBox(height: 24),
      const WireframePanel(
        icon: Icons.directions_bus_outlined,
        title: 'Your school transport',
        message: 'Student and bus details will appear here. No transport is assigned in this demo.',
      ),
      const SizedBox(height: 12),
      const WireframePanel(
        icon: Icons.map_outlined,
        title: 'Trip overview',
        message: 'Placeholder for a future route map and trip status. No live tracking is connected.',
      ),
    ],
  );
}
