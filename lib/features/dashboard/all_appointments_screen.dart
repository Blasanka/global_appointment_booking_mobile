import 'package:flutter/material.dart';

import '../../app/salon_store.dart';
import '../../app/theme.dart';
import '../../shared/models/booking.dart';
import '../../shared/widgets/premium_card.dart';
import '../../shared/widgets/status_chip.dart';

class AllAppointmentsScreen extends StatefulWidget {
  const AllAppointmentsScreen({super.key});

  @override
  State<AllAppointmentsScreen> createState() => _AllAppointmentsScreenState();
}

class _AllAppointmentsScreenState extends State<AllAppointmentsScreen> {
  static const _allStatuses = 'All statuses';
  static const _allStaff = 'All staff';

  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  String _selectedStatus = _allStatuses;
  String _selectedStaff = _allStaff;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = SalonStoreScope.of(context);
    final bookings = _filteredBookings(store.bookings);
    final staffOptions = [
      _allStaff,
      ...{for (final booking in store.bookings) booking.staffName},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('All Appointments')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _searchController,
            onChanged: (value) => setState(() => _searchText = value.trim()),
            decoration: InputDecoration(
              hintText: 'Search client, service, or staff',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: _searchText.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchText = '');
                      },
                      icon: const Icon(Icons.close_rounded),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  items: const [
                    DropdownMenuItem(
                      value: _allStatuses,
                      child: Text(_allStatuses),
                    ),
                    DropdownMenuItem(
                      value: 'Confirmed',
                      child: Text('Confirmed'),
                    ),
                    DropdownMenuItem(
                      value: 'In Progress',
                      child: Text('In Progress'),
                    ),
                    DropdownMenuItem(
                      value: 'Completed',
                      child: Text('Completed'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedStatus = value);
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    prefixIcon: Icon(Icons.flag_rounded),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedStaff,
                  items: [
                    for (final staff in staffOptions)
                      DropdownMenuItem(value: staff, child: Text(staff)),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedStaff = value);
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Staff',
                    prefixIcon: Icon(Icons.person_search_rounded),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          PremiumCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.event_note_rounded, color: AppColors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${bookings.length} appointments match your filters',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (bookings.isEmpty)
            const PremiumCard(
              child: Text('No appointments match the current search and filters.'),
            ),
          for (final booking in bookings) _AppointmentListCard(booking: booking),
        ],
      ),
    );
  }

  List<Booking> _filteredBookings(List<Booking> bookings) {
    final query = _searchText.toLowerCase();
    return bookings.where((booking) {
      final matchesQuery = query.isEmpty ||
          booking.clientName.toLowerCase().contains(query) ||
          booking.serviceName.toLowerCase().contains(query) ||
          booking.staffName.toLowerCase().contains(query);
      final matchesStatus =
          _selectedStatus == _allStatuses || booking.status == _selectedStatus;
      final matchesStaff =
          _selectedStaff == _allStaff || booking.staffName == _selectedStaff;
      return matchesQuery && matchesStatus && matchesStaff;
    }).toList();
  }
}

class _AppointmentListCard extends StatelessWidget {
  const _AppointmentListCard({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  booking.clientName,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                ),
              ),
              StatusChip(label: booking.status, color: booking.statusColor),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            booking.serviceName,
            style: const TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.schedule_rounded, size: 18, color: AppColors.muted),
              const SizedBox(width: 6),
              Text(
                booking.time,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.badge_rounded, size: 18, color: AppColors.muted),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  booking.staffName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                booking.price,
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
