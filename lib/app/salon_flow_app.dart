import 'package:flutter/material.dart';

import 'salon_store.dart';
import '../features/auth/splash_screen.dart';
import 'theme.dart';

class SalonFlowApp extends StatefulWidget {
  const SalonFlowApp({super.key});

  @override
  State<SalonFlowApp> createState() => _SalonFlowAppState();
}

class _SalonFlowAppState extends State<SalonFlowApp> {
  late final SalonStore _store;

  @override
  void initState() {
    super.initState();
    _store = SalonStore();
  }

  @override
  Widget build(BuildContext context) {
    return SalonStoreScope(
      store: _store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SalonFlow',
        theme: buildSalonTheme(),
        home: const SplashScreen(),
      ),
    );
  }
}
