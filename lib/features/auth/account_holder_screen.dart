import 'package:flutter/material.dart';

import '../../app/salon_store.dart';
import '../../app/theme.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/premium_card.dart';
import 'login_screen.dart';

class AccountHolderScreen extends StatelessWidget {
  const AccountHolderScreen({super.key});

  static const _previewEmail = 'owner@salonflow.app';
  static const _previewRole = 'Account Holder';

  @override
  Widget build(BuildContext context) {
    final store = SalonStoreScope.of(context);
    final salonName = store.salonProfile.name;

    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          PremiumCard(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 34,
                  backgroundColor: Color(0xFFE7DFFD),
                  child: Text(
                    'N',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Niro',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                const Text(
                  _previewRole,
                  style: TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 6),
                Text(
                  salonName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.muted),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const _AccountDetailCard(
            icon: Icons.alternate_email_rounded,
            title: 'Login Email',
            value: _previewEmail,
          ),
          const _AccountDetailCard(
            icon: Icons.lock_outline_rounded,
            title: 'Access',
            value: 'Single preview owner account',
          ),
          const _AccountDetailCard(
            icon: Icons.shield_outlined,
            title: 'Permissions',
            value: 'Full salon access',
          ),
          const SizedBox(height: 18),
          OutlinedButton.icon(
            onPressed: () => _logOut(context),
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  void _logOut(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }
}

class _AccountDetailCard extends StatelessWidget {
  const _AccountDetailCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
