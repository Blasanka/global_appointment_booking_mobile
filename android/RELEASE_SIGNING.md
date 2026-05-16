Android release signing is wired in `app/build.gradle.kts` and reads values from `android/key.properties`.

Required local files:
- `android/key.properties`
- `upload-keystore.jks` at the repo root

`android/key.properties` should contain:

```properties
storePassword=replace-with-keystore-password
keyPassword=replace-with-key-password
keyAlias=upload
storeFile=../upload-keystore.jks
```

Run the keystore command from the repo root so the generated file lands at `./upload-keystore.jks`:

```powershell
keytool -genkeypair -v `
  -keystore upload-keystore.jks `
  -storetype JKS `
  -keyalg RSA `
  -keysize 2048 `
  -validity 10000 `
  -alias upload
```

After `keytool` prompts complete, update `android/key.properties` with the real `storePassword` and `keyPassword` values you entered.

Create the Play Store bundle with:

```powershell
flutter build appbundle --release
```
