import 'package:flutter/material.dart';

void main() {
  runApp(const SalonFlowApp());
}

class SalonFlowApp extends StatelessWidget {
  const SalonFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF6D5DF6);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SalonFlow',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F4EF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          primary: primary,
          surface: Colors.white,
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Color(0xFFF7F4EF),
          foregroundColor: Color(0xFF17151F),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF8F7FB),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            backgroundColor: primary,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            side: const BorderSide(color: Color(0xFFE4DFEE)),
            foregroundColor: const Color(0xFF17151F),
            textStyle: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class AppColors {
  static const ink = Color(0xFF17151F);
  static const muted = Color(0xFF766F82);
  static const line = Color(0xFFE8E2DC);
  static const green = Color(0xFF22A06B);
  static const amber = Color(0xFFE9A23B);
  static const red = Color(0xFFE25563);
  static const blue = Color(0xFF2F80ED);
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              const Spacer(),
              const BrandMark(size: 96),
              const SizedBox(height: 22),
              Text(
                'SalonFlow',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Bookings, staff, and clients in one place',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.muted, fontSize: 16),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                ),
                child: const Text('Continue'),
              ),
              const SizedBox(height: 18),
              const Text(
                'Version 1.0.0',
                style: TextStyle(color: AppColors.muted, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: BrandMark(size: 76)),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Welcome back',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.ink,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Run your salon day without notebook chaos.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.muted, fontSize: 15),
                ),
              ),
              const SizedBox(height: 32),
              PremiumCard(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.alternate_email_rounded),
                        hintText: 'Phone or email',
                      ),
                    ),
                    const SizedBox(height: 12),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const MainShell()),
                      ),
                      child: const Text('Sign In'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.g_mobiledata_rounded, size: 30),
                      label: const Text('Continue with Google'),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('Forgot password?'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Create account'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  final screens = const [
    DashboardScreen(),
    CalendarScreen(),
    ClientsScreen(),
    ReportsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month_rounded),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline_rounded),
            selectedIcon: Icon(Icons.people_rounded),
            label: 'Clients',
          ),
          NavigationDestination(
            icon: Icon(Icons.insert_chart_outlined_rounded),
            selectedIcon: Icon(Icons.insert_chart_rounded),
            label: 'Reports',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
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
            const Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    icon: Icons.event_available_rounded,
                    value: '12',
                    label: 'Bookings',
                    color: AppColors.blue,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: SummaryCard(
                    icon: Icons.payments_rounded,
                    value: 'LKR 28,500',
                    label: 'Revenue',
                    color: AppColors.green,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: SummaryCard(
                    icon: Icons.schedule_rounded,
                    value: '3',
                    label: 'Slots',
                    color: AppColors.amber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            SectionHeader(
              title: 'Today’s Appointments',
              action: 'View All',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            const AppointmentCard(
              initials: 'AK',
              client: 'Anjali Kumar',
              service: 'Hair Color + Blowout',
              stylist: 'Maya Perera',
              time: '10:30 AM',
              status: 'Confirmed',
              color: AppColors.green,
            ),
            const AppointmentCard(
              initials: 'RS',
              client: 'Ruwan Silva',
              service: 'Beard Trim',
              stylist: 'Dilan',
              time: '12:00 PM',
              status: 'In Progress',
              color: AppColors.amber,
            ),
            const AppointmentCard(
              initials: 'FM',
              client: 'Fathima Meer',
              service: 'Keratin Treatment',
              stylist: 'Maya Perera',
              time: '03:15 PM',
              status: 'Completed',
              color: AppColors.blue,
            ),
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

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dates = ['Tue\n12', 'Wed\n13', 'Thu\n14', 'Fri\n15', 'Sat\n16'];
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
                    DateChip(text: dates[index], selected: index == 2),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: dates.length,
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

class NewBookingScreen extends StatelessWidget {
  const NewBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final slots = ['9:00', '10:30', '12:00', '2:15', '3:30', '5:00'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Booking'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close_rounded),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Confirm Booking'),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        children: [
          FormSection(
            title: 'Client',
            children: [
              const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded),
                  hintText: 'Search existing client',
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.person_add_alt_rounded),
                label: const Text('Add new client'),
              ),
              const SizedBox(height: 12),
              const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone_rounded),
                  hintText: 'Client phone number',
                ),
              ),
              const SizedBox(height: 12),
              const TextField(
                maxLines: 3,
                decoration: InputDecoration(hintText: 'Notes'),
              ),
            ],
          ),
          FormSection(
            title: 'Service',
            children: const [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  SelectablePill(text: 'Hair Color', selected: true),
                  SelectablePill(text: 'Facial', selected: false),
                  SelectablePill(text: 'Beard Trim', selected: false),
                ],
              ),
              SizedBox(height: 12),
              ReadOnlyField(label: 'Duration', value: '90 minutes'),
              SizedBox(height: 12),
              ReadOnlyField(label: 'Price', value: 'LKR 8,500'),
            ],
          ),
          FormSection(
            title: 'Staff & Time',
            children: [
              const ReadOnlyField(label: 'Stylist', value: 'Maya Perera'),
              const SizedBox(height: 12),
              const ReadOnlyField(label: 'Date', value: 'Thursday, Apr 23'),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.3,
                children: [
                  for (final slot in slots)
                    SelectablePill(text: slot, selected: slot == '10:30'),
                ],
              ),
            ],
          ),
          FormSection(
            title: 'Confirmation',
            children: [
              const BookingSummaryRow(
                label: 'Hair Color + Blowout',
                value: 'LKR 8,500',
              ),
              const BookingSummaryRow(label: 'Maya Perera', value: '10:30 AM'),
              const Divider(height: 28),
              const BookingSummaryRow(
                label: 'Total',
                value: 'LKR 8,500',
                strong: true,
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: true,
                onChanged: (_) {},
                title: const Text('Deposit required'),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: true,
                onChanged: (_) {},
                title: const Text('Send WhatsApp confirmation'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final clients = [
      (
        'Anjali Kumar',
        '+94 77 123 4567',
        'Hair Color',
        '12 visits',
        'LKR 92,500',
      ),
      (
        'Fathima Meer',
        '+94 76 555 8901',
        'Keratin Treatment',
        '8 visits',
        'LKR 66,000',
      ),
      (
        'Ruwan Silva',
        '+94 71 222 7788',
        'Beard Trim',
        '5 visits',
        'LKR 13,500',
      ),
      ('Chamari Dias', '+94 70 888 4411', 'Facial', '17 visits', 'LKR 118,000'),
    ];
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
          for (final client in clients)
            ClientListCard(
              name: client.$1,
              phone: client.$2,
              service: client.$3,
              visits: client.$4,
              spent: client.$5,
            ),
        ],
      ),
    );
  }
}

