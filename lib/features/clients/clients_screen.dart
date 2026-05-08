import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../shared/data/mock_data.dart';
import '../../shared/models/client.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/premium_card.dart';
import 'client_detail_screen.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final _searchController = TextEditingController();
  final List<Client> _extraClients = [];
  String _filter = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visibleClients = _filteredClients;
    return Scaffold(
      appBar: AppBar(title: const Text('Clients')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded),
                    hintText: 'Search clients',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton.filledTonal(
                onPressed: _pickFilter,
                icon: const Icon(Icons.tune_rounded),
              ),
              const SizedBox(width: 10),
              IconButton.filled(
                onPressed: _addClient,
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Filter: $_filter',
            style: const TextStyle(
              color: AppColors.muted,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          if (visibleClients.isEmpty)
            const PremiumCard(
              child: Text('No clients match the current search and filter.'),
            ),
          for (final client in visibleClients) ClientListCard(client: client),
        ],
      ),
    );
  }

  List<Client> get _filteredClients {
    final query = _searchController.text.trim().toLowerCase();
    return [..._extraClients, ...clients].where((client) {
      final matchesQuery =
          query.isEmpty ||
          client.name.toLowerCase().contains(query) ||
          client.phone.toLowerCase().contains(query) ||
          client.lastService.toLowerCase().contains(query);
      final matchesFilter = switch (_filter) {
        'Recent' => client.lastService.isNotEmpty,
        'High Value' => client.totalSpent.contains('92') || client.totalSpent.contains('118'),
        _ => true,
      };
      return matchesQuery && matchesFilter;
    }).toList();
  }

  Future<void> _pickFilter() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final value in const ['All', 'Recent', 'High Value'])
              ListTile(
                title: Text(value),
                trailing: value == _filter
                    ? Icon(
                        Icons.check_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
                onTap: () => Navigator.of(context).pop(value),
              ),
          ],
        ),
      ),
    );
    if (selected != null) {
      setState(() => _filter = selected);
      if (mounted) {
        showAppMessage(context, 'Client filter changed to $selected.');
      }
    }
  }

  Future<void> _addClient() async {
    setState(() {
      _extraClients.insert(
        0,
        const Client(
          name: 'New Walk-in Client',
          phone: '+94 75 101 2020',
          lastService: 'Consultation',
          visits: '1 visit',
          totalSpent: 'LKR 0',
        ),
      );
    });
    showAppMessage(context, 'Client draft added to the list.');
  }
}

class ClientListCard extends StatelessWidget {
  const ClientListCard({super.key, required this.client});

  final Client client;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => pushScreen(context, ClientDetailScreen(client: client)),
      child: PremiumCard(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(radius: 25, child: Text(initials(client.name))),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.name,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    client.phone,
                    style: const TextStyle(color: AppColors.muted),
                  ),
                  Text(
                    client.lastService,
                    style: const TextStyle(color: AppColors.muted),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  client.visits,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(
                  client.totalSpent,
                  style: const TextStyle(color: AppColors.muted, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}
