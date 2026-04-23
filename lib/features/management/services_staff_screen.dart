import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../shared/data/mock_data.dart';
import '../../shared/models/service.dart';
import '../../shared/models/staff_member.dart';
import '../../shared/widgets/circle_icon.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/premium_card.dart';
import '../../shared/widgets/status_chip.dart';

class ServicesStaffScreen extends StatelessWidget {
  const ServicesStaffScreen({super.key, this.tab = 0});

  final int tab;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: tab,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Services & Staff'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.add_rounded)),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Services'),
              Tab(text: 'Staff'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: const EdgeInsets.all(20),
              children: [
                for (final service in services) ServiceCard(service: service),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(20),
              children: [
                for (final staffMember in staffMembers)
                  StaffCard(staffMember: staffMember),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const CircleIcon(
          icon: Icons.spa_rounded,
          color: AppColors.blue,
        ),
        title: Text(
          service.name,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        subtitle: Text('${service.duration} · ${service.category}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              service.price,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
            const Icon(Icons.edit_outlined, size: 18),
          ],
        ),
      ),
    );
  }
}

class StaffCard extends StatelessWidget {
  const StaffCard({super.key, required this.staffMember});

  final StaffMember staffMember;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 26,
          child: Text(initials(staffMember.name)),
        ),
        title: Text(
          staffMember.name,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        subtitle: Text('${staffMember.role}\n${staffMember.rating}'),
        isThreeLine: true,
        trailing: StatusChip(
          label: staffMember.available ? 'Available' : 'Off',
          color: staffMember.available ? AppColors.green : AppColors.red,
        ),
      ),
    );
  }
}
