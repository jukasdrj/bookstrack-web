# Firebase Authentication Setup Guide

## Current Status

⚠️ **Firebase Auth Temporarily Disabled** - Package compatibility issues

The BooksTrack web app has Firebase authentication code ready (`lib/main_auth.dart`) but cannot be deployed yet due to package compatibility issues between `firebase_auth_web: 5.8.13` and Flutter SDK 3.38.5.

This will be resolved by upgrading to newer Flutter/Firebase package versions.

---

## Quick Setup (When Ready)

### 1. Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create or select project
3. Enable Email/Password and Google authentication

### 2. Get Firebase Config
Copy your Firebase web configuration from Project Settings → Your apps → Web app

### 3. Update `lib/firebase_options.dart`
Replace demo values with your actual Firebase configuration

### 4. Enable Authorized Domains
Add these domains in Firebase Console → Authentication → Settings:
- `localhost`
- `books.oooefam.net`
- `bookstrack-web.pages.dev`

### 5. Upgrade Packages
```bash
flutter pub upgrade
flutter pub get
```

### 6. Build and Deploy
```bash
flutter build web --release --target=lib/main_auth.dart
npx wrangler pages deploy build/web --project-name=bookstrack-web
```

---

## Firebase Features Included

✅ Email/Password sign up and sign in
✅ Google OAuth sign-in (popup flow)
✅ Session management and persistence
✅ Protected routes with auth gate
✅ Sign out functionality
✅ Error handling and loading states

See `lib/main_auth.dart` for complete implementation.

---

## Resources

- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)
- [Firebase Auth for Web](https://firebase.google.com/docs/auth/web/start)

---

**Status:** Code complete, pending package compatibility
**Last Updated:** January 3, 2026
