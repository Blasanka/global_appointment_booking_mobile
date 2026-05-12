class SalonProfile {
  const SalonProfile({
    required this.name,
    required this.address,
    required this.phone,
    required this.tagline,
  });

  final String name;
  final String address;
  final String phone;
  final String tagline;
}

class WorkingDay {
  const WorkingDay({
    required this.label,
    required this.enabled,
    required this.openTime,
    required this.closeTime,
    required this.breakLabel,
  });

  final String label;
  final bool enabled;
  final String openTime;
  final String closeTime;
  final String breakLabel;
}

class StaffAccount {
  const StaffAccount({
    required this.name,
    required this.role,
    required this.permissionLabel,
    required this.email,
    required this.active,
  });

  final String name;
  final String role;
  final String permissionLabel;
  final String email;
  final bool active;
}

class WhatsAppTemplate {
  const WhatsAppTemplate({
    required this.title,
    required this.category,
    required this.message,
    required this.enabled,
  });

  final String title;
  final String category;
  final String message;
  final bool enabled;
}

class SubscriptionPlan {
  const SubscriptionPlan({
    required this.planName,
    required this.priceLabel,
    required this.billingCycle,
    required this.renewalDate,
    required this.status,
    required this.seatsUsed,
    required this.seatLimit,
  });

  final String planName;
  final String priceLabel;
  final String billingCycle;
  final String renewalDate;
  final String status;
  final int seatsUsed;
  final int seatLimit;
}
