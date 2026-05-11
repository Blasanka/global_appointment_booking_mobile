import 'package:flutter/material.dart';

import '../shared/data/mock_data.dart';
import '../shared/models/booking.dart';
import '../shared/models/client.dart';
import '../shared/models/service.dart';
import '../shared/models/staff_member.dart';

class SalonStore extends ChangeNotifier {
  SalonStore()
    : _bookings = List.of(todayBookings),
      _clients = List.of(clients),
      _services = List.of(services),
      _staffMembers = List.of(staffMembers);

  final List<Booking> _bookings;
  final List<Client> _clients;
  final List<Service> _services;
  final List<StaffMember> _staffMembers;

  List<Booking> get bookings => List.unmodifiable(_bookings);
  List<Client> get clients => List.unmodifiable(_clients);
  List<Service> get services => List.unmodifiable(_services);
  List<StaffMember> get staffMembers => List.unmodifiable(_staffMembers);

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
