import 'package:flutter/material.dart';

import '../../shared/data/mock_data.dart';
import '../../shared/widgets/form_widgets.dart';
import '../../shared/widgets/helpers.dart';

class NewBookingScreen extends StatefulWidget {
  const NewBookingScreen({super.key});

  @override
  State<NewBookingScreen> createState() => _NewBookingScreenState();
}

class _NewBookingScreenState extends State<NewBookingScreen> {
  final _clientController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedService = 'Hair Color';
  String _selectedSlot = '10:30';
  bool _depositRequired = true;
  bool _sendWhatsappConfirmation = true;

  @override
  void dispose() {
    _clientController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Booking'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close_rounded),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: _confirmBooking,
            child: const Text('Confirm Booking'),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        children: [
          FormSection(
            title: 'Client',
            children: [
              TextField(
                controller: _clientController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded),
                  hintText: 'Search existing client',
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _addClientQuickFill,
                icon: const Icon(Icons.person_add_alt_rounded),
                label: const Text('Add new client'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone_rounded),
                  hintText: 'Client phone number',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(hintText: 'Notes'),
              ),
            ],
          ),
          FormSection(
            title: 'Service',
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final service in const ['Hair Color', 'Facial', 'Beard Trim'])
                    GestureDetector(
                      onTap: () => setState(() => _selectedService = service),
                      child: SelectablePill(
                        text: service,
                        selected: service == _selectedService,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              ReadOnlyField(
                label: 'Duration',
                value: _selectedService == 'Facial'
                    ? '60 minutes'
                    : _selectedService == 'Beard Trim'
                    ? '30 minutes'
                    : '90 minutes',
              ),
              const SizedBox(height: 12),
              ReadOnlyField(
                label: 'Price',
                value: _selectedService == 'Facial'
                    ? 'LKR 7,500'
                    : _selectedService == 'Beard Trim'
                    ? 'LKR 3,500'
                    : 'LKR 8,500',
              ),
            ],
          ),
          FormSection(
            title: 'Staff & Time',
            children: [
              ReadOnlyField(
                label: 'Stylist',
                value: _selectedService == 'Beard Trim' ? 'Dilan Jay' : 'Maya Perera',
              ),
              const SizedBox(height: 12),
              const ReadOnlyField(label: 'Date', value: 'Thursday, Apr 23'),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.3,
                children: [
                  for (final slot in timeSlots)
                    GestureDetector(
                      onTap: () => setState(() => _selectedSlot = slot),
                      child: SelectablePill(
                        text: slot,
                        selected: slot == _selectedSlot,
                      ),
                    ),
                ],
              ),
            ],
          ),
          FormSection(
            title: 'Confirmation',
            children: [
              BookingSummaryRow(label: _selectedService, value: _price),
              BookingSummaryRow(label: _staffName, value: _selectedSlot),
              const Divider(height: 28),
              BookingSummaryRow(label: 'Total', value: _price, strong: true),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: _depositRequired,
                onChanged: (value) => setState(() => _depositRequired = value),
                title: const Text('Deposit required'),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: _sendWhatsappConfirmation,
                onChanged: (value) =>
                    setState(() => _sendWhatsappConfirmation = value),
                title: const Text('Send WhatsApp confirmation'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String get _price => _selectedService == 'Facial'
      ? 'LKR 7,500'
      : _selectedService == 'Beard Trim'
      ? 'LKR 3,500'
      : 'LKR 8,500';

  String get _staffName =>
      _selectedService == 'Beard Trim' ? 'Dilan Jay' : 'Maya Perera';

  Future<void> _addClientQuickFill() async {
    await showInfoSheet(
      context,
      title: 'New Client Draft',
      message:
          'A quick client draft was added to the form so you can complete a booking flow during review.',
      actionLabel: 'Use Draft',
    );
    if (!mounted) return;
    setState(() {
      _clientController.text = 'Walk-in Client';
      _phoneController.text = '+94 77 000 1111';
      _notesController.text = 'First visit';
    });
  }

  void _confirmBooking() {
    final clientName = _clientController.text.trim();
    if (clientName.isEmpty) {
      showAppMessage(context, 'Enter a client name before confirming.');
      return;
    }
    showAppMessage(
      context,
      'Booking created for $clientName at $_selectedSlot with $_staffName.',
    );
    Navigator.of(context).pop();
  }
}
