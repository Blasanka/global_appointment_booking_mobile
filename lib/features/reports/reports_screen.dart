import 'package:flutter/material.dart';

import '../../app/salon_store.dart';
import '../../app/theme.dart';
import '../../shared/models/booking.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/metric_card.dart';
import '../../shared/widgets/premium_card.dart';
import '../bookings/calendar_screen.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late _ReportRange _selectedRange;

  @override
  void initState() {
    super.initState();
    _selectedRange = _ReportRange.thisMonth(_today);
  }

  DateTime get _today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  @override
  Widget build(BuildContext context) {
    final store = SalonStoreScope.of(context);
    final reportBookings = _bookingsForRange(store.bookings, _selectedRange);
    final weeklyRevenue = _weeklyRevenue(reportBookings);
    final topServices = _topServices(reportBookings);
    final activeStaff = _staffStats(reportBookings);
    final totalRevenue = reportBookings.fold<int>(
      0,
      (sum, booking) => sum + _parseCurrency(booking.price),
    );
    final topServiceName = topServices.isEmpty ? 'No bookings' : topServices.first.name;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        actions: [
          IconButton(
            onPressed: () => showAppMessage(
              context,
              'Revenue summary prepared for ${_selectedRange.label.toLowerCase()}.',
            ),
            icon: const Icon(Icons.ios_share_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          FilterPill(
            icon: Icons.date_range_rounded,
            text: _selectedRange.label,
            onTap: _pickPeriod,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: MetricCard(
                  icon: Icons.payments_rounded,
                  value: _formatCurrency(totalRevenue),
                  label: 'Revenue',
                  color: AppColors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MetricCard(
                  icon: Icons.star_rounded,
                  value: topServiceName,
                  label: 'Top Service',
                  color: AppColors.amber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          PremiumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Weekly Revenue',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'Snapshot for ${_selectedRange.label}',
                  style: const TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 170,
                  child: LineChartCard(data: weeklyRevenue),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PremiumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Top Services',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  '${topServices.length} ranked services in this range',
                  style: const TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 16),
                if (topServices.isEmpty)
                  const Text('No completed service data in this range.')
                else
                  ...[
                    for (var index = 0; index < topServices.length; index++)
                      _ServiceRankTile(
                        service: topServices[index],
                        maxBookings: topServices.first.bookings,
                        showDivider: index != topServices.length - 1,
                      ),
                  ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Most Active Staff',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          if (activeStaff.isEmpty)
            const PremiumCard(
              child: Text('No staff activity for the selected range.'),
            )
          else
            for (final staff in activeStaff)
              StaffActivity(
                name: staff.name,
                bookings: '${staff.bookings} bookings',
                revenue: _formatCurrency(staff.revenue),
              ),
        ],
      ),
    );
  }

  Future<void> _pickPeriod() async {
    final selected = await showModalBottomSheet<_ReportRange>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _RangeOptionTile(
              label: _ReportRange.today(_today).label,
              selected: _selectedRange.type == _ReportRangeType.today,
              onTap: () => Navigator.of(context).pop(_ReportRange.today(_today)),
            ),
            _RangeOptionTile(
              label: _ReportRange.thisWeek(_today).label,
              selected: _selectedRange.type == _ReportRangeType.thisWeek,
              onTap: () => Navigator.of(context).pop(_ReportRange.thisWeek(_today)),
            ),
            _RangeOptionTile(
              label: _ReportRange.thisMonth(_today).label,
              selected: _selectedRange.type == _ReportRangeType.thisMonth,
              onTap: () => Navigator.of(context).pop(_ReportRange.thisMonth(_today)),
            ),
            ListTile(
              title: Text(_selectedRange.type == _ReportRangeType.custom
                  ? _selectedRange.label
                  : 'Custom Range'),
              subtitle: const Text('Pick a start and end date'),
              trailing: _selectedRange.type == _ReportRangeType.custom
                  ? Icon(
                      Icons.check_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : const Icon(Icons.chevron_right_rounded),
              onTap: () async {
                final navigator = Navigator.of(context);
                final picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(_today.year - 1),
                  lastDate: DateTime(_today.year + 1, 12, 31),
                  initialDateRange: DateTimeRange(
                    start: _selectedRange.start,
                    end: _selectedRange.end,
                  ),
                );
                if (picked == null || !context.mounted) {
                  return;
                }
                navigator.pop(
                  _ReportRange.custom(
                    DateTime(picked.start.year, picked.start.month, picked.start.day),
                    DateTime(picked.end.year, picked.end.month, picked.end.day),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
    if (selected != null) {
      setState(() => _selectedRange = selected);
      if (mounted) {
        showAppMessage(context, 'Report range changed to ${selected.label}.');
      }
    }
  }

  List<Booking> _bookingsForRange(List<Booking> source, _ReportRange range) {
    final days = range.end.difference(range.start).inDays + 1;
    final bookings = <Booking>[];
    for (var dayIndex = 0; dayIndex < days; dayIndex++) {
      final date = range.start.add(Duration(days: dayIndex));
      for (var bookingIndex = 0; bookingIndex < source.length; bookingIndex++) {
        final seed = dayIndex + bookingIndex;
        if ((seed + date.day) % 2 != 0) {
          continue;
        }
        final booking = source[(bookingIndex + dayIndex) % source.length];
        bookings.add(
          Booking(
            clientName: booking.clientName,
            serviceName: booking.serviceName,
            staffName: booking.staffName,
            time: booking.time,
            price: _scaledPrice(booking.price, seed),
            status: booking.status,
            statusColor: booking.statusColor,
          ),
        );
      }
    }
    return bookings;
  }

  List<_RevenuePoint> _weeklyRevenue(List<Booking> bookings) {
    final weekStart = _selectedRange.end.subtract(
      Duration(days: _selectedRange.end.weekday - 1),
    );
    return List.generate(7, (index) {
      final date = weekStart.add(Duration(days: index));
      final revenue = bookings.fold<int>(0, (sum, booking) {
        final seed = booking.clientName.length +
            booking.serviceName.length +
            booking.staffName.length +
            date.day;
        final belongsToDay = seed % 7 == index;
        return belongsToDay ? sum + _parseCurrency(booking.price) : sum;
      });
      return _RevenuePoint(
        label: _weekdayLabel(date.weekday),
        value: revenue,
      );
    });
  }

  List<_ServiceStat> _topServices(List<Booking> bookings) {
    final totals = <String, _ServiceStat>{};
    for (final booking in bookings) {
      final existing = totals[booking.serviceName];
      final revenue = _parseCurrency(booking.price);
      totals[booking.serviceName] = _ServiceStat(
        name: booking.serviceName,
        bookings: (existing?.bookings ?? 0) + 1,
        revenue: (existing?.revenue ?? 0) + revenue,
      );
    }
    final ranked = totals.values.toList()
      ..sort((a, b) {
        final bookingCompare = b.bookings.compareTo(a.bookings);
        if (bookingCompare != 0) {
          return bookingCompare;
        }
        return b.revenue.compareTo(a.revenue);
      });
    return ranked.take(4).toList();
  }

  List<_StaffStat> _staffStats(List<Booking> bookings) {
    final totals = <String, _StaffStat>{};
    for (final booking in bookings) {
      final existing = totals[booking.staffName];
      final revenue = _parseCurrency(booking.price);
      totals[booking.staffName] = _StaffStat(
        name: booking.staffName,
        bookings: (existing?.bookings ?? 0) + 1,
        revenue: (existing?.revenue ?? 0) + revenue,
      );
    }
    final ranked = totals.values.toList()
      ..sort((a, b) {
        final bookingCompare = b.bookings.compareTo(a.bookings);
        if (bookingCompare != 0) {
          return bookingCompare;
        }
        return b.revenue.compareTo(a.revenue);
      });
    return ranked;
  }

  int _parseCurrency(String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(digits) ?? 0;
  }

  String _scaledPrice(String price, int seed) {
    final base = _parseCurrency(price);
    final multiplier = 1 + ((seed % 3) * 0.12);
    final scaled = (base * multiplier).round();
    return _formatCurrency(scaled);
  }

  static String _formatCurrency(int value) {
    final text = value.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      final remaining = text.length - i;
      buffer.write(text[i]);
      if (remaining > 1 && remaining % 3 == 1) {
        buffer.write(',');
      }
    }
    return 'LKR ${buffer.toString()}';
  }

  String _weekdayLabel(int weekday) {
    const labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return labels[weekday - 1];
  }
}

class StaffActivity extends StatelessWidget {
  const StaffActivity({
    super.key,
    required this.name,
    required this.bookings,
    required this.revenue,
  });

  final String name;
  final String bookings;
  final String revenue;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          CircleAvatar(
            child: Text(name.split(' ').map((part) => part[0]).take(2).join()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w900)),
                Text(bookings, style: const TextStyle(color: AppColors.muted)),
              ],
            ),
          ),
          Text(revenue, style: const TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class LineChartCard extends StatelessWidget {
  const LineChartCard({super.key, required this.data});

  final List<_RevenuePoint> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomPaint(painter: LineChartPainter(data)),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            for (final point in data)
              Expanded(
                child: Text(
                  point.label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _ServiceRankTile extends StatelessWidget {
  const _ServiceRankTile({
    required this.service,
    required this.maxBookings,
    required this.showDivider,
  });

  final _ServiceStat service;
  final int maxBookings;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final progressMax = maxBookings == 0 ? 1.0 : maxBookings.toDouble();
    return Padding(
      padding: EdgeInsets.only(bottom: showDivider ? 14 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  service.name,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${service.bookings} bookings',
                style: const TextStyle(color: AppColors.muted),
              ),
              const SizedBox(width: 12),
              Text(
                _ReportsScreenState._formatCurrency(service.revenue),
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: service.bookings / progressMax,
              minHeight: 10,
              backgroundColor: const Color(0xFFF2EEF9),
              color: AppColors.primary,
            ),
          ),
          if (showDivider) const SizedBox(height: 2),
        ],
      ),
    );
  }
}

class _RangeOptionTile extends StatelessWidget {
  const _RangeOptionTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: selected
          ? Icon(
              Icons.check_rounded,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
      onTap: onTap,
    );
  }
}

class LineChartPainter extends CustomPainter {
  LineChartPainter(this.data);

  final List<_RevenuePoint> data;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) {
      return;
    }

    final maxValue = data.fold<int>(0, (max, point) => point.value > max ? point.value : max);
    final resolvedMax = maxValue == 0 ? 1 : maxValue;
    final linePaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final fillPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: .08)
      ..style = PaintingStyle.fill;
    final dotPaint = Paint()..color = AppColors.primary;
    final gridPaint = Paint()
      ..color = AppColors.line
      ..strokeWidth = 1;

    for (var i = 1; i <= 3; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final path = Path();
    final fillPath = Path();

    for (var i = 0; i < data.length; i++) {
      final x = data.length == 1 ? size.width / 2 : i * size.width / (data.length - 1);
      final y = size.height - ((data[i].value / resolvedMax) * (size.height - 12)) - 6;
      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);

    for (var i = 0; i < data.length; i++) {
      final x = data.length == 1 ? size.width / 2 : i * size.width / (data.length - 1);
      final y = size.height - ((data[i].value / resolvedMax) * (size.height - 12)) - 6;
      canvas.drawCircle(Offset(x, y), 4.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant LineChartPainter oldDelegate) {
    return oldDelegate.data != data;
  }
}

class _RevenuePoint {
  const _RevenuePoint({
    required this.label,
    required this.value,
  });

  final String label;
  final int value;
}

class _ServiceStat {
  const _ServiceStat({
    required this.name,
    required this.bookings,
    required this.revenue,
  });

  final String name;
  final int bookings;
  final int revenue;
}

class _StaffStat {
  const _StaffStat({
    required this.name,
    required this.bookings,
    required this.revenue,
  });

  final String name;
  final int bookings;
  final int revenue;
}

class _ReportRange {
  const _ReportRange({
    required this.type,
    required this.start,
    required this.end,
    required this.label,
  });

  factory _ReportRange.today(DateTime today) {
    final date = DateTime(today.year, today.month, today.day);
    return _ReportRange(
      type: _ReportRangeType.today,
      start: date,
      end: date,
      label: 'Today - ${_formatSingleDate(date)}',
    );
  }

  factory _ReportRange.thisWeek(DateTime today) {
    final start = today.subtract(Duration(days: today.weekday - 1));
    final end = start.add(const Duration(days: 6));
    return _ReportRange(
      type: _ReportRangeType.thisWeek,
      start: start,
      end: end,
      label: 'This Week - ${_formatShortRange(start, end)}',
    );
  }

  factory _ReportRange.thisMonth(DateTime today) {
    final start = DateTime(today.year, today.month, 1);
    final end = DateTime(today.year, today.month + 1, 0);
    return _ReportRange(
      type: _ReportRangeType.thisMonth,
      start: start,
      end: end,
      label: 'This Month - ${_formatShortRange(start, end)}',
    );
  }

  factory _ReportRange.custom(DateTime start, DateTime end) {
    return _ReportRange(
      type: _ReportRangeType.custom,
      start: start,
      end: end,
      label: 'Range - ${_formatShortRange(start, end)}',
    );
  }

  final _ReportRangeType type;
  final DateTime start;
  final DateTime end;
  final String label;

  static String _formatSingleDate(DateTime date) {
    return '${_monthLabel(date.month)} ${date.day}';
  }

  static String _formatShortRange(DateTime start, DateTime end) {
    if (start.year == end.year && start.month == end.month) {
      return '${_monthLabel(start.month)} ${start.day} - ${end.day}';
    }
    return '${_monthLabel(start.month)} ${start.day} - ${_monthLabel(end.month)} ${end.day}';
  }

  static String _monthLabel(int month) {
    const labels = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return labels[month - 1];
  }
}

enum _ReportRangeType {
  today,
  thisWeek,
  thisMonth,
  custom,
}
