import 'package:appointment_booking_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows SalonFlow splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SalonFlowApp());

    expect(find.text('SalonFlow'), findsOneWidget);
    expect(
      find.text('Bookings, staff, and clients in one place'),
      findsOneWidget,
    );
    expect(find.text('Continue'), findsOneWidget);
  });
}
