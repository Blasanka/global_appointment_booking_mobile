import 'package:flutter/material.dart';

import '../notifications/notifications_screen.dart';
import 'privacy_policy_screen.dart';
import 'salon_profile_screen.dart';
import 'staff_accounts_screen.dart';
import 'subscription_screen.dart';
import 'whatsapp_templates_screen.dart';
import 'working_hours_screen.dart';
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
        Icons.privacy_tip_rounded,
        'Privacy & data',
        'Policy and deletion guidance',
        'Review privacy handling and Play Store release notes.',
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
                onTap: () {
                  if (item.$2 == 'Notifications') {
                    pushScreen(context, const NotificationsScreen());
                    return;
                  }
                  if (item.$2 == 'Salon profile') {
                    pushScreen(context, const SalonProfileScreen());
                    return;
                  }
                  if (item.$2 == 'Working hours') {
                    pushScreen(context, const WorkingHoursScreen());
                    return;
                  }
                  if (item.$2 == 'Staff accounts') {
                    pushScreen(context, const StaffAccountsScreen());
                    return;
                  }
                  if (item.$2 == 'WhatsApp templates') {
                    pushScreen(context, const WhatsAppTemplatesScreen());
                    return;
                  }
                  if (item.$2 == 'Privacy & data') {
                    pushScreen(context, const PrivacyPolicyScreen());
                    return;
                  }
                  if (item.$2 == 'Subscription') {
                    pushScreen(context, const SubscriptionScreen());
                    return;
                  }
                },
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
