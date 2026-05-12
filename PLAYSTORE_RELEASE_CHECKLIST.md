# Play Store Release Checklist

This checklist captures the remaining work needed to ship `SalonFlow` on Google Play.

## Product and policy
- Set up a public privacy policy URL.
- Complete the Play Console Data safety form to match shipped behavior.
- Decide whether the app is demo-only or production-ready with real backend accounts.
- If real account creation will exist, implement an account deletion flow and a public deletion request URL.

## Android release signing
- Create an upload keystore.
- Copy `android/key.properties.example` to `android/key.properties`.
- Fill in real keystore values.
- Keep `android/key.properties` and the keystore file out of version control.
- Confirm the release build uses the `release` signing config instead of the debug key.

## Store listing
- Prepare app icon, feature graphic, phone screenshots, tablet screenshots, short description, full description, privacy policy URL, support email, and contact website if available.
- Confirm app category and target audience in Play Console.

## App behavior
- Remove misleading fake account or third-party sign-in flows unless they are truly implemented.
- Ensure in-app privacy information is reachable from Settings.
- Review all demo labels and preview messaging before production rollout.

## Validation before upload
- Build a signed release bundle.
- Test install on a clean Android device.
- Verify call and WhatsApp intents behave correctly.
- Verify all settings screens open and save correctly.
- Verify no debug banners, debug signing, or placeholder store text remain.
