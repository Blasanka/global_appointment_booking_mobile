Android release signing is wired in `app/build.gradle.kts` and reads values from `android/key.properties`.

Files:
- `android/key.properties`
- `upload-keystore.jks` at the repo root

Current `key.properties` template:

```properties
storePassword=replace-with-keystore-password
keyPassword=replace-with-key-password
keyAlias=upload
storeFile=../upload-keystore.jks
```

Generate the upload keystore locally with `keytool`:

```powershell
keytool -genkeypair -v `
  -keystore upload-keystore.jks `
  -storetype JKS `
  -keyalg RSA `
  -keysize 2048 `
  -validity 10000 `
  -alias upload
```

Then replace the placeholder values in `android/key.properties` with the real passwords.

Build the Play Store bundle:

```powershell
flutter build appbundle --release
```
