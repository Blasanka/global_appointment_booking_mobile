import 'package:flutter/material.dart';

import '../../app/salon_store.dart';
import '../../app/theme.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/premium_card.dart';
import '../../shared/models/settings_models.dart';
import 'settings_editor_sheets.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = SalonStoreScope.of(context);
    final plan = store.subscriptionPlan;
    final usage = plan.seatLimit == 0 ? 0.0 : plan.seatsUsed / plan.seatLimit;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
        actions: [
          IconButton(
            onPressed: () => _editPlan(context, plan),
            icon: const Icon(Icons.edit_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          PremiumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.planName,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                Text(plan.priceLabel, style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(plan.billingCycle, style: const TextStyle(color: AppColors.muted)),
                const SizedBox(height: 4),
                Text(plan.renewalDate, style: const TextStyle(color: AppColors.muted)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF7F0),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    plan.status,
                    style: const TextStyle(
                      color: AppColors.green,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          PremiumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Team Seats',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${plan.seatsUsed} of ${plan.seatLimit} seats in use',
                  style: const TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: usage.clamp(0.0, 1.0).toDouble(),
                    minHeight: 12,
                    backgroundColor: const Color(0xFFF2EEF9),
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editPlan(BuildContext context, SubscriptionPlan plan) async {
    final updated = await showSubscriptionEditorSheet(context, plan: plan);
    if (updated == null || !context.mounted) {
      return;
    }
    SalonStoreScope.of(context).updateSubscriptionPlan(updated);
    showAppMessage(context, 'Subscription updated.');
  }
}
