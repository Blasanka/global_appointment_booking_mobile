import 'package:flutter/material.dart';

import '../../shared/data/mock_data.dart';
import '../../shared/widgets/form_widgets.dart';

class NewBookingScreen extends StatelessWidget {
  const NewBookingScreen({super.key});

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
            onPressed: () => Navigator.pop(context),
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
              const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded),
                  hintText: 'Search existing client',
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.person_add_alt_rounded),
                label: const Text('Add new client'),
              ),
              const SizedBox(height: 12),
              const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone_rounded),
                  hintText: 'Client phone number',
                ),
              ),
              const SizedBox(height: 12),
              const TextField(
                maxLines: 3,
                decoration: InputDecoration(hintText: 'Notes'),
              ),
            ],
          ),
          const FormSection(
            title: 'Service',
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  SelectablePill(text: 'Hair Color', selected: true),
                  SelectablePill(text: 'Facial', selected: false),
                  SelectablePill(text: 'Beard Trim', selected: false),
                ],
              ),
              SizedBox(height: 12),
              ReadOnlyField(label: 'Duration', value: '90 minutes'),
              SizedBox(height: 12),
              ReadOnlyField(label: 'Price', value: 'LKR 8,500'),
            ],
          ),
          FormSection(
            title: 'Staff & Time',
            children: [
              const ReadOnlyField(label: 'Stylist', value: 'Maya Perera'),
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
                    SelectablePill(text: slot, selected: slot == '10:30'),
                ],
              ),
            ],
          ),
          FormSection(
            title: 'Confirmation',
            children: [
              const BookingSummaryRow(
                label: 'Hair Color + Blowout',
                value: 'LKR 8,500',
              ),
              const BookingSummaryRow(label: 'Maya Perera', value: '10:30 AM'),
              const Divider(height: 28),
              const BookingSummaryRow(
                label: 'Total',
                value: 'LKR 8,500',
                strong: true,
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: true,
                onChanged: (_) {},
                title: const Text('Deposit required'),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: true,
                onChanged: (_) {},
                title: const Text('Send WhatsApp confirmation'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
