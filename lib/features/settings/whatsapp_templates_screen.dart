import 'package:flutter/material.dart';

import '../../app/salon_store.dart';
import '../../app/theme.dart';
import '../../shared/models/settings_models.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/premium_card.dart';
import '../../shared/widgets/status_chip.dart';
import 'settings_editor_sheets.dart';

class WhatsAppTemplatesScreen extends StatelessWidget {
  const WhatsAppTemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = SalonStoreScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp Templates'),
        actions: [
          IconButton(
            onPressed: () => _addTemplate(context),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          for (final template in store.whatsAppTemplates)
            _WhatsAppTemplateCard(
              template: template,
              onTap: () => _editTemplate(context, template),
            ),
        ],
      ),
    );
  }

  Future<void> _addTemplate(BuildContext context) async {
    final created = await showWhatsAppTemplateEditorSheet(context);
    if (created == null || !context.mounted) {
      return;
    }
    SalonStoreScope.of(context).addWhatsAppTemplate(created);
    showAppMessage(context, '${created.title} template added.');
  }

  Future<void> _editTemplate(
    BuildContext context,
    WhatsAppTemplate template,
  ) async {
    final updated = await showWhatsAppTemplateEditorSheet(
      context,
      initialTemplate: template,
      title: 'Edit Template',
      submitLabel: 'Save Changes',
    );
    if (updated == null || !context.mounted) {
      return;
    }
    SalonStoreScope.of(context).updateWhatsAppTemplate(
      previousTitle: template.title,
      template: updated,
    );
    showAppMessage(context, '${updated.title} template updated.');
  }
}

class _WhatsAppTemplateCard extends StatelessWidget {
  const _WhatsAppTemplateCard({
    required this.template,
    required this.onTap,
  });

  final WhatsAppTemplate template;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    template.title,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                StatusChip(
                  label: template.enabled ? 'Enabled' : 'Draft',
                  color: template.enabled ? AppColors.green : AppColors.amber,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              template.category,
              style: const TextStyle(color: AppColors.muted),
            ),
            const SizedBox(height: 10),
            Text(template.message),
          ],
        ),
      ),
    );
  }
}
