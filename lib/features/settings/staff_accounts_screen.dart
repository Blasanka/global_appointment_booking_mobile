import 'package:flutter/material.dart';

import '../../app/salon_store.dart';
import '../../app/theme.dart';
import '../../shared/models/settings_models.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/premium_card.dart';
import '../../shared/widgets/status_chip.dart';
import 'settings_editor_sheets.dart';

class StaffAccountsScreen extends StatelessWidget {
  const StaffAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = SalonStoreScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Accounts'),
        actions: [
          IconButton(
            onPressed: () => _addAccount(context),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          for (final account in store.staffAccounts)
            _StaffAccountCard(
              account: account,
              onTap: () => _editAccount(context, account),
            ),
        ],
      ),
    );
  }

  Future<void> _addAccount(BuildContext context) async {
    final created = await showStaffAccountEditorSheet(context);
    if (created == null || !context.mounted) {
      return;
    }
    SalonStoreScope.of(context).addStaffAccount(created);
    showAppMessage(context, '${created.name} added to staff accounts.');
  }

  Future<void> _editAccount(BuildContext context, StaffAccount account) async {
    final updated = await showStaffAccountEditorSheet(
      context,
      initialAccount: account,
      title: 'Edit Staff Account',
      submitLabel: 'Save Changes',
    );
    if (updated == null || !context.mounted) {
      return;
    }
    SalonStoreScope.of(context).updateStaffAccount(
      previousEmail: account.email,
      account: updated,
    );
    showAppMessage(context, '${updated.name} account updated.');
  }
}

class _StaffAccountCard extends StatelessWidget {
  const _StaffAccountCard({required this.account, required this.onTap});

  final StaffAccount account;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(child: Text(initials(account.name))),
        title: Text(account.name, style: const TextStyle(fontWeight: FontWeight.w900)),
        subtitle: Text('${account.role}\n${account.permissionLabel}\n${account.email}'),
        isThreeLine: true,
        trailing: StatusChip(
          label: account.active ? 'Active' : 'Paused',
          color: account.active ? AppColors.green : AppColors.red,
        ),
      ),
    );
  }
}
