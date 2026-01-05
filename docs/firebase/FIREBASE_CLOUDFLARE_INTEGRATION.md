# Firebase ↔ Cloudflare Integration Guide

## ✅ Deployment Status

**Last Deployment:** January 3, 2026
**Deployment URL:** https://592229fa.bookstrack-web.pages.dev
**Custom Domain:** https://books.oooefam.net
**Status:** LIVE with Firebase Authentication ✅

---

## 🔗 Integration Architecture

### How Firebase + Cloudflare Work Together

```
┌─────────────────────────────────────────────────────────────┐
│                        User Browser                          │
│                                                               │
│  ┌────────────────────────────────────────────────────┐     │
│  │   Flutter Web App (Static Files)                   │     │
│  │   Served from: Cloudflare Pages                    │     │
│  │   - HTML, CSS, JS, WASM                            │     │
│  │   - Firebase SDK (client-side)                     │     │
│  └────────────────────────────────────────────────────┘     │
│                           ↓                                  │
│  ┌────────────────────────────────────────────────────┐     │
│  │   Firebase Authentication (Client SDK)             │     │
│  │   - Email/Password auth                            │     │
│  │   - Google OAuth popup                             │     │
│  │   - Session management                             │     │
│  └────────────────────────────────────────────────────┘     │
│                           ↓                                  │
└───────────────────────────┼───────────────────────────────────┘
                            ↓
            ┌───────────────────────────────────┐
            │   Firebase Auth Backend           │
            │   - User verification              │
            │   - Token generation               │
            │   - OAuth provider integration     │
            │   - Domain validation              │
            └───────────────────────────────────┘
                            ↓
            ┌───────────────────────────────────┐
            │   Cloudflare Workers API          │
            │   (api.oooefam.net)               │
            │   - Book search                    │
            │   - ISBN lookup                    │
            │   - Gemini AI integration          │
            │   - Requires Firebase auth token   │
            └───────────────────────────────────┘
```

---

## 🔐 Critical Configuration

### 1. Firebase Authorized Domains

**Must be configured in Firebase Console:**
https://console.firebase.google.com/project/flutter-books-857d3/authentication/settings

**Required Domains:**
- ✅ `localhost` (local development)
- ✅ `books.oooefam.net` (custom domain)
- ✅ `bookstrack-web.pages.dev` (Cloudflare Pages default)
- ✅ `*.bookstrack-web.pages.dev` (deployment previews - add wildcard)

**Why:** Firebase validates the origin of auth requests. Without these domains, authentication will fail with CORS errors.

---

### 2. Cloudflare Pages Configuration

**Current Setup:**
- **Project Name:** `bookstrack-web`
- **Production Branch:** `main`
- **Build Command:** `flutter build web --release --target=lib/main_auth.dart`
- **Build Output Directory:** `build/web`
- **Custom Domain:** `books.oooefam.net` (DNS configured)

**Environment Variables:**
- None needed for Firebase (client-side SDK uses `firebase_options.dart`)

---

### 3. Firebase Configuration Files

**Client-Side (Flutter Web):**
- `lib/firebase_options.dart` - Contains Firebase config (gitignored)
- Compiled into web build
- No server-side environment variables needed

**Security Note:**
- Firebase web API keys are **intentionally public**
- Security enforced by:
  - Authorized domains (origin validation)
  - Firebase Auth (user verification)
  - Firestore Security Rules (data access control)

---

## 🚀 Deployment Workflow

### Standard Deployment

```bash
# 1. Build with Firebase auth
flutter build web --release --target=lib/main_auth.dart

# 2. Deploy to Cloudflare Pages
npx wrangler pages deploy build/web --project-name=bookstrack-web

# 3. Deployment will show URL like:
# ✨ Deployment complete! https://[hash].bookstrack-web.pages.dev
```

### Automatic Deployment (Git Push)

If you've set up Cloudflare Pages Git integration:

```bash
# Just push to main branch
git push origin main

# Cloudflare automatically:
# 1. Detects push
# 2. Runs build command
# 3. Deploys to production
# 4. Updates books.oooefam.net
```

---

## 🧪 Testing Authentication

### Test Checklist

**1. Email/Password Sign Up**
```
Visit: https://books.oooefam.net
1. Click "Sign up with email"
2. Enter email/password
3. Verify account creation
4. Check Firebase Console for new user
```

**2. Email/Password Sign In**
```
1. Sign out if signed in
2. Click "Sign in with email"
3. Enter credentials
4. Verify successful login
5. Check session persistence (refresh page)
```

**3. Google OAuth Sign-In**
```
1. Sign out if signed in
2. Click "Sign in with Google"
3. Google popup should appear
4. Select Google account
5. Verify redirect back to app
6. Check Firebase Console for new user
```

**4. Session Persistence**
```
1. Sign in with any method
2. Refresh page
3. Verify still signed in (no auth screen)
4. Close tab, reopen
5. Verify still signed in
```

**5. Sign Out**
```
1. While signed in, click sign out
2. Verify redirect to auth screen
3. Verify cannot access protected routes
4. Verify can sign in again
```

---

## 🔧 Cloudflare Workers API Integration

### Backend API Authentication

Your Cloudflare Workers backend (`api.oooefam.net`) can verify Firebase auth tokens:

**1. Install Firebase Admin SDK (Workers):**
```typescript
// In your Cloudflare Workers project
import { initializeApp, cert } from 'firebase-admin/app';
import { getAuth } from 'firebase-admin/auth';

// Initialize Firebase Admin
const app = initializeApp({
  credential: cert({
    projectId: 'flutter-books-857d3',
    // Add service account credentials as Cloudflare secrets
  })
});
```

