import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../shared/models/client.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/premium_card.dart';
import '../bookings/new_booking_screen.dart';

class ClientDetailScreen extends StatelessWidget {
  const ClientDetailScreen({super.key, required this.client});

  final Client client;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: const Text('Client Detail')),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton.icon(
              onPressed: () => pushScreen(context, const NewBookingScreen()),
              icon: const Icon(Icons.event_available_rounded),
              label: const Text('Book Again'),
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            PremiumCard(
              child: Column(
                children: [
                  CircleAvatar(radius: 42, child: Text(initials(client.name))),
                  const SizedBox(height: 12),
                  Text(
                    client.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    client.phone,
                    style: const TextStyle(color: AppColors.muted),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => showAppMessage(
                            context,
                            'WhatsApp confirmation prepared for ${client.name}.',
                          ),
                          icon: const Icon(Icons.chat_rounded),
                          label: const Text('WhatsApp'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => showAppMessage(
                            context,
                            'Calling ${client.phone}...',
                          ),
                          icon: const Icon(Icons.call_rounded),
                          label: const Text('Call'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(child: MiniStat(value: client.visits, label: 'Visits')),
                SizedBox(width: 10),
                Expanded(
                  child: MiniStat(value: client.totalSpent, label: 'Spent'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: MiniStat(
                    value: client.lastService,
                    label: 'Last Service',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const TabBar(
              tabs: [
                Tab(text: 'History'),
                Tab(text: 'Upcoming'),
                Tab(text: 'Notes'),
              ],
            ),
            SizedBox(
              height: 280,
              child: TabBarView(
                children: [
                  ListView(
                    padding: const EdgeInsets.only(top: 12),
                    children: const [
                      HistoryCard(
                        date: 'Apr 18',
                        service: 'Hair Color',
                        stylist: 'Maya',
                        amount: 'LKR 8,500',
                      ),
                      HistoryCard(
                        date: 'Mar 22',
                        service: 'Blowout',
                        stylist: 'Dilan',
                        amount: 'LKR 4,500',
                      ),
                    ],
                  ),
                  const Center(child: Text('No upcoming bookings')),
                  const Center(child: Text('Prefers evening appointments.')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiniStat extends StatelessWidget {
  const MiniStat({super.key, required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: AppColors.muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.date,
    required this.service,
    required this.stylist,
    required this.amount,
  });

  final String date;
  final String service;
  final String stylist;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          service,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        subtitle: Text('$date · $stylist'),
        trailing: Text(
          amount,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
