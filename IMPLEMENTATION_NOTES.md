# Implementation Notes

This file tracks feature work that has been implemented in the app so the current behavior is easy to review before further changes.

## Recent UI and feature work

### Calendar
- Month left and right navigation now updates real month state instead of only changing the visible label.
- Day chips are generated from the active month and stay in sync with month navigation.
- Day, week, and month views now derive their summaries from the selected date.
- File: `lib/features/bookings/calendar_screen.dart`

### Dashboard
- `View All` now opens a dedicated appointments screen.
- The appointments screen includes search plus staff and status filters.
- Notification bell now routes to a notification screen instead of showing a snackbar.
- Quick action cards now use a wider two-by-two layout on larger screens.
- Dashboard salon name now comes from settings state instead of a hardcoded label.
- Files:
  - `lib/features/dashboard/dashboard_screen.dart`
  - `lib/features/dashboard/all_appointments_screen.dart`

### Notifications
- Added a notification list screen with filter chips and mark-all-read behavior.
- Settings also routes to the same notification screen.
- File: `lib/features/notifications/notifications_screen.dart`

### Client detail actions
- Client detail now supports real WhatsApp and call actions through `url_launcher`.
- WhatsApp message text uses the salon name from settings state.
- Files:
  - `lib/features/clients/client_detail_screen.dart`
  - `pubspec.yaml`

### Reports
- Added range-aware reporting with presets for today, this week, this month, and custom range selection.
- Weekly revenue now renders from derived report data.
- Top services now show ranked entries with booking counts and revenue.
- Most active staff is also derived from the selected reporting range.
- File: `lib/features/reports/reports_screen.dart`

### Settings foundation
- Added persistent app-side settings state to `SalonStore`.
- Added settings models and mock default values for:
  - salon profile
  - working hours
  - staff accounts
  - WhatsApp templates
  - subscription
- Files:
  - `lib/app/salon_store.dart`
  - `lib/shared/models/settings_models.dart`
  - `lib/shared/data/mock_data.dart`

## Settings screens implemented

Settings are implemented in the same order they appear in the Settings tab.

### 1. Salon profile
- Dedicated screen to view salon details.
- Bottom sheet editor for name, address, phone, and tagline.
- File: `lib/features/settings/salon_profile_screen.dart`

### 2. Working hours
- Dedicated screen listing all weekdays.
- Per-day editor for open status, open time, close time, and break window.
- File: `lib/features/settings/working_hours_screen.dart`

### 3. Staff accounts
- Dedicated screen for staff access management.
- Supports adding and editing account name, role, email, permission level, and active state.
- File: `lib/features/settings/staff_accounts_screen.dart`

### 4. Notifications
- Dedicated notifications view already implemented and linked from Settings.
- File: `lib/features/notifications/notifications_screen.dart`

### 5. WhatsApp templates
- Dedicated screen for template listing.
- Supports adding and editing template name, category, message body, and enabled state.
- File: `lib/features/settings/whatsapp_templates_screen.dart`

### 6. Subscription
- Dedicated subscription overview screen.
- Supports editing plan metadata and seat limits.
- File: `lib/features/settings/subscription_screen.dart`

### Shared settings editors
- Settings edit sheets are centralized in:
  - `lib/features/settings/settings_editor_sheets.dart`

## Environment notes
- Do not rely on `dart` or `flutter` commands in this environment.
- Verification for the changes above has been manual source review only.
