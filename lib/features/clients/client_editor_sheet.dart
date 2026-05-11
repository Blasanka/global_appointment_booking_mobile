import 'package:flutter/material.dart';

import '../../shared/models/client.dart';

Future<Client?> showClientEditorSheet(
  BuildContext context, {
  Client? initialClient,
  String title = 'Add Client',
  String submitLabel = 'Save Client',
}) {
  return showModalBottomSheet<Client>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _ClientEditorSheet(
      initialClient: initialClient,
      title: title,
      submitLabel: submitLabel,
    ),
  );
}

class _ClientEditorSheet extends StatefulWidget {
  const _ClientEditorSheet({
    required this.initialClient,
    required this.title,
    required this.submitLabel,
  });

  final Client? initialClient;
  final String title;
  final String submitLabel;

  @override
  State<_ClientEditorSheet> createState() => _ClientEditorSheetState();
}

class _ClientEditorSheetState extends State<_ClientEditorSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _lastServiceController;

  @override
  void initState() {
    super.initState();
    final client = widget.initialClient;
    _nameController = TextEditingController(text: client?.name ?? '');
    _phoneController = TextEditingController(text: client?.phone ?? '');
    _lastServiceController = TextEditingController(
      text: client?.lastService ?? 'Consultation',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _lastServiceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 8, 20, 20 + insets),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Client Name',
                prefixIcon: Icon(Icons.person_rounded),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone_rounded),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _lastServiceController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Last Service',
                prefixIcon: Icon(Icons.spa_rounded),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                child: Text(widget.submitLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final lastService = _lastServiceController.text.trim();
    if (name.isEmpty || phone.isEmpty) {
      return;
    }

    final current = widget.initialClient;
    Navigator.of(context).pop(
      Client(
        name: name,
        phone: phone,
        lastService: lastService.isEmpty ? 'Consultation' : lastService,
        visits: current?.visits ?? '1 visit',
        totalSpent: current?.totalSpent ?? 'LKR 0',
      ),
    );
  }
}
