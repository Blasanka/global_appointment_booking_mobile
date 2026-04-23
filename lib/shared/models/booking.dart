import 'package:flutter/material.dart';

class Booking {
  const Booking({
    required this.clientName,
    required this.serviceName,
    required this.staffName,
    required this.time,
    required this.status,
    required this.statusColor,
  });

  final String clientName;
  final String serviceName;
  final String staffName;
  final String time;
  final String status;
  final Color statusColor;
}
