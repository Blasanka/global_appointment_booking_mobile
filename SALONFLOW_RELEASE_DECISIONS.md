# SalonFlow Release Decisions

This file records current release-facing decisions for SalonFlow so future app updates can be checked against the exact position used for store submission.

## Current Play Store Data Safety decision

For the current internal testing / release position:

- `No data collection declared`
- `No data shared with third parties`

## Basis for this decision

This decision is based on the current app position being treated as:

- local-only app behavior
- no backend or cloud sync in the shipped release position
- no analytics SDK
- no crash-reporting SDK that collects user data
- no remote account/auth system transmitting user records
- no third-party service receiving stored salon or client records from the app

## What data exists inside the app

The app can contain user-entered operational data such as:

- salon profile information
- client names
- client phone numbers
- bookings and booking history
- staff information
- services and pricing
- report-related operational records

For the current release position, this data is treated as local app data and not as off-device collected data.

## External actions

The app may trigger user-requested external actions such as:

- phone calls
- WhatsApp launch actions
- web links

For the current release position, these actions do not by themselves change the Data Safety declaration, as long as the app itself is not transmitting stored records to external systems.

## Future change rule

This decision must be reviewed before any release that adds:

- backend APIs
- hosted database sync
- cloud backup or restore
- analytics SDKs
- crash-reporting SDKs
- remote authentication or account systems
- external customer support or messaging systems that receive app data

If any of those are added, update:

1. Play Console Data Safety answers
2. public privacy policy
3. in-app privacy wording
4. release documentation

## Copy-paste summary

```text
SalonFlow currently operates as a local-only app experience for its present release position. The app does not collect user data off-device and does not share user data with third parties. User-entered salon and client information is used only within the app's local workflow for bookings, client management, staff management, services, and reports. If future releases add backend services, cloud sync, analytics, crash reporting, or external account systems, the Play Store Data safety declaration and privacy policy will be updated to match the production behavior.
```
