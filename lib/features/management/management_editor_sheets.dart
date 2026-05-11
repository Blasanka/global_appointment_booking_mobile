import 'package:flutter/material.dart';

import '../../shared/models/service.dart';
import '../../shared/models/staff_member.dart';

Future<Service?> showServiceEditorSheet(
  BuildContext context, {
  Service? initialService,
  String title = 'Add Service',
  String submitLabel = 'Save Service',
}) {
  return showModalBottomSheet<Service>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _ServiceEditorSheet(
      initialService: initialService,
      title: title,
      submitLabel: submitLabel,
    ),
  );
}

Future<StaffMember?> showStaffEditorSheet(
  BuildContext context, {
  StaffMember? initialStaffMember,
  String title = 'Add Staff Member',
  String submitLabel = 'Save Staff Member',
}) {
  return showModalBottomSheet<StaffMember>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _StaffEditorSheet(
      initialStaffMember: initialStaffMember,
      title: title,
      submitLabel: submitLabel,
    ),
  );
}

class _ServiceEditorSheet extends StatefulWidget {
  const _ServiceEditorSheet({
    required this.initialService,
    required this.title,
    required this.submitLabel,
  });

  final Service? initialService;
  final String title;
  final String submitLabel;

  @override
  State<_ServiceEditorSheet> createState() => _ServiceEditorSheetState();
}

class _ServiceEditorSheetState extends State<_ServiceEditorSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _durationController;
  late final TextEditingController _priceController;
  late final TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    final service = widget.initialService;
    _nameController = TextEditingController(text: service?.name ?? '');
    _durationController = TextEditingController(text: service?.duration ?? '');
    _priceController = TextEditingController(text: service?.price ?? 'LKR ');
    _categoryController = TextEditingController(text: service?.category ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
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
                labelText: 'Service Name',
                prefixIcon: Icon(Icons.spa_rounded),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _durationController,
              decoration: const InputDecoration(
                labelText: 'Duration',
                prefixIcon: Icon(Icons.schedule_rounded),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Price',
                prefixIcon: Icon(Icons.payments_rounded),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _categoryController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Category',
                prefixIcon: Icon(Icons.label_rounded),
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
    final duration = _durationController.text.trim();
    final price = _priceController.text.trim();
    final category = _categoryController.text.trim();
    if (name.isEmpty || duration.isEmpty || price.isEmpty || category.isEmpty) {
      return;
    }

    Navigator.of(context).pop(
      Service(
        name: name,
        duration: duration,
        price: price,
        category: category,
      ),
    );
  }
}

class _StaffEditorSheet extends StatefulWidget {
  const _StaffEditorSheet({
    required this.initialStaffMember,
    required this.title,
    required this.submitLabel,
  });

  final StaffMember? initialStaffMember;
  final String title;
  final String submitLabel;

  @override
  State<_StaffEditorSheet> createState() => _StaffEditorSheetState();
}

class _StaffEditorSheetState extends State<_StaffEditorSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _roleController;
  late final TextEditingController _ratingController;
  bool _available = true;

  @override
  void initState() {
    super.initState();
    final staffMember = widget.initialStaffMember;
    _nameController = TextEditingController(text: staffMember?.name ?? '');
    _roleController = TextEditingController(text: staffMember?.role ?? '');
    _ratingController = TextEditingController(text: staffMember?.rating ?? '');
    _available = staffMember?.available ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _ratingController.dispose();
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
                labelText: 'Staff Name',
                prefixIcon: Icon(Icons.person_rounded),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _roleController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Role',
                prefixIcon: Icon(Icons.badge_rounded),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _ratingController,
              decoration: const InputDecoration(
                labelText: 'Rating',
                prefixIcon: Icon(Icons.star_rounded),
              ),
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _available,
              onChanged: (value) => setState(() => _available = value),
              title: const Text('Available'),
            ),
            const SizedBox(height: 12),
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
    final role = _roleController.text.trim();
    final rating = _ratingController.text.trim();
    if (name.isEmpty || role.isEmpty || rating.isEmpty) {
      return;
    }

    Navigator.of(context).pop(
      StaffMember(
        name: name,
        role: role,
        rating: rating,
        available: _available,
      ),
    );
  }
}
