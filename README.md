# SalonFlow

SalonFlow is a Flutter salon management app for bookings, clients, services, staff, reports, and settings.

## Project Notes

- Android package name: `com.astramind.edgesolutions.salonflow`
- Release SDK configuration is defined in `android/app/build.gradle.kts`
- Launcher and splash assets have been updated for Android, iOS, macOS, Windows, and web

## Android Release Signing

Android release signing is configured to read from `android/key.properties`.

Required local files:

- `android/key.properties`
- `upload-keystore.jks` in the repo root

Template:

```properties
storePassword=replace-with-keystore-password
keyPassword=replace-with-key-password
keyAlias=upload
storeFile=../upload-keystore.jks
```

Detailed instructions are in [android/RELEASE_SIGNING.md](android/RELEASE_SIGNING.md).

## Release Build

Build the Play Store bundle with:

```powershell
flutter build appbundle --release
```
