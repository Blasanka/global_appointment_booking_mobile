import 'package:flutter/material.dart';

import '../../app/salon_store.dart';
import '../../app/theme.dart';
import '../../shared/models/booking.dart';
import '../../shared/widgets/action_tile.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/metric_card.dart';
import '../../shared/widgets/premium_card.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/status_chip.dart';
import '../bookings/new_booking_screen.dart';
import '../clients/clients_screen.dart';
import '../management/services_staff_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = SalonStoreScope.of(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning, Niro',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Glow & Grace Salon',
                        style: TextStyle(color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
                IconButton.filledTonal(
                  onPressed: () => showAppMessage(
                    context,
                    'No new notifications right now.',
                  ),
                  icon: const Icon(Icons.notifications_none_rounded),
                ),
                const SizedBox(width: 8),
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: Color(0xFFE7DFFD),
                  child: Text(
                    'N',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: MetricCard(
                    icon: Icons.event_available_rounded,
                    value: '${store.bookings.length}',
                    label: 'Bookings',
                    color: AppColors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MetricCard(
                    icon: Icons.payments_rounded,
                    value: store.totalRevenue,
                    label: 'Revenue',
                    color: AppColors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MetricCard(
                    icon: Icons.schedule_rounded,
                    value: '${store.confirmedBookings}',
                    label: 'Confirmed',
                    color: AppColors.amber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            SectionHeader(
              title: 'Today\'s Appointments',
              action: 'View All',
              onTap: () => showInfoSheet(
                context,
                title: 'Today\'s Schedule',
                message:
                    'You have ${store.bookings.length} active appointments on the dashboard today.',
              ),
            ),
            const SizedBox(height: 12),
            for (final booking in store.bookings)
              AppointmentCard(booking: booking),
            const SizedBox(height: 20),
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.28,
              children: [
                ActionTile(
                  icon: Icons.add_circle_outline_rounded,
                  title: 'New Booking',
                  subtitle: 'Reserve a service slot',
                  onTap: () => pushScreen(context, const NewBookingScreen()),
                ),
                ActionTile(
                  icon: Icons.people_outline_rounded,
                  title: 'Clients',
                  subtitle: 'Profiles and history',
                  onTap: () => pushScreen(context, const ClientsScreen()),
                ),
                ActionTile(
                  icon: Icons.spa_outlined,
                  title: 'Services',
                  subtitle: 'Prices and durations',
                  onTap: () => pushScreen(context, const ServicesStaffScreen()),
                ),
                ActionTile(
                  icon: Icons.badge_outlined,
                  title: 'Staff',
                  subtitle: 'Roster availability',
                  onTap: () =>
                      pushScreen(context, const ServicesStaffScreen(tab: 1)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => _showAppointmentDetails(context),
        child: PremiumCard(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                child: Text(initials(booking.clientName)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.clientName,
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${booking.serviceName} · ${booking.staffName}',
                      style: const TextStyle(color: AppColors.muted),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          booking.time,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(width: 8),
                        StatusChip(
                          label: booking.status,
                          color: booking.statusColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAppointmentDetails(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.clientName,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Today\'s appointment details',
                  style: TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 20),
                _AppointmentDetailRow(label: 'Service', value: booking.serviceName),
                _AppointmentDetailRow(label: 'Staff', value: booking.staffName),
                _AppointmentDetailRow(label: 'Time', value: booking.time),
                _AppointmentDetailRow(label: 'Price', value: booking.price),
                _AppointmentDetailRow(label: 'Status', value: booking.status),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppointmentDetailRow extends StatelessWidget {
  const _AppointmentDetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.muted,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
