import 'package:flutter/material.dart';

import '../shared/data/mock_data.dart' as mock;
import '../shared/models/booking.dart';
import '../shared/models/client.dart';
import '../shared/models/service.dart';
import '../shared/models/settings_models.dart';
import '../shared/models/staff_member.dart';

class SalonStore extends ChangeNotifier {
  SalonStore()
    : _bookings = List.of(mock.todayBookings),
      _clients = List.of(mock.clients),
      _services = List.of(mock.services),
      _staffMembers = List.of(mock.staffMembers),
      _salonProfile = mock.salonProfile,
      _workingDays = List.of(mock.workingDays),
      _staffAccounts = List.of(mock.staffAccounts),
      _whatsAppTemplates = List.of(mock.whatsappTemplates),
      _subscriptionPlan = mock.subscriptionPlan;

  final List<Booking> _bookings;
  final List<Client> _clients;
  final List<Service> _services;
  final List<StaffMember> _staffMembers;
  SalonProfile _salonProfile;
  final List<WorkingDay> _workingDays;
  final List<StaffAccount> _staffAccounts;
  final List<WhatsAppTemplate> _whatsAppTemplates;
  SubscriptionPlan _subscriptionPlan;

  List<Booking> get bookings => List.unmodifiable(_bookings);
  List<Client> get clients => List.unmodifiable(_clients);
  List<Service> get services => List.unmodifiable(_services);
  List<StaffMember> get staffMembers => List.unmodifiable(_staffMembers);
  SalonProfile get salonProfile => _salonProfile;
  List<WorkingDay> get workingDays => List.unmodifiable(_workingDays);
  List<StaffAccount> get staffAccounts => List.unmodifiable(_staffAccounts);
  List<WhatsAppTemplate> get whatsAppTemplates =>
      List.unmodifiable(_whatsAppTemplates);
  SubscriptionPlan get subscriptionPlan => _subscriptionPlan;

  int get confirmedBookings =>
      _bookings.where((booking) => booking.status == 'Confirmed').length;

  String get totalRevenue {
    final total = _bookings.fold<int>(
      0,
      (sum, booking) => sum + _parseCurrency(booking.price),
    );
    return _formatCurrency(total);
  }

  void addClient(Client client) {
    final existingIndex = _clients.indexWhere(
      (entry) => entry.phone == client.phone || entry.name == client.name,
    );
    if (existingIndex >= 0) {
      _clients[existingIndex] = client;
    } else {
      _clients.insert(0, client);
    }
    notifyListeners();
  }

  void updateClient({
    required String previousPhone,
    required Client client,
  }) {
    final existingIndex = _clients.indexWhere(
      (entry) => entry.phone == previousPhone,
    );
    if (existingIndex < 0) {
      return;
    }

    _clients[existingIndex] = client;
    notifyListeners();
  }

  void addService(Service service) {
    final existingIndex = _services.indexWhere(
      (entry) => entry.name == service.name,
    );
    if (existingIndex >= 0) {
      _services[existingIndex] = service;
    } else {
      _services.insert(0, service);
    }
    notifyListeners();
  }

  void updateService({
    required String previousName,
    required Service service,
  }) {
    final existingIndex = _services.indexWhere(
      (entry) => entry.name == previousName,
    );
    if (existingIndex < 0) {
      return;
    }

    _services[existingIndex] = service;
    notifyListeners();
  }

  void addStaffMember(StaffMember staffMember) {
    final existingIndex = _staffMembers.indexWhere(
      (entry) => entry.name == staffMember.name,
    );
    if (existingIndex >= 0) {
      _staffMembers[existingIndex] = staffMember;
    } else {
      _staffMembers.insert(0, staffMember);
    }
    notifyListeners();
  }

  void updateSalonProfile(SalonProfile profile) {
    _salonProfile = profile;
    notifyListeners();
  }

  void updateWorkingDay({
    required String label,
    required WorkingDay day,
  }) {
    final index = _workingDays.indexWhere((entry) => entry.label == label);
    if (index < 0) {
      return;
    }
    _workingDays[index] = day;
    notifyListeners();
  }

  void addStaffAccount(StaffAccount account) {
    final index = _staffAccounts.indexWhere(
      (entry) => entry.email == account.email || entry.name == account.name,
    );
    if (index >= 0) {
      _staffAccounts[index] = account;
    } else {
      _staffAccounts.insert(0, account);
    }
    notifyListeners();
  }

  void updateStaffAccount({
    required String previousEmail,
    required StaffAccount account,
  }) {
    final index = _staffAccounts.indexWhere(
      (entry) => entry.email == previousEmail,
    );
    if (index < 0) {
      return;
    }
    _staffAccounts[index] = account;
    notifyListeners();
  }

  void addWhatsAppTemplate(WhatsAppTemplate template) {
    final index = _whatsAppTemplates.indexWhere(
      (entry) => entry.title == template.title,
    );
    if (index >= 0) {
      _whatsAppTemplates[index] = template;
    } else {
      _whatsAppTemplates.insert(0, template);
    }
    notifyListeners();
  }

  void updateWhatsAppTemplate({
    required String previousTitle,
    required WhatsAppTemplate template,
  }) {
    final index = _whatsAppTemplates.indexWhere(
      (entry) => entry.title == previousTitle,
    );
    if (index < 0) {
      return;
    }
    _whatsAppTemplates[index] = template;
    notifyListeners();
  }

  void updateSubscriptionPlan(SubscriptionPlan plan) {
    _subscriptionPlan = plan;
    notifyListeners();
  }

  void updateStaffMember({
    required String previousName,
    required StaffMember staffMember,
  }) {
    final existingIndex = _staffMembers.indexWhere(
      (entry) => entry.name == previousName,
    );
    if (existingIndex < 0) {
      return;
    }

    _staffMembers[existingIndex] = staffMember;
    notifyListeners();
  }

  void addBooking({
    required String clientName,
    required String clientPhone,
    required String serviceName,
    required String staffName,
    required String time,
    required String price,
  }) {
    _bookings.insert(
      0,
      Booking(
        clientName: clientName,
        serviceName: serviceName,
        staffName: staffName,
        time: time,
        price: price,
        status: 'Confirmed',
        statusColor: Colors.green,
      ),
    );

    final existingIndex = _clients.indexWhere(
      (client) => client.phone == clientPhone || client.name == clientName,
    );
    if (existingIndex >= 0) {
      final current = _clients[existingIndex];
      _clients[existingIndex] = Client(
        name: current.name,
        phone: clientPhone,
        lastService: serviceName,
        visits: '${_parseVisits(current.visits) + 1} visits',
        totalSpent: _formatCurrency(
          _parseCurrency(current.totalSpent) + _parseCurrency(price),
        ),
      );
    } else {
      _clients.insert(
        0,
        Client(
          name: clientName,
          phone: clientPhone,
          lastService: serviceName,
          visits: '1 visit',
          totalSpent: price,
        ),
      );
    }
    notifyListeners();
  }

  int _parseCurrency(String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(digits) ?? 0;
  }

  int _parseVisits(String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(digits) ?? 0;
  }

  String _formatCurrency(int value) {
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
}

class SalonStoreScope extends InheritedNotifier<SalonStore> {
  const SalonStoreScope({
    super.key,
    required SalonStore store,
    required super.child,
  }) : super(notifier: store);

  static SalonStore of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<SalonStoreScope>();
    assert(scope != null, 'SalonStoreScope not found in context.');
    return scope!.notifier!;
  }
}
