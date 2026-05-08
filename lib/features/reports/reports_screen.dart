import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../shared/widgets/metric_card.dart';
import '../../shared/widgets/premium_card.dart';
import '../../shared/widgets/helpers.dart';
import '../bookings/calendar_screen.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedPeriod = 'This week · Apr 20 - Apr 26';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        actions: [
          IconButton(
            onPressed: () => showInfoSheet(
              context,
              title: 'Export Report',
              message:
                  'A share action would normally export revenue and booking data. This demo confirms the action without generating a file.',
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
            text: _selectedPeriod,
            onTap: _pickPeriod,
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(
                child: MetricCard(
                  icon: Icons.payments_rounded,
                  value: 'LKR 186k',
                  label: 'Revenue',
                  color: AppColors.green,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: MetricCard(
                  icon: Icons.star_rounded,
                  value: 'Hair Color',
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
                const SizedBox(height: 16),
                SizedBox(
                  height: 170,
                  child: CustomPaint(painter: LineChartPainter()),
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
                const SizedBox(height: 16),
                SizedBox(
                  height: 160,
                  child: CustomPaint(painter: BarChartPainter()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Most Active Staff',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          const StaffActivity(
            name: 'Maya Perera',
            bookings: '18 bookings',
            revenue: 'LKR 84,000',
          ),
          const StaffActivity(
            name: 'Dilan Jay',
            bookings: '14 bookings',
            revenue: 'LKR 38,500',
          ),
        ],
      ),
    );
  }

  Future<void> _pickPeriod() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final period in const [
              'Today · Apr 23',
              'This week · Apr 20 - Apr 26',
              'This month · Apr 1 - Apr 30',
            ])
              ListTile(
                title: Text(period),
                trailing: period == _selectedPeriod
                    ? Icon(
                        Icons.check_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
                onTap: () => Navigator.of(context).pop(period),
              ),
          ],
        ),
      ),
    );
    if (selected != null) {
      setState(() => _selectedPeriod = selected);
      if (mounted) {
        showAppMessage(context, 'Report period changed to $selected.');
      }
    }
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

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final fill = Paint()
      ..color = AppColors.primary.withValues(alpha: .08)
      ..style = PaintingStyle.fill;
    final values = [0.35, 0.52, 0.46, 0.72, 0.64, 0.86, 0.78];
    final path = Path();
    final fillPath = Path();
    for (var i = 0; i < values.length; i++) {
      final x = i * size.width / (values.length - 1);
      final y = size.height - values[i] * size.height;
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
    canvas.drawPath(fillPath, fill);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final values = [0.9, 0.72, 0.54, 0.38];
    final colors = [
      AppColors.primary,
      AppColors.green,
      AppColors.amber,
      AppColors.blue,
    ];
    final barWidth = size.width / 8;
    for (var i = 0; i < values.length; i++) {
      final left = i * size.width / values.length + barWidth / 2;
      final top = size.height - values[i] * size.height;
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, barWidth, size.height - top),
        const Radius.circular(12),
      );
      canvas.drawRRect(rect, Paint()..color = colors[i]);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
