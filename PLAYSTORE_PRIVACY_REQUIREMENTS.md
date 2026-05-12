# Play Store Privacy Requirements

This document summarizes the Google Play privacy-related requirements most relevant to this app before production release.

## Scope

This app currently includes:
- sign-in UI
- local preview access messaging in the login screen
- staff account management screens
- client names and phone numbers
- bookings, service history, staff data, and operational business data

Because of those features, the app should be treated as handling user and business data that requires Play Store privacy disclosures.

## Minimum Play Store requirements

### 1. Privacy policy is required

Google Play requires:
- a privacy policy link in Play Console
- a privacy policy link or privacy policy text inside the app
- a public, active, non-geofenced URL
- the page must not be a PDF

The privacy policy should clearly state:
- app name and/or developer entity name
- contact method for privacy questions
- what data is collected, accessed, used, and shared
- whether data is shared with any third parties
- security practices at a high level
- retention policy
- deletion policy

### 2. Data safety form is required

The Play Console Data safety form must be completed even if the app does not send data to a backend.

Before filling the form, confirm:
- what data is collected
- whether it stays only on device or is transmitted elsewhere
- whether analytics, crash reporting, login, cloud sync, or messaging SDKs are added
- whether data is shared with service providers or third parties

### 3. Data deletion questions may apply

If the app allows users to create an app account, Google Play also requires:
- an in-app path to request account deletion
- an external web link where users can request deletion
- deletion of account-associated data when requested, except where retention is legally required

## What is more relevant here: data deletion or data collection?

### Short answer

For this codebase today:
- `Data collection disclosure` is definitely relevant.
- `Data deletion` is also likely relevant if you keep the current account-style login/create-account experience in the production app.

### Practical priority

Priority order should be:
1. privacy policy
2. Data safety form
3. account deletion flow, if account creation remains in scope

## App-specific assessment

### Data collection relevance

This app visibly handles:
- owner/staff email and password fields
- client names
- client phone numbers
- appointment history
- staff records
- business profile details

Even if the current build stores this only locally, you still need:
- a privacy policy
- an accurate Data safety declaration based on actual shipped behavior

### Data deletion relevance

This app currently has a local preview login experience in:
- `lib/features/auth/login_screen.dart`

If the release app later adds any real account creation flow, then you should assume Play’s account deletion requirement applies.

If the release app is only:
- local demo data
- no real account registration
- no server-side identity

then account deletion may be less central, but the UI should not misleadingly imply supported account creation unless you are ready to comply.

## Recommended actions before Play submission

### Required before submission
- publish a public privacy policy URL
- add a Privacy Policy entry inside the app settings
- complete the Play Console Data safety form
- decide whether the app truly supports account creation

### If account creation stays
- add a Settings or Account screen with `Delete account`
- define what data is deleted
- create a public web page or support form for deletion requests
- describe retention exceptions in the privacy policy

### If account creation does not stay
- remove or rename misleading auth actions such as `Create account`
- avoid implying cloud identity features that are not actually supported
- make the privacy policy focus on collected/stored operational data instead

## Privacy policy sections to include for this app

Recommended sections:
- Introduction
- Data We Collect
- How We Use Data
- Whether We Share Data
- Data Storage and Security
- Data Retention
- Data Deletion Requests
- Children’s Privacy
- Contact Information
- Changes to This Policy

## Data likely needing disclosure

Based on the current codebase, likely disclosure candidates include:
- email address
- phone number
- name
- user IDs or account identifiers if real auth is added
- app activity related to bookings and client management
- customer data entered by business users

## App implementation note

The current repo does not yet implement:
- a public privacy policy URL
- an in-app privacy policy screen or link
- an account deletion flow
- a web deletion request endpoint

These should be added before a production Play submission if the app is intended for public release.

## Source references

Google Play official sources used for this summary:
- User Data policy: https://support.google.com/googleplay/android-developer/answer/9888076
- Data safety form guidance: https://support.google.com/googleplay/android-developer/answer/10787469
- Account deletion requirements: https://support.google.com/googleplay/android-developer/answer/13327111
- Developer Program Policy overview: https://support.google.com/googleplay/android-developer/answer/16329168
