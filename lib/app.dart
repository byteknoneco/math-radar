import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class MathRadarApp extends StatelessWidget {
  const MathRadarApp({super.key, required this.backendEnabled});
  final bool backendEnabled;

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF3157D5));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MathRadar',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: scheme.surfaceContainerLowest,
      ),
      home: HomeScreen(backendEnabled: backendEnabled),
    );
  }
}
