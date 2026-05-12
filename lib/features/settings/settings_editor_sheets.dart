import 'package:flutter/material.dart';

import '../../shared/models/settings_models.dart';

Future<SalonProfile?> showSalonProfileEditorSheet(
  BuildContext context, {
  required SalonProfile profile,
}) {
  return showModalBottomSheet<SalonProfile>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _SalonProfileEditorSheet(profile: profile),
  );
}

Future<WorkingDay?> showWorkingDayEditorSheet(
  BuildContext context, {
  required WorkingDay day,
}) {
  return showModalBottomSheet<WorkingDay>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _WorkingDayEditorSheet(day: day),
  );
}

Future<StaffAccount?> showStaffAccountEditorSheet(
  BuildContext context, {
  StaffAccount? initialAccount,
  String title = 'Add Staff Account',
  String submitLabel = 'Save Account',
}) {
  return showModalBottomSheet<StaffAccount>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _StaffAccountEditorSheet(
      initialAccount: initialAccount,
      title: title,
      submitLabel: submitLabel,
    ),
  );
}

Future<WhatsAppTemplate?> showWhatsAppTemplateEditorSheet(
  BuildContext context, {
  WhatsAppTemplate? initialTemplate,
  String title = 'Add Template',
  String submitLabel = 'Save Template',
}) {
  return showModalBottomSheet<WhatsAppTemplate>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _WhatsAppTemplateEditorSheet(
      initialTemplate: initialTemplate,
      title: title,
      submitLabel: submitLabel,
    ),
  );
}

Future<SubscriptionPlan?> showSubscriptionEditorSheet(
  BuildContext context, {
  required SubscriptionPlan plan,
}) {
  return showModalBottomSheet<SubscriptionPlan>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _SubscriptionEditorSheet(plan: plan),
  );
}

class _SalonProfileEditorSheet extends StatefulWidget {
  const _SalonProfileEditorSheet({required this.profile});

  final SalonProfile profile;

  @override
  State<_SalonProfileEditorSheet> createState() => _SalonProfileEditorSheetState();
}

class _SalonProfileEditorSheetState extends State<_SalonProfileEditorSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _addressController;
  late final TextEditingController _phoneController;
  late final TextEditingController _taglineController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _addressController = TextEditingController(text: widget.profile.address);
    _phoneController = TextEditingController(text: widget.profile.phone);
    _taglineController = TextEditingController(text: widget.profile.tagline);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _taglineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 4, 20, 20 + insets),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Salon Profile',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Salon Name',
                  prefixIcon: Icon(Icons.storefront_rounded),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _addressController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  prefixIcon: Icon(Icons.location_on_rounded),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  prefixIcon: Icon(Icons.call_rounded),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _taglineController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Tagline',
                  prefixIcon: Icon(Icons.auto_awesome_rounded),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    Navigator.of(context).pop(
      SalonProfile(
        name: _nameController.text.trim(),
        address: _addressController.text.trim(),
        phone: _phoneController.text.trim(),
        tagline: _taglineController.text.trim(),
      ),
    );
  }
}

class _WorkingDayEditorSheet extends StatefulWidget {
  const _WorkingDayEditorSheet({required this.day});

  final WorkingDay day;

  @override
  State<_WorkingDayEditorSheet> createState() => _WorkingDayEditorSheetState();
}

class _WorkingDayEditorSheetState extends State<_WorkingDayEditorSheet> {
  late final TextEditingController _openController;
  late final TextEditingController _closeController;
  late final TextEditingController _breakController;
  late bool _enabled;

  @override
  void initState() {
    super.initState();
    _enabled = widget.day.enabled;
    _openController = TextEditingController(text: widget.day.openTime);
    _closeController = TextEditingController(text: widget.day.closeTime);
    _breakController = TextEditingController(text: widget.day.breakLabel);
  }

  @override
  void dispose() {
    _openController.dispose();
    _closeController.dispose();
    _breakController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 4, 20, 20 + insets),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit ${widget.day.label}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                value: _enabled,
                contentPadding: EdgeInsets.zero,
                title: const Text('Open for bookings'),
                onChanged: (value) => setState(() => _enabled = value),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _openController,
                decoration: const InputDecoration(labelText: 'Opening Time'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _closeController,
                decoration: const InputDecoration(labelText: 'Closing Time'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _breakController,
                decoration: const InputDecoration(labelText: 'Break Window'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Save Day'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    Navigator.of(context).pop(
      WorkingDay(
        label: widget.day.label,
        enabled: _enabled,
        openTime: _enabled ? _openController.text.trim() : 'Closed',
        closeTime: _enabled ? _closeController.text.trim() : 'Closed',
        breakLabel: _enabled ? _breakController.text.trim() : 'Closed',
      ),
    );
  }
}

class _StaffAccountEditorSheet extends StatefulWidget {
  const _StaffAccountEditorSheet({
    required this.initialAccount,
    required this.title,
    required this.submitLabel,
  });

  final StaffAccount? initialAccount;
  final String title;
  final String submitLabel;

  @override
  State<_StaffAccountEditorSheet> createState() => _StaffAccountEditorSheetState();
}

class _StaffAccountEditorSheetState extends State<_StaffAccountEditorSheet> {
  static const _permissions = [
    'Manager access',
    'Staff access',
    'Limited access',
  ];

