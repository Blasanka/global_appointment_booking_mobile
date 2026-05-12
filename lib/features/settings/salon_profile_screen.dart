import 'package:flutter/material.dart';

import '../../app/salon_store.dart';
import '../../app/theme.dart';
import '../../shared/models/settings_models.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/premium_card.dart';
import 'settings_editor_sheets.dart';

class SalonProfileScreen extends StatelessWidget {
  const SalonProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = SalonStoreScope.of(context);
    final profile = store.salonProfile;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salon Profile'),
        actions: [
          IconButton(
            onPressed: () => _editProfile(context, profile),
            icon: const Icon(Icons.edit_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          PremiumCard(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36,
                  child: Text(
                    initials(profile.name),
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  profile.name,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                Text(
                  profile.tagline,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.muted),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _ProfileDetailCard(
            icon: Icons.location_on_rounded,
            title: 'Address',
            value: profile.address,
          ),
          _ProfileDetailCard(
            icon: Icons.call_rounded,
            title: 'Phone',
            value: profile.phone,
          ),
        ],
      ),
    );
  }

  Future<void> _editProfile(BuildContext context, SalonProfile profile) async {
    final updated = await showSalonProfileEditorSheet(context, profile: profile);
    if (updated == null || !context.mounted) {
      return;
    }
    SalonStoreScope.of(context).updateSalonProfile(updated);
    showAppMessage(context, 'Salon profile updated.');
  }
}

class _ProfileDetailCard extends StatelessWidget {
  const _ProfileDetailCard({
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
                Text(title, style: const TextStyle(color: AppColors.muted)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontWeight: FontWeight.w900)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
