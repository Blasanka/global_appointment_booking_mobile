import 'package:flutter/material.dart';

import '../../shared/widgets/app_bottom_nav.dart';
import '../bookings/calendar_screen.dart';
import '../clients/clients_screen.dart';
import '../reports/reports_screen.dart';
import '../settings/settings_screen.dart';
import 'dashboard_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  final screens = const [
    DashboardScreen(),
    CalendarScreen(),
    ClientsScreen(),
    ReportsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: AppBottomNav(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
      ),
    );
  }
}