  late final TextEditingController _nameController;
  late final TextEditingController _roleController;
  late final TextEditingController _emailController;
  late String _permission;
  late bool _active;

  @override
  void initState() {
    super.initState();
    final account = widget.initialAccount;
    _nameController = TextEditingController(text: account?.name ?? '');
    _roleController = TextEditingController(text: account?.role ?? '');
    _emailController = TextEditingController(text: account?.email ?? '');
    _permission = account?.permissionLabel ?? _permissions.first;
    _active = account?.active ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 4, 20, 20 + insets),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _roleController,
                decoration: const InputDecoration(labelText: 'Role'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _permission,
                items: [
                  for (final permission in _permissions)
                    DropdownMenuItem(
                      value: permission,
                      child: Text(permission),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _permission = value);
                  }
                },
                decoration: const InputDecoration(labelText: 'Permissions'),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                value: _active,
                contentPadding: EdgeInsets.zero,
                title: const Text('Account Active'),
                onChanged: (value) => setState(() => _active = value),
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
      ),
    );
  }

  void _submit() {
    Navigator.of(context).pop(
      StaffAccount(
        name: _nameController.text.trim(),
        role: _roleController.text.trim(),
        permissionLabel: _permission,
        email: _emailController.text.trim(),
        active: _active,
      ),
    );
  }
}

class _WhatsAppTemplateEditorSheet extends StatefulWidget {
  const _WhatsAppTemplateEditorSheet({
    required this.initialTemplate,
    required this.title,
    required this.submitLabel,
  });

  final WhatsAppTemplate? initialTemplate;
  final String title;
  final String submitLabel;

  @override
  State<_WhatsAppTemplateEditorSheet> createState() =>
      _WhatsAppTemplateEditorSheetState();
}

class _WhatsAppTemplateEditorSheetState
    extends State<_WhatsAppTemplateEditorSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _categoryController;
  late final TextEditingController _messageController;
  late bool _enabled;

  @override
  void initState() {
    super.initState();
    final template = widget.initialTemplate;
    _titleController = TextEditingController(text: template?.title ?? '');
    _categoryController = TextEditingController(text: template?.category ?? '');
    _messageController = TextEditingController(text: template?.message ?? '');
    _enabled = template?.enabled ?? true;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 4, 20, 20 + insets),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Template Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _messageController,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Message'),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                value: _enabled,
                contentPadding: EdgeInsets.zero,
                title: const Text('Template Enabled'),
                onChanged: (value) => setState(() => _enabled = value),
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
      ),
    );
  }

  void _submit() {
    Navigator.of(context).pop(
      WhatsAppTemplate(
        title: _titleController.text.trim(),
        category: _categoryController.text.trim(),
        message: _messageController.text.trim(),
        enabled: _enabled,
      ),
    );
  }
}

class _SubscriptionEditorSheet extends StatefulWidget {
  const _SubscriptionEditorSheet({required this.plan});

  final SubscriptionPlan plan;

  @override
  State<_SubscriptionEditorSheet> createState() => _SubscriptionEditorSheetState();
}

class _SubscriptionEditorSheetState extends State<_SubscriptionEditorSheet> {
  late final TextEditingController _planController;
  late final TextEditingController _priceController;
  late final TextEditingController _cycleController;
  late final TextEditingController _renewalController;
  late final TextEditingController _statusController;
  late final TextEditingController _seatsUsedController;
  late final TextEditingController _seatLimitController;

  @override
  void initState() {
    super.initState();
    final plan = widget.plan;
    _planController = TextEditingController(text: plan.planName);
    _priceController = TextEditingController(text: plan.priceLabel);
    _cycleController = TextEditingController(text: plan.billingCycle);
    _renewalController = TextEditingController(text: plan.renewalDate);
    _statusController = TextEditingController(text: plan.status);
    _seatsUsedController = TextEditingController(text: '${plan.seatsUsed}');
    _seatLimitController = TextEditingController(text: '${plan.seatLimit}');
  }

  @override
  void dispose() {
    _planController.dispose();
    _priceController.dispose();
    _cycleController.dispose();
    _renewalController.dispose();
    _statusController.dispose();
    _seatsUsedController.dispose();
    _seatLimitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 4, 20, 20 + insets),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Update Subscription',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _planController,
                decoration: const InputDecoration(labelText: 'Plan Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _cycleController,
                decoration: const InputDecoration(labelText: 'Billing Cycle'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _renewalController,
                decoration: const InputDecoration(labelText: 'Renewal Date'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Status'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _seatsUsedController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Seats Used'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _seatLimitController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Seat Limit'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Save Subscription'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    Navigator.of(context).pop(
      SubscriptionPlan(
        planName: _planController.text.trim(),
        priceLabel: _priceController.text.trim(),
        billingCycle: _cycleController.text.trim(),
        renewalDate: _renewalController.text.trim(),
        status: _statusController.text.trim(),
        seatsUsed: int.tryParse(_seatsUsedController.text.trim()) ?? 0,
        seatLimit: int.tryParse(_seatLimitController.text.trim()) ?? 0,
      ),
    );
  }
}
