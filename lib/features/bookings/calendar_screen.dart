import 'package:flutter/material.dart';

import '../../app/salon_store.dart';
import '../../app/theme.dart';
import '../../shared/data/mock_data.dart';
import '../../shared/models/booking.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/premium_card.dart';
import '../../shared/widgets/status_chip.dart';
import 'new_booking_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  static const _staffOptions = ['All staff', 'Maya Perera', 'Dilan Jay'];
  static const _serviceOptions = ['All services', 'Hair', 'Beard', 'Skin'];

  int _monthOffset = 0;
  String _selectedView = 'Day';
  int _selectedDateIndex = 2;
  String _selectedStaff = _staffOptions.first;
  String _selectedService = _serviceOptions.first;

  @override
  Widget build(BuildContext context) {
    final store = SalonStoreScope.of(context);
    final visibleBookings = _filteredBookings(store.bookings);

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
                  onPressed: () => setState(() => _monthOffset--),
                  icon: const Icon(Icons.chevron_left_rounded),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      _monthLabel,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                IconButton.filledTonal(
                  onPressed: () => setState(() => _monthOffset++),
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
              selected: {_selectedView},
              onSelectionChanged: (selection) {
                setState(() => _selectedView = selection.first);
              },
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 74,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => DateChip(
                  text: calendarDates[index],
                  selected: index == _selectedDateIndex,
                  onTap: () => setState(() => _selectedDateIndex = index),
                ),
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
                    text: _selectedStaff,
                    onTap: () => _pickOption(
                      title: 'Filter by Staff',
                      options: _staffOptions,
                      currentValue: _selectedStaff,
                      onSelected: (value) => setState(() => _selectedStaff = value),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FilterPill(
                  icon: Icons.tune_rounded,
                  text: _selectedService,
                  onTap: () => _pickOption(
                    title: 'Filter by Service',
                    options: _serviceOptions,
                    currentValue: _selectedService,
                    onSelected: (value) =>
                        setState(() => _selectedService = value),
                  ),
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
            _buildSelectedView(visibleBookings),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedView(List<Booking> visibleBookings) {
    return switch (_selectedView) {
      'Week' => _WeekView(
        selectedDateIndex: _selectedDateIndex,
        bookings: visibleBookings,
      ),
      'Month' => _MonthView(
        selectedDateIndex: _selectedDateIndex,
        bookings: visibleBookings,
        monthLabel: _monthLabel,
      ),
      _ => _DayView(
        selectedDateLabel: calendarDates[_selectedDateIndex],
        bookings: visibleBookings,
        selectedDateIndex: _selectedDateIndex,
      ),
    };
  }

  List<Booking> _filteredBookings(List<Booking> source) {
    final dailyBookings = _bookingsForSelectedDate(source);
    return dailyBookings.where((booking) {
      final staffMatches = _selectedStaff == _staffOptions.first ||
          booking.staffName == _selectedStaff;
      final serviceMatches = _selectedService == _serviceOptions.first ||
          booking.serviceName.toLowerCase().contains(
            _selectedService.toLowerCase(),
          );
      return staffMatches && serviceMatches;
    }).toList();
  }

  List<Booking> _bookingsForSelectedDate(List<Booking> source) {
    if (source.isEmpty) {
      return const [];
    }
    final shift = _selectedDateIndex % source.length;
    return List.generate(source.length, (index) {
      final booking = source[(index + shift) % source.length];
      final time = _shiftTime(booking.time, _selectedDateIndex);
      final status = _statusForDate(index);
      return Booking(
        clientName: booking.clientName,
        serviceName: booking.serviceName,
        staffName: booking.staffName,
        time: time,
        price: booking.price,
        status: status.label,
        statusColor: status.color,
      );
    });
  }

  String _shiftTime(String time, int dayShift) {
    final match = RegExp(r'^(\d{1,2}):(\d{2})\s*(AM|PM)$').firstMatch(time);
    if (match == null) {
      return time;
    }
    var hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);
    final meridiem = match.group(3)!;

    if (meridiem == 'PM' && hour != 12) {
      hour += 12;
    } else if (meridiem == 'AM' && hour == 12) {
      hour = 0;
    }

    final shiftedMinutes = hour * 60 + minute + (dayShift * 20);
    final wrappedMinutes = ((shiftedMinutes % (24 * 60)) + (24 * 60)) % (24 * 60);
    final shiftedHour24 = wrappedMinutes ~/ 60;
    final shiftedMinute = wrappedMinutes % 60;
    final outputMeridiem = shiftedHour24 >= 12 ? 'PM' : 'AM';
    final outputHour12 = switch (shiftedHour24 % 12) {
      0 => 12,
      final value => value,
    };

    return '$outputHour12:${shiftedMinute.toString().padLeft(2, '0')} $outputMeridiem';
  }

  _BookingStatus _statusForDate(int bookingIndex) {
    final pattern = (_selectedDateIndex + bookingIndex) % 3;
    return switch (pattern) {
      1 => const _BookingStatus('In Progress', AppColors.amber),
      2 => const _BookingStatus('Completed', AppColors.blue),
      _ => const _BookingStatus('Confirmed', AppColors.green),
    };
  }

  String get _monthLabel {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    const baseMonth = 4;
    const baseYear = 2026;
    final totalMonths = (baseMonth - 1) + _monthOffset;
    final year = baseYear + (totalMonths ~/ 12);
    final monthIndex = ((totalMonths % 12) + 12) % 12;
    return '${months[monthIndex]} $year';
  }

  Future<void> _pickOption({
    required String title,
    required List<String> options,
    required String currentValue,
    required ValueChanged<String> onSelected,
  }) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            for (final option in options)
              ListTile(
                title: Text(option),
                trailing: option == currentValue
                    ? Icon(
                        Icons.check_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
                onTap: () => Navigator.of(context).pop(option),
              ),
          ],
        ),
      ),
    );
    if (selected != null) {
      onSelected(selected);
      if (mounted) {
        showAppMessage(context, '$title updated to $selected');
      }
    }
  }
}

