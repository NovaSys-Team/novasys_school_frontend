import 'package:flutter/material.dart';

import '../../../core/widgets/wireframe_panel.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: const [
      WireframePanel(
        icon: Icons.route_outlined,
        title: 'No demo trips yet',
        message: 'Upcoming trips and transport history will appear here. This screen is a layout placeholder.',
      ),
    ],
  );
}
