import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/salon_store.dart';
import '../../app/theme.dart';
import '../../shared/models/client.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/premium_card.dart';
import '../bookings/new_booking_screen.dart';
import 'client_editor_sheet.dart';

class ClientDetailScreen extends StatefulWidget {
  const ClientDetailScreen({super.key, required this.client});

  final Client client;

  @override
  State<ClientDetailScreen> createState() => _ClientDetailScreenState();
}

class _ClientDetailScreenState extends State<ClientDetailScreen> {
  late String _clientPhoneKey;

  @override
  void initState() {
    super.initState();
    _clientPhoneKey = widget.client.phone;
  }

  @override
  Widget build(BuildContext context) {
    final store = SalonStoreScope.of(context);
    final client = store.clients.firstWhere(
      (entry) => entry.phone == _clientPhoneKey,
      orElse: () => widget.client,
    );

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Client Detail'),
          actions: [
            IconButton(
              onPressed: () => _editClient(client),
              icon: const Icon(Icons.edit_rounded),
              tooltip: 'Edit client',
            ),
          ],
        ),
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
                          onPressed: () => _openWhatsApp(client),
                          icon: const Icon(Icons.chat_rounded),
                          label: const Text('WhatsApp'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _callClient(client),
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
                const SizedBox(width: 10),
                Expanded(
                  child: MiniStat(value: client.totalSpent, label: 'Spent'),
                ),
                const SizedBox(width: 10),
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

  Future<void> _editClient(Client client) async {
    final updatedClient = await showClientEditorSheet(
      context,
      initialClient: client,
      title: 'Edit Client',
      submitLabel: 'Save Changes',
    );
    if (updatedClient == null || !mounted) {
      return;
    }

    SalonStoreScope.of(context).updateClient(
      previousPhone: _clientPhoneKey,
      client: updatedClient,
    );
    setState(() => _clientPhoneKey = updatedClient.phone);
    showAppMessage(context, '${updatedClient.name} contact info updated.');
  }

  Future<void> _openWhatsApp(Client client) async {
    final digits = _normalizedPhone(client.phone);
    final salonName = SalonStoreScope.of(context).salonProfile.name;
    final message = Uri.encodeComponent(
      'Hi ${client.name}, this is $salonName.',
    );
    final uri = Uri.parse('https://wa.me/$digits?text=$message');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return;
    }

    if (!mounted) {
      return;
    }
    showAppMessage(context, 'WhatsApp is not available on this device.');
  }

  Future<void> _callClient(Client client) async {
    final uri = Uri(scheme: 'tel', path: _normalizedPhone(client.phone));

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      return;
    }

    if (!mounted) {
      return;
    }
    showAppMessage(context, 'Calling is not available on this device.');
  }

  String _normalizedPhone(String phone) {
    return phone.replaceAll(RegExp(r'[^0-9+]'), '');
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
        subtitle: Text('$date - $stylist'),
        trailing: Text(
          amount,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