**2. Verify Auth Tokens in API Endpoints:**
```typescript
export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    // Get token from Authorization header
    const authHeader = request.headers.get('Authorization');
    if (!authHeader?.startsWith('Bearer ')) {
      return new Response('Unauthorized', { status: 401 });
    }

    const token = authHeader.substring(7);

    try {
      // Verify the token with Firebase Admin SDK
      const decodedToken = await getAuth().verifyIdToken(token);
      const userId = decodedToken.uid;

      // User is authenticated, proceed with API logic
      // You now have access to userId, email, etc.

      return new Response(JSON.stringify({
        message: 'Authenticated request',
        userId: userId
      }));
    } catch (error) {
      return new Response('Invalid token', { status: 401 });
    }
  }
};
```

**3. Flutter App Sends Auth Token:**
```dart
// In your Flutter app API calls
final user = FirebaseAuth.instance.currentUser;
if (user != null) {
  final token = await user.getIdToken();

  final response = await dio.get(
    'https://api.oooefam.net/v1/search/title',
    options: Options(
      headers: {
        'Authorization': 'Bearer $token',
      },
    ),
  );
}
```

---

## 🔒 Security Best Practices

### Firebase Security Rules

**Firestore (when you add it):**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Only authenticated users can read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }

    // Public read, authenticated write for books
    match /books/{bookId} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

**Storage (when you add it):**
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /users/{userId}/{allPaths=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

---

## 🆘 Troubleshooting

### "Auth domain not authorized" Error

**Symptom:** Google sign-in popup shows error about unauthorized domain

**Solution:**
1. Go to Firebase Console → Authentication → Settings → Authorized domains
2. Add your Cloudflare domain(s)
3. Wait 5 minutes for DNS propagation
4. Clear browser cache
5. Try again

### "CORS Error" on Authentication

**Symptom:** Browser console shows CORS error during auth

**Solution:**
1. Verify `authDomain` in `firebase_options.dart` is `flutter-books-857d3.firebaseapp.com`
2. Ensure domain is in Firebase authorized domains list
3. Check that you're accessing via HTTPS (not HTTP)

### Google Sign-In Popup Blocked

**Symptom:** Popup doesn't appear, browser shows "popup blocked" notification

**Solution:**
1. Allow popups for your domain in browser settings
2. Or use redirect-based flow instead of popup:
```dart
// In your auth code, replace signInWithPopup with:
await FirebaseAuth.instance.signInWithRedirect(GoogleAuthProvider());
```

### Authentication Works Locally But Not on Cloudflare

**Symptom:** Auth works on `localhost` but fails on production domain

**Solution:**
1. Verify production domain is in Firebase authorized domains
2. Check browser console for specific error
3. Ensure `firebase_options.dart` was included in build
4. Verify Firebase initialization in `main_auth.dart`

---

## 📊 Monitoring & Analytics

### Firebase Console Dashboards

**Authentication:**
- https://console.firebase.google.com/project/flutter-books-857d3/authentication/users
- Monitor user signups, sign-ins, active users

**Usage:**
- https://console.firebase.google.com/project/flutter-books-857d3/usage
- Track API calls, bandwidth, storage

### Cloudflare Analytics

**Pages Analytics:**
- https://dash.cloudflare.com/pages
- Monitor deployments, traffic, errors

**Workers Analytics:**
- https://dash.cloudflare.com/workers
- Monitor API endpoint performance

---

## 🔄 Future Enhancements

### 1. Add Firestore Database
- User library storage in cloud
- Cross-device sync
- Real-time updates

### 2. Add Firebase Storage
- Book cover uploads
- Scan image storage
- User profile pictures

### 3. Add Firebase Analytics
- Track user behavior
- Monitor feature usage
- A/B testing

### 4. Add Firebase Cloud Messaging
- Push notifications
- Reading reminders
- New feature announcements

### 5. Add Firebase Performance Monitoring
- Track load times
- Monitor network requests
- Identify bottlenecks

---

## ✅ Production Checklist

Before going live:

- [x] Firebase project configured
- [x] Email/Password auth enabled
- [x] Google OAuth enabled
- [x] Authorized domains configured
- [x] Web app built with Firebase
- [x] Deployed to Cloudflare Pages
- [x] Custom domain working (books.oooefam.net)
- [ ] **Test signup on production URL**
- [ ] **Test Google sign-in on production URL**
- [ ] **Verify session persistence**
- [ ] **Test sign out flow**
- [ ] Add Firestore security rules (when implemented)
- [ ] Add Firebase Analytics (optional)
- [ ] Set up error monitoring (Crashlytics/Sentry)

---

## 📚 Resources

**Firebase:**
- [Firebase Console](https://console.firebase.google.com/project/flutter-books-857d3)
- [Firebase Auth Documentation](https://firebase.google.com/docs/auth)
- [FlutterFire Documentation](https://firebase.flutter.dev/)

**Cloudflare:**
- [Cloudflare Pages Dashboard](https://dash.cloudflare.com/pages)
- [Wrangler CLI Documentation](https://developers.cloudflare.com/workers/wrangler/)
- [Pages Functions](https://developers.cloudflare.com/pages/functions/)

**Integration:**
- [Firebase Admin SDK for Workers](https://github.com/cloudflare/workers-sdk/tree/main/templates/experimental/worker-firebase-admin)
- [Cloudflare Workers + Firebase](https://developers.cloudflare.com/workers/tutorials/authorize-users-with-firebase/)

---

**Last Updated:** January 3, 2026
**Status:** ✅ Production deployment complete with Firebase Authentication
**Next:** Test authentication flows on https://books.oooefam.net
