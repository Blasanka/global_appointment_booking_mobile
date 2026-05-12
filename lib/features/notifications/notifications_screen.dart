import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../shared/widgets/premium_card.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _activeFilter = 'All';

  final List<_NotificationItem> _items = [
    _NotificationItem(
      title: 'Appointment starts in 30 minutes',
      message: 'Anjali Kumar is scheduled for Hair Color + Blowout at 10:30 AM.',
      timeLabel: 'Just now',
      category: 'Bookings',
      unread: true,
    ),
    _NotificationItem(
      title: 'Staff availability changed',
      message: 'Ishara Sen is marked unavailable for the rest of the day.',
      timeLabel: '18 min ago',
      category: 'Staff',
      unread: true,
    ),
    _NotificationItem(
      title: 'Daily revenue target reached',
      message: 'Today crossed LKR 30,000 in completed services.',
      timeLabel: '1 hr ago',
      category: 'System',
    ),
    _NotificationItem(
      title: 'Booking completed',
      message: 'Fathima Meer checked out successfully after Keratin Treatment.',
      timeLabel: '2 hr ago',
      category: 'Bookings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredItems = _filteredItems;
    final unreadCount = _items.where((item) => item.unread).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: unreadCount == 0
                ? null
                : () {
                    setState(() {
                      for (final item in _items) {
                        item.unread = false;
                      }
                    });
                  },
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          PremiumCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEDE8FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_active_rounded,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    unreadCount == 0
                        ? 'All caught up'
                        : '$unreadCount unread notifications need attention',
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final label in const ['All', 'Unread', 'Bookings', 'Staff', 'System'])
                ChoiceChip(
                  label: Text(label),
                  selected: _activeFilter == label,
                  onSelected: (_) => setState(() => _activeFilter = label),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (filteredItems.isEmpty)
            const PremiumCard(
              child: Text('No notifications match this filter.'),
            ),
          for (final item in filteredItems) _NotificationCard(item: item),
        ],
      ),
    );
  }

  List<_NotificationItem> get _filteredItems {
    return _items.where((item) {
      return switch (_activeFilter) {
        'Unread' => item.unread,
        'Bookings' || 'Staff' || 'System' => item.category == _activeFilter,
        _ => true,
      };
    }).toList();
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.item});

  final _NotificationItem item;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: item.unread ? AppColors.primary : AppColors.line,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.timeLabel,
                      style: const TextStyle(color: AppColors.muted),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  item.message,
                  style: const TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F0FA),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    item.category,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationItem {
  _NotificationItem({
    required this.title,
    required this.message,
    required this.timeLabel,
    required this.category,
    this.unread = false,
  });

  final String title;
  final String message;
  final String timeLabel;
  final String category;
  bool unread;
}
