import 'package:flutter/material.dart';

import '../../shared/widgets/circle_icon.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/premium_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        Icons.storefront_rounded,
        'Salon profile',
        'Name, address, logo',
        'Manage your public salon details and brand assets.',
      ),
      (
        Icons.access_time_rounded,
        'Working hours',
        'Open days and breaks',
        'Set business hours, off days, and daily breaks.',
      ),
      (
        Icons.manage_accounts_rounded,
        'Staff accounts',
        'Roles and permissions',
        'Assign permissions and configure staff access.',
      ),
      (
        Icons.notifications_active_rounded,
        'Notifications',
        'Reminders and alerts',
        'Configure booking reminders and internal alerts.',
      ),
      (
        Icons.chat_rounded,
        'WhatsApp templates',
        'Confirmation messages',
        'Prepare reusable booking and reminder message templates.',
      ),
      (
        Icons.workspace_premium_rounded,
        'Subscription',
        'Billing overview',
        'Review the current plan and billing status.',
      ),
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
                onTap: () => showInfoSheet(
                  context,
                  title: item.$2,
                  message: item.$4,
                ),
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
