import 'package:flutter/material.dart';

import '../../app/salon_store.dart';
import '../../app/theme.dart';
import '../../shared/models/settings_models.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/premium_card.dart';
import '../../shared/widgets/status_chip.dart';
import 'settings_editor_sheets.dart';

class WorkingHoursScreen extends StatelessWidget {
  const WorkingHoursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = SalonStoreScope.of(context);
    final workingDays = store.workingDays;
    return Scaffold(
      appBar: AppBar(title: const Text('Working Hours')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          for (final day in workingDays)
            _WorkingDayCard(
              day: day,
              onTap: () => _editDay(context, day),
            ),
        ],
      ),
    );
  }

  Future<void> _editDay(BuildContext context, WorkingDay day) async {
    final updated = await showWorkingDayEditorSheet(context, day: day);
    if (updated == null || !context.mounted) {
      return;
    }
    SalonStoreScope.of(context).updateWorkingDay(label: day.label, day: updated);
    showAppMessage(context, '${day.label} hours updated.');
  }
}

class _WorkingDayCard extends StatelessWidget {
  const _WorkingDayCard({required this.day, required this.onTap});

  final WorkingDay day;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        title: Text(day.label, style: const TextStyle(fontWeight: FontWeight.w900)),
        subtitle: Text(
          day.enabled
              ? '${day.openTime} - ${day.closeTime}\nBreak: ${day.breakLabel}'
              : 'Closed',
        ),
        isThreeLine: day.enabled,
        trailing: StatusChip(
          label: day.enabled ? 'Open' : 'Closed',
          color: day.enabled ? AppColors.green : AppColors.red,
        ),
      ),
    );
  }
}
