import '../../app/theme.dart';
import '../models/booking.dart';
import '../models/client.dart';
import '../models/service.dart';
import '../models/settings_models.dart';
import '../models/staff_member.dart';

const todayBookings = [
  Booking(
    clientName: 'Anjali Kumar',
    serviceName: 'Hair Color + Blowout',
    staffName: 'Maya Perera',
    time: '10:30 AM',
    price: 'LKR 8,500',
    status: 'Confirmed',
    statusColor: AppColors.green,
  ),
  Booking(
    clientName: 'Ruwan Silva',
    serviceName: 'Beard Trim',
    staffName: 'Dilan',
    time: '12:00 PM',
    price: 'LKR 3,500',
    status: 'In Progress',
    statusColor: AppColors.amber,
  ),
  Booking(
    clientName: 'Fathima Meer',
    serviceName: 'Keratin Treatment',
    staffName: 'Maya Perera',
    time: '03:15 PM',
    price: 'LKR 18,000',
    status: 'Completed',
    statusColor: AppColors.blue,
  ),
];

const clients = [
  Client(
    name: 'Anjali Kumar',
    phone: '+94 77 123 4567',
    lastService: 'Hair Color',
    visits: '12 visits',
    totalSpent: 'LKR 92,500',
  ),
  Client(
    name: 'Fathima Meer',
    phone: '+94 76 555 8901',
    lastService: 'Keratin Treatment',
    visits: '8 visits',
    totalSpent: 'LKR 66,000',
  ),
  Client(
    name: 'Ruwan Silva',
    phone: '+94 71 222 7788',
    lastService: 'Beard Trim',
    visits: '5 visits',
    totalSpent: 'LKR 13,500',
  ),
  Client(
    name: 'Chamari Dias',
    phone: '+94 70 888 4411',
    lastService: 'Facial',
    visits: '17 visits',
    totalSpent: 'LKR 118,000',
  ),
];

const services = [
  Service(
    name: 'Hair Color + Blowout',
    duration: '90 min',
    price: 'LKR 8,500',
    category: 'Hair',
  ),
  Service(
    name: 'Keratin Treatment',
    duration: '150 min',
    price: 'LKR 18,000',
    category: 'Hair',
  ),
  Service(
    name: 'Signature Facial',
    duration: '60 min',
    price: 'LKR 7,500',
    category: 'Skin',
  ),
];

const staffMembers = [
  StaffMember(
    name: 'Maya Perera',
    role: 'Senior Stylist',
    rating: '4.9 · 126 bookings',
    available: true,
  ),
  StaffMember(
    name: 'Dilan Jay',
    role: 'Barber',
    rating: '4.8 · 88 bookings',
    available: true,
  ),
  StaffMember(
    name: 'Ishara Sen',
    role: 'Skin Therapist',
    rating: '4.7 · 73 bookings',
    available: false,
  ),
];

const timeSlots = ['9:00', '10:30', '12:00', '2:15', '3:30', '5:00'];
const calendarDates = ['Tue\n12', 'Wed\n13', 'Thu\n14', 'Fri\n15', 'Sat\n16'];

const salonProfile = SalonProfile(
  name: 'Glow & Grace Salon',
  address: '14 Flower Road, Colombo 07',
  phone: '+94 11 245 7788',
  tagline: 'Modern salon care for hair, skin, and bridal styling.',
);

const workingDays = [
  WorkingDay(
    label: 'Monday',
    enabled: true,
    openTime: '9:00 AM',
    closeTime: '6:00 PM',
    breakLabel: '1:00 PM - 2:00 PM',
  ),
  WorkingDay(
    label: 'Tuesday',
    enabled: true,
    openTime: '9:00 AM',
    closeTime: '6:00 PM',
    breakLabel: '1:00 PM - 2:00 PM',
  ),
  WorkingDay(
    label: 'Wednesday',
    enabled: true,
    openTime: '9:00 AM',
    closeTime: '7:00 PM',
    breakLabel: '1:00 PM - 2:00 PM',
  ),
  WorkingDay(
    label: 'Thursday',
    enabled: true,
    openTime: '9:00 AM',
    closeTime: '7:00 PM',
    breakLabel: '1:00 PM - 2:00 PM',
  ),
  WorkingDay(
    label: 'Friday',
    enabled: true,
    openTime: '9:00 AM',
    closeTime: '7:30 PM',
    breakLabel: '1:30 PM - 2:15 PM',
  ),
  WorkingDay(
    label: 'Saturday',
    enabled: true,
    openTime: '10:00 AM',
    closeTime: '8:00 PM',
    breakLabel: '2:00 PM - 3:00 PM',
  ),
  WorkingDay(
    label: 'Sunday',
    enabled: false,
    openTime: 'Closed',
    closeTime: 'Closed',
    breakLabel: 'Closed',
  ),
];

const staffAccounts = [
  StaffAccount(
    name: 'Maya Perera',
    role: 'Senior Stylist',
    permissionLabel: 'Manager access',
    email: 'maya@glowgrace.app',
    active: true,
  ),
  StaffAccount(
    name: 'Dilan Jay',
    role: 'Barber',
    permissionLabel: 'Staff access',
    email: 'dilan@glowgrace.app',
    active: true,
  ),
  StaffAccount(
    name: 'Ishara Sen',
    role: 'Skin Therapist',
    permissionLabel: 'Limited access',
    email: 'ishara@glowgrace.app',
    active: false,
  ),
];

const whatsappTemplates = [
  WhatsAppTemplate(
    title: 'Booking Confirmation',
    category: 'Confirmation',
    message: 'Hi {client}, your appointment for {service} is confirmed for {time}.',
    enabled: true,
  ),
  WhatsAppTemplate(
    title: 'Appointment Reminder',
    category: 'Reminder',
    message: 'Friendly reminder: your appointment starts at {time} with {staff}.',
    enabled: true,
  ),
  WhatsAppTemplate(
    title: 'Follow-up Message',
    category: 'Aftercare',
    message: 'Thank you for visiting us today. Reply here if you need aftercare support.',
    enabled: false,
  ),
];

const subscriptionPlan = SubscriptionPlan(
  planName: 'SalonFlow Pro',
  priceLabel: 'LKR 18,500',
  billingCycle: 'Monthly billing',
  renewalDate: 'Renews on May 28',
  status: 'Active',
  seatsUsed: 3,
  seatLimit: 5,
);
