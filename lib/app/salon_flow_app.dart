import 'package:flutter/material.dart';

import '../features/auth/splash_screen.dart';
import 'theme.dart';

class SalonFlowApp extends StatelessWidget {
  const SalonFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SalonFlow',
      theme: buildSalonTheme(),
      home: const SplashScreen(),
    );
  }
}
