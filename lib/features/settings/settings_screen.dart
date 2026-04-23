import 'package:flutter/material.dart';

import '../../shared/widgets/circle_icon.dart';
import '../../shared/widgets/premium_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.storefront_rounded, 'Salon profile', 'Name, address, logo'),
      (Icons.access_time_rounded, 'Working hours', 'Open days and breaks'),
      (
        Icons.manage_accounts_rounded,
        'Staff accounts',
        'Roles and permissions',
      ),
      (
        Icons.notifications_active_rounded,
        'Notifications',
        'Reminders and alerts',
      ),
      (Icons.chat_rounded, 'WhatsApp templates', 'Confirmation messages'),
      (Icons.workspace_premium_rounded, 'Subscription', 'Billing placeholder'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          for (final item in items)
            PremiumCard(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleIcon(
                  icon: item.$1,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  item.$2,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                subtitle: Text(item.$3),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
            ),
        ],
      ),
    );
  }
}
