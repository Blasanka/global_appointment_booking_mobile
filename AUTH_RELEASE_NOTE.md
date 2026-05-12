# Auth Release Note

## Current release posture

For the current app build, authentication is intentionally limited to a single shared preview credential:

- Email: `owner@salonflow.app`
- Password: `salonflow123`

The login screen accepts only this preview owner account. Any other credentials are rejected.

## Hidden / deferred auth features

The following auth-related features are intentionally not exposed in the current release flow:

- Google sign-in
- Forgot password
- In-app account creation

These are being reserved for future implementation once the production backend and privacy/compliance flows are ready.

## Future implementation note

Planned direction:
- account creation may be introduced through a web portal first, or later via in-app onboarding
- password recovery should only be enabled when real identity management is implemented
- Google sign-in should only be enabled when the app supports production account linking and the Play listing/privacy disclosures are updated accordingly

## Reason

This approach keeps the app review flow simple for the current build while avoiding misleading production-ready auth claims that are not yet backed by a full account system.
