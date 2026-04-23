import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../shared/data/mock_data.dart';
import '../../shared/models/client.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/premium_card.dart';
import 'client_detail_screen.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clients')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded),
                    hintText: 'Search clients',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton.filledTonal(
                onPressed: () {},
                icon: const Icon(Icons.tune_rounded),
              ),
              const SizedBox(width: 10),
              IconButton.filled(
                onPressed: () {},
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (final client in clients) ClientListCard(client: client),
        ],
      ),
    );
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
