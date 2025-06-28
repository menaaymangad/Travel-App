# Manual Setup Checklist

## 1. Firebase Configuration

- [ ] Create a Firebase project.
- [ ] Add Android and iOS apps to Firebase.
- [ ] Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) and place them in the appropriate directories.
- [ ] Enable Firestore, Authentication, and Storage in the Firebase console.

## 2. API Keys

- [ ] Obtain API keys for:
  - Google Maps
  - Google Places
  - Google ML Kit (if using for landmark recognition)
- [ ] Add API keys to the appropriate configuration files or environment variables.

## 3. Sample Data

- [ ] Add sample data for:
  - Landmarks
  - Hotels
  - Restaurants
  - Music
  - Trip Suggestions
  - City Transportation

## 4. Device Testing

- [ ] Test the app on multiple devices and screen sizes.
- [ ] Test on both Android and iOS if possible.

## 5. Final Steps

- [ ] Run `flutter clean` and `flutter pub get`.
- [ ] Run `flutter analyze` and `flutter test` to ensure code quality.
- [ ] Build release APK/IPA and test on real devices.
