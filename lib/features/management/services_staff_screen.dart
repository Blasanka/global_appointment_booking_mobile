import 'package:flutter/material.dart';

import '../../app/salon_store.dart';
import '../../app/theme.dart';
import '../../shared/models/service.dart';
import '../../shared/models/staff_member.dart';
import '../../shared/widgets/circle_icon.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/premium_card.dart';
import '../../shared/widgets/status_chip.dart';
import 'management_editor_sheets.dart';

class ServicesStaffScreen extends StatefulWidget {
  const ServicesStaffScreen({super.key, this.tab = 0});

  final int tab;

  @override
  State<ServicesStaffScreen> createState() => _ServicesStaffScreenState();
}

class _ServicesStaffScreenState extends State<ServicesStaffScreen> {
  @override
  Widget build(BuildContext context) {
    final store = SalonStoreScope.of(context);
    return DefaultTabController(
      length: 2,
      initialIndex: widget.tab,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Services & Staff'),
              actions: [
                IconButton(
                  onPressed: () => _addEntry(tabController.index),
                  icon: const Icon(Icons.add_rounded),
                ),
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
                    for (final service in store.services)
                      ServiceCard(
                        service: service,
                        onTap: () => _editService(service),
                      ),
                  ],
                ),
                ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    for (final staffMember in store.staffMembers)
                      StaffCard(
                        staffMember: staffMember,
                        onTap: () => _editStaffMember(staffMember),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _addEntry(int tabIndex) async {
    if (tabIndex == 0) {
      final service = await showServiceEditorSheet(
        context,
        title: 'Add Service',
        submitLabel: 'Add Service',
      );
      if (service == null || !mounted) {
        return;
      }
      SalonStoreScope.of(context).addService(service);
      showAppMessage(context, '${service.name} added to services.');
      return;
    }

    final staffMember = await showStaffEditorSheet(
      context,
      title: 'Add Staff Member',
      submitLabel: 'Add Staff Member',
    );
    if (staffMember == null || !mounted) {
      return;
    }
    SalonStoreScope.of(context).addStaffMember(staffMember);
    showAppMessage(context, '${staffMember.name} added to staff.');
  }

  Future<void> _editService(Service service) async {
    final updatedService = await showServiceEditorSheet(
      context,
      initialService: service,
      title: 'Edit Service',
      submitLabel: 'Save Changes',
    );
    if (updatedService == null || !mounted) {
      return;
    }

    SalonStoreScope.of(context).updateService(
      previousName: service.name,
      service: updatedService,
    );
    showAppMessage(context, '${updatedService.name} updated.');
  }

  Future<void> _editStaffMember(StaffMember staffMember) async {
    final updatedStaffMember = await showStaffEditorSheet(
      context,
      initialStaffMember: staffMember,
      title: 'Edit Staff Member',
      submitLabel: 'Save Changes',
    );
    if (updatedStaffMember == null || !mounted) {
      return;
    }

    SalonStoreScope.of(context).updateStaffMember(
      previousName: staffMember.name,
      staffMember: updatedStaffMember,
    );
    showAppMessage(context, '${updatedStaffMember.name} updated.');
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.service,
    required this.onTap,
  });

  final Service service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: onTap,
        leading: const CircleIcon(
          icon: Icons.spa_rounded,
          color: AppColors.blue,
        ),
        title: Text(
          service.name,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        subtitle: Text('${service.duration} - ${service.category}'),
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
  const StaffCard({
    super.key,
    required this.staffMember,
    required this.onTap,
  });

  final StaffMember staffMember;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: onTap,
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
