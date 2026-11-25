import 'package:flutter/material.dart';

import 'router.dart';

class StarterApp extends StatelessWidget {
  const StarterApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'School transport prototype',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF424242),
        secondary: Color(0xFF616161),
        surface: Color(0xFFFAFAFA),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    ),
    routerConfig: appRouter,
  );
}