class ClientDetailScreen extends StatelessWidget {
  const ClientDetailScreen({
    super.key,
    required this.name,
    required this.phone,
  });

  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: const Text('Client Detail')),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton.icon(
              onPressed: () => pushScreen(context, const NewBookingScreen()),
              icon: const Icon(Icons.event_available_rounded),
              label: const Text('Book Again'),
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            PremiumCard(
              child: Column(
                children: [
                  CircleAvatar(radius: 42, child: Text(initials(name))),
                  const SizedBox(height: 12),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(phone, style: const TextStyle(color: AppColors.muted)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.chat_rounded),
                          label: const Text('WhatsApp'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.call_rounded),
                          label: const Text('Call'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Row(
              children: [
                Expanded(
                  child: MiniStat(value: '12', label: 'Visits'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: MiniStat(value: 'LKR 92k', label: 'Spent'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: MiniStat(value: 'Apr 18', label: 'Last'),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const TabBar(
              tabs: [
                Tab(text: 'History'),
                Tab(text: 'Upcoming'),
                Tab(text: 'Notes'),
              ],
            ),
            SizedBox(
              height: 280,
              child: TabBarView(
                children: [
                  ListView(
                    padding: const EdgeInsets.only(top: 12),
                    children: const [
                      HistoryCard(
                        date: 'Apr 18',
                        service: 'Hair Color',
                        stylist: 'Maya',
                        amount: 'LKR 8,500',
                      ),
                      HistoryCard(
                        date: 'Mar 22',
                        service: 'Blowout',
                        stylist: 'Dilan',
                        amount: 'LKR 4,500',
                      ),
                    ],
                  ),
                  const Center(child: Text('No upcoming bookings')),
                  const Center(child: Text('Prefers evening appointments.')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
              children: const [
                ServiceCard(
                  name: 'Hair Color + Blowout',
                  duration: '90 min',
                  price: 'LKR 8,500',
                  category: 'Hair',
                ),
                ServiceCard(
                  name: 'Keratin Treatment',
                  duration: '150 min',
                  price: 'LKR 18,000',
                  category: 'Hair',
                ),
                ServiceCard(
                  name: 'Signature Facial',
                  duration: '60 min',
                  price: 'LKR 7,500',
                  category: 'Skin',
                ),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                StaffCard(
                  name: 'Maya Perera',
                  role: 'Senior Stylist',
                  rating: '4.9 · 126 bookings',
                  available: true,
                ),
                StaffCard(
                  name: 'Dilan Jay',
                  role: 'Barber',
                  rating: '4.8 · 88 bookings',
                  available: true,
                ),
                StaffCard(
                  name: 'Ishara Sen',
                  role: 'Skin Therapist',
                  rating: '4.7 · 73 bookings',
                  available: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.ios_share_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          FilterPill(
            icon: Icons.date_range_rounded,
            text: 'This week · Apr 20 - Apr 26',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(
                child: SummaryCard(
                  icon: Icons.payments_rounded,
                  value: 'LKR 186k',
                  label: 'Revenue',
                  color: AppColors.green,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: SummaryCard(
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
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.storefront_rounded, 'Salon profile', 'Name, address, logo'),
      (Icons.access_time_rounded, 'Working hours', 'Open days and breaks'),
      (
        Icons.manage_accounts_rounded,
        'Staff accounts',
        'Roles and permissions',
      ),
      (
        Icons.notifications_active_rounded,
        'Notifications',
        'Reminders and alerts',
      ),
      (Icons.chat_rounded, 'WhatsApp templates', 'Confirmation messages'),
      (Icons.workspace_premium_rounded, 'Subscription', 'Billing placeholder'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          for (final item in items)
            PremiumCard(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleIcon(
                  icon: item.$1,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  item.$2,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                subtitle: Text(item.$3),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
            ),
        ],
      ),
    );
  }
}

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            const Color(0xFFB96DFF),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: .24),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Icon(Icons.spa_rounded, size: size * .48, color: Colors.white),
    );
  }
}

class PremiumCard extends StatelessWidget {
  const PremiumCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.margin,
  });

  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.line),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleIcon(icon: icon, color: color),
          const SizedBox(height: 14),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: AppColors.muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class CircleIcon extends StatelessWidget {
  const CircleIcon({super.key, required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: color),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    required this.action,
    required this.onTap,
  });

  final String title;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
        ),
        TextButton(onPressed: onTap, child: Text(action)),
      ],
    );
  }
}

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.initials,
    required this.client,
    required this.service,
    required this.stylist,
    required this.time,
    required this.status,
    required this.color,
  });

  final String initials;
  final String client;
  final String service;
  final String stylist;
  final String time;
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          CircleAvatar(radius: 24, child: Text(initials)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  '$service · $stylist',
                  style: const TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      time,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(width: 8),
                    StatusChip(label: status, color: color),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class ActionTile extends StatelessWidget {
  const ActionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: PremiumCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleIcon(
              icon: icon,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: AppColors.muted, fontSize: 12),
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(18),
        border: Border(left: BorderSide(color: color, width: 5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(client, style: const TextStyle(fontWeight: FontWeight.w900)),
          const SizedBox(height: 3),
          Text(
            '$service · $stylist',
            style: TextStyle(color: color, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class FormSection extends StatelessWidget {
  const FormSection({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}

class SelectablePill extends StatelessWidget {
  const SelectablePill({super.key, required this.text, required this.selected});

  final String text;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: selected
            ? Theme.of(context).colorScheme.primary
            : const Color(0xFFF8F7FB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : AppColors.line,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : AppColors.ink,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class ReadOnlyField extends StatelessWidget {
  const ReadOnlyField({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F7FB),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: AppColors.muted)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class BookingSummaryRow extends StatelessWidget {
  const BookingSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.strong = false,
  });

  final String label;
  final String value;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: strong ? FontWeight.w900 : FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: strong ? FontWeight.w900 : FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class ClientListCard extends StatelessWidget {
  const ClientListCard({
    super.key,
    required this.name,
    required this.phone,
    required this.service,
    required this.visits,
    required this.spent,
  });

  final String name;
  final String phone;
  final String service;
  final String visits;
  final String spent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () =>
          pushScreen(context, ClientDetailScreen(name: name, phone: phone)),
      child: PremiumCard(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(radius: 25, child: Text(initials(name))),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Text(phone, style: const TextStyle(color: AppColors.muted)),
                  Text(service, style: const TextStyle(color: AppColors.muted)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  visits,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(
                  spent,
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

class MiniStat extends StatelessWidget {
  const MiniStat({super.key, required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: AppColors.muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.date,
    required this.service,
    required this.stylist,
    required this.amount,
  });

  final String date;
  final String service;
  final String stylist;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          service,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        subtitle: Text('$date · $stylist'),
        trailing: Text(
          amount,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.name,
    required this.duration,
    required this.price,
    required this.category,
  });

  final String name;
  final String duration;
  final String price;
  final String category;

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
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w900)),
        subtitle: Text('$duration · $category'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(price, style: const TextStyle(fontWeight: FontWeight.w900)),
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
    required this.name,
    required this.role,
    required this.rating,
    required this.available,
  });

  final String name;
  final String role;
  final String rating;
  final bool available;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(radius: 26, child: Text(initials(name))),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w900)),
        subtitle: Text('$role\n$rating'),
        isThreeLine: true,
        trailing: StatusChip(
          label: available ? 'Available' : 'Off',
          color: available ? AppColors.green : AppColors.red,
        ),
      ),
    );
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
          CircleAvatar(child: Text(initials(name))),
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
      ..color = const Color(0xFF6D5DF6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final fill = Paint()
      ..color = const Color(0xFF6D5DF6).withValues(alpha: .08)
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
      const Color(0xFF6D5DF6),
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

String initials(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.length == 1) {
    return parts.first.substring(0, 1).toUpperCase();
  }
  return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
}

void pushScreen(BuildContext context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
}
