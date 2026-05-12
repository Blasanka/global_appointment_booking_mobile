import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../shared/widgets/premium_card.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy & Data')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          _PolicyCard(
            title: 'What this app stores',
            lines: [
              'SalonFlow stores salon operations data entered by the user, including client names, phone numbers, appointments, services, staff details, business profile settings, and WhatsApp template content.',
              'In the current app build, this data is managed as local app data and demo content inside the application experience.',
            ],
          ),
          _PolicyCard(
            title: 'How data is used',
            lines: [
              'The app uses stored data to show bookings, reports, client details, staff management, working hours, and business settings.',
              'Phone numbers may also be used when the user chooses to launch call or WhatsApp actions from the client detail screen.',
            ],
          ),
          _PolicyCard(
            title: 'Sharing and third parties',
            lines: [
              'The app does not present an in-app advertising flow.',
              'External apps may be opened only when the user explicitly launches a phone call, WhatsApp message, or browser link.',
            ],
          ),
          _PolicyCard(
            title: 'Data deletion',
            lines: [
              'Release builds should provide a public privacy policy URL and a support contact for deletion requests before Play Store submission.',
              'If the production app later introduces real account creation or cloud sync, an in-app account deletion path must also be added.',
            ],
          ),
          _PolicyCard(
            title: 'Release note',
            lines: [
              'This screen is an in-app privacy summary. For Google Play release, you should also publish the full privacy policy at a public URL and submit matching Data safety disclosures in Play Console.',
            ],
          ),
        ],
      ),
    );
  }
}

class _PolicyCard extends StatelessWidget {
  const _PolicyCard({
    required this.title,
    required this.lines,
  });

  final String title;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          for (final line in lines)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                line,
                style: const TextStyle(color: AppColors.muted, height: 1.45),
              ),
            ),
        ],
      ),
    );
  }
}
