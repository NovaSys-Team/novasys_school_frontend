import 'package:flutter/material.dart';

import '../../../core/widgets/wireframe_panel.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: const [
      WireframePanel(
        icon: Icons.notifications_none,
        title: 'No notifications',
        message: 'Trip alerts and updates will appear here. No notifications are sent in this prototype.',
      ),
    ],
  );
}
