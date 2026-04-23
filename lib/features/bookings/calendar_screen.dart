import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../shared/data/mock_data.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/premium_card.dart';
import '../../shared/widgets/status_chip.dart';
import 'new_booking_screen.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => pushScreen(context, const NewBookingScreen()),
        icon: const Icon(Icons.add),
        label: const Text('New Booking'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: const Icon(Icons.chevron_left_rounded),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'April 2026',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Day', label: Text('Day')),
                ButtonSegment(value: 'Week', label: Text('Week')),
                ButtonSegment(value: 'Month', label: Text('Month')),
              ],
              selected: const {'Day'},
              onSelectionChanged: (_) {},
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 74,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    DateChip(text: calendarDates[index], selected: index == 2),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: calendarDates.length,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: FilterPill(
                    icon: Icons.person_search_rounded,
                    text: 'All staff',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 10),
                FilterPill(
                  icon: Icons.tune_rounded,
                  text: 'Service',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Wrap(
              spacing: 8,
              children: [
                StatusChip(label: 'Confirmed', color: AppColors.green),
                StatusChip(label: 'In Progress', color: AppColors.amber),
                StatusChip(label: 'Completed', color: AppColors.blue),
              ],
            ),
            const SizedBox(height: 18),
            PremiumCard(
              padding: const EdgeInsets.fromLTRB(14, 18, 14, 18),
              child: Column(
                children: List.generate(7, (index) {
                  final hour = index + 8;
                  return TimelineRow(
                    time:
                        '${hour > 12 ? hour - 12 : hour} ${hour >= 12 ? 'PM' : 'AM'}',
                    block: switch (index) {
                      1 => const ScheduleBlock(
                        client: 'Anjali Kumar',
                        service: 'Hair Color',
                        stylist: 'Maya',
                        color: AppColors.green,
                      ),
                      3 => const ScheduleBlock(
                        client: 'Ruwan Silva',
                        service: 'Beard Trim',
                        stylist: 'Dilan',
                        color: AppColors.amber,
                      ),
                      5 => const ScheduleBlock(
                        client: 'Fathima Meer',
                        service: 'Keratin Treatment',
                        stylist: 'Maya',
                        color: AppColors.blue,
                      ),
                      _ => null,
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateChip extends StatelessWidget {
  const DateChip({super.key, required this.text, required this.selected});

  final String text;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).colorScheme.primary : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.line),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: selected ? Colors.white : AppColors.ink,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class FilterPill extends StatelessWidget {
  const FilterPill({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.line),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimelineRow extends StatelessWidget {
  const TimelineRow({super.key, required this.time, this.block});

  final String time;
  final ScheduleBlock? block;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 56,
            child: Text(
              time,
              style: const TextStyle(
                color: AppColors.muted,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.line)),
              ),
              child: block,
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduleBlock extends StatelessWidget {
  const ScheduleBlock({
    super.key,
    required this.client,
    required this.service,
    required this.stylist,
    required this.color,
  });

  final String client;
  final String service;
  final String stylist;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(18),
        border: Border(left: BorderSide(color: color, width: 5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            client,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 2),
          Text(
            '$service · $stylist',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: color, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