class _DayView extends StatelessWidget {
  const _DayView({
    required this.selectedDateLabel,
    required this.bookings,
    required this.selectedDateIndex,
  });

  final String selectedDateLabel;
  final List<Booking> bookings;
  final int selectedDateIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PremiumCard(
          padding: const EdgeInsets.fromLTRB(14, 18, 14, 18),
          child: Column(
            children: List.generate(7, (index) {
              final hour = index + 8;
              final block = index < bookings.length
                  ? ScheduleBlock.fromBooking(
                      booking: bookings[index],
                      color: bookings[index].statusColor,
                    )
                  : null;
              return TimelineRow(
                time: '${hour > 12 ? hour - 12 : hour} ${hour >= 12 ? 'PM' : 'AM'}',
                block: block,
              );
            }),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Bookings for ${selectedDateLabel.replaceFirst('\n', ' ')}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 12),
        if (bookings.isEmpty)
          const PremiumCard(
            child: Text('No bookings match the selected filters.'),
          ),
        for (final booking in bookings)
          PremiumCard(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
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
                        '${booking.serviceName} - ${booking.staffName}',
                        style: const TextStyle(color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      booking.time,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 6),
                    StatusChip(
                      label: booking.status,
                      color: booking.statusColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _WeekView extends StatelessWidget {
  const _WeekView({
    required this.selectedDateIndex,
    required this.bookings,
  });

  final int selectedDateIndex;
  final List<Booking> bookings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PremiumCard(
          child: Column(
            children: List.generate(calendarDates.length, (index) {
              final isSelected = index == selectedDateIndex;
              final load = bookings.length + ((index - selectedDateIndex).abs() % 3);
              final revenue = (load * 3500) + (index * 1200);
              return Padding(
                padding: EdgeInsets.only(bottom: index == calendarDates.length - 1 ? 0 : 12),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary.withValues(alpha: .08)
                        : const Color(0xFFF8F7FC),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : AppColors.line,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 72,
                        child: Text(
                          calendarDates[index].replaceFirst('\n', ' '),
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '$load appointments scheduled',
                          style: const TextStyle(color: AppColors.muted),
                        ),
                      ),
                      Text(
                        'LKR ${revenue.toString()}',
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Week Overview',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _SummaryMetric(
                label: 'Active Days',
                value: '${calendarDates.length}',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _SummaryMetric(
                label: 'Selected Day',
                value: '${bookings.length}',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _SummaryMetric(
                label: 'Peak Staff',
                value: bookings.isEmpty ? 'None' : bookings.first.staffName.split(' ').first,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MonthView extends StatelessWidget {
  const _MonthView({
    required this.selectedDateIndex,
    required this.bookings,
    required this.monthLabel,
  });

  final int selectedDateIndex;
  final List<Booking> bookings;
  final String monthLabel;

  @override
  Widget build(BuildContext context) {
    const weekdayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PremiumCard(
          child: Column(
            children: [
              Row(
                children: [
                  for (final label in weekdayLabels)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.muted,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 35,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final day = index + 1;
                  final active = index % calendarDates.length == selectedDateIndex;
                  final hasLoad = day % 3 == 0 || active;
                  return Container(
                    decoration: BoxDecoration(
                      color: active
                          ? Theme.of(context).colorScheme.primary
                          : hasLoad
                              ? const Color(0xFFF6F2FF)
                              : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: active
                            ? Theme.of(context).colorScheme.primary
                            : AppColors.line,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          '$day',
                          style: TextStyle(
                            color: active ? Colors.white : AppColors.ink,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        if (hasLoad)
                          Positioned(
                            bottom: 6,
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: active ? Colors.white : AppColors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text(
          '$monthLabel snapshot',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _SummaryMetric(
                label: 'Highlighted Day',
                value: calendarDates[selectedDateIndex].replaceFirst('\n', ' '),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _SummaryMetric(
                label: 'Bookings',
                value: '${bookings.length}',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _SummaryMetric(
                label: 'Open Slots',
                value: '${18 - bookings.length}',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: AppColors.muted)),
        ],
      ),
    );
  }
}

class _BookingStatus {
  const _BookingStatus(this.label, this.color);

  final String label;
  final Color color;
}

class DateChip extends StatelessWidget {
  const DateChip({
    super.key,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
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
                overflow: TextOverflow.ellipsis,
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

  factory ScheduleBlock.fromBooking({
    required Booking booking,
    required Color color,
  }) {
    return ScheduleBlock(
      client: booking.clientName,
      service: booking.serviceName,
      stylist: booking.staffName,
      color: color,
    );
  }

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
            '$service - $stylist',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: color, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
