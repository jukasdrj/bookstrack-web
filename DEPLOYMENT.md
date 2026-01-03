# BooksTrack Web - Deployment Guide

## Current Deployment Status

✅ **Successfully Deployed** (January 2, 2026)

### Live URLs
- **Cloudflare Pages (default):** https://bookstrack-web.pages.dev
- **Current deployment:** https://ca2dc966.bookstrack-web.pages.dev
- **Custom domain (pending):** https://books.oooefam.net

### Backend API
- **Production API:** https://api.oooefam.net
- **CORS Configuration:** ✅ Updated with all domains
- **Worker Version:** aec54707-979a-4474-9124-32b90ecc0ed0

---

## Cloudflare Configuration

### Account Details
- **Account ID:** `d03bed0be6d976acd8a1707b55052f79`
- **Email:** Jukasdrj@gmail.com
- **Zone:** oooefam.net

### Pages Project
- **Project Name:** bookstrack-web
- **Production Branch:** main
- **Build Command:** `flutter build web --release --target=lib/main_minimal.dart`
- **Build Output:** `build/web`
- **Framework:** Flutter

---

## Custom Domain Setup

### Step-by-Step Instructions

#### 1. Access Cloudflare Pages Dashboard
```
https://dash.cloudflare.com/d03bed0be6d976acd8a1707b55052f79/pages/view/bookstrack-web/domains
```

#### 2. Add Custom Domain
1. Click "Set up a custom domain"
2. Enter: `books.oooefam.net`
3. Click "Continue"
4. Cloudflare will automatically:
   - Create DNS CNAME record pointing to `bookstrack-web.pages.dev`
   - Issue SSL/TLS certificate
   - Enable the domain (usually takes 2-5 minutes)

#### 3. Verify DNS Configuration
After setup, verify the CNAME record:
```bash
dig books.oooefam.net CNAME +short
# Should return: bookstrack-web.pages.dev
```

#### 4. Test SSL Certificate
```bash
curl -I https://books.oooefam.net
# Should return: HTTP/2 200
```

### Alternative Domain Names (if books.oooefam.net is not available)
- `read.oooefam.net`
- `web.oooefam.net`
- `app.oooefam.net`
- `bookstrack.oooefam.net`

---

## CORS Configuration

The bendv3 API has been pre-configured with CORS support for all deployment URLs:

```typescript
const allowedOrigins = [
  'https://bookstrack.oooefam.net',  // iOS app
  'https://harvest.oooefam.net',     // Internal tool
  'https://books.oooefam.net',       // Custom domain ← NEW
  'https://bookstrack-web.pages.dev', // Pages default
  'https://ca2dc966.bookstrack-web.pages.dev', // Deployment preview
  'capacitor://localhost',           // Mobile development
  'http://localhost:3000',           // Local development
  'http://localhost:8787',           // Wrangler dev
]
```

**Status:** ✅ Deployed to production

---

## Build Configuration

### Current Build Setup

The app uses a **minimal Flutter web build** to avoid package compatibility issues:

- **Entry Point:** `lib/main_minimal.dart`
- **Package:** Minimal `pubspec.yaml` (Material 3 + Flutter SDK only)
- **Full Dependencies:** Saved as `pubspec.yaml.full` for future reference

### Build Commands

```bash
# Clean build
flutter clean
flutter pub get

# Web build (minimal - current deployment)
flutter build web --release --target=lib/main_minimal.dart --no-wasm-dry-run

# Full app build (future - requires fixing dependencies)
mv pubspec.yaml.full pubspec.yaml
flutter pub get
flutter build web --release
```

### Deploy to Cloudflare Pages

```bash
# Deploy current build/web directory
npx wrangler pages deploy build/web --project-name=bookstrack-web

# Or deploy with automatic build
npx wrangler pages deploy . --project-name=bookstrack-web \
  --build-command="flutter build web --release --target=lib/main_minimal.dart" \
  --build-output-directory="build/web"
```

---

## Future Enhancements

### Phase 1: Add Firebase (Pending)
- [ ] Configure Firebase project for web
- [ ] Add Firebase config to Pages environment variables
- [ ] Update to `lib/main_simple.dart` (includes Firebase)
- [ ] Test authentication flow

### Phase 2: Full App Features (Pending)
- [ ] Fix package compatibility issues (image_cropper, mobile_scanner)
- [ ] Restore full `pubspec.yaml` dependencies
- [ ] Migrate to `lib/main.dart` (full app)
- [ ] Add search functionality
- [ ] Add library management
- [ ] Integrate with bendv3 API

### Phase 3: CI/CD Pipeline (Optional)
- [ ] GitHub Actions workflow for automatic deployments
- [ ] Preview deployments for pull requests
- [ ] Automated testing before deployment

---

## Environment Variables

### Firebase Configuration (When Ready)

Add these to Cloudflare Pages > Settings > Environment Variables:

```bash
FIREBASE_API_KEY=your_api_key
FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_STORAGE_BUCKET=your_project.appspot.com
FIREBASE_MESSAGING_SENDER_ID=your_sender_id
FIREBASE_APP_ID=your_app_id
FIREBASE_MEASUREMENT_ID=your_measurement_id
```

### Build-time Variables

```bash
# Set in Pages > Settings > Builds and deployments > Build configurations
FLUTTER_VERSION=3.38.5
BUILD_TARGET=lib/main_minimal.dart
```

---

## Troubleshooting

### Build Failures

**Issue:** Package compatibility errors (image_cropper, mobile_scanner)
**Solution:** Use minimal `pubspec.yaml` and `lib/main_minimal.dart`

**Issue:** Wasm dry run failures
**Solution:** Add `--no-wasm-dry-run` flag to build command

### CORS Errors

**Issue:** "CORS policy: No 'Access-Control-Allow-Origin' header"
**Solution:** Verify domain is in bendv3 `allowedOrigins` array and redeployed

### Custom Domain Not Working

**Issue:** Custom domain shows "Not found"
**Solution:**
1. Check DNS propagation: `dig books.oooefam.net`
2. Verify CNAME points to `bookstrack-web.pages.dev`
3. Check SSL certificate status in Cloudflare dashboard
4. Wait 2-5 minutes for propagation

---

## Deployment History

| Date | Version | Changes | Deployed By |
|------|---------|---------|-------------|
| 2026-01-02 | Initial | Minimal Flutter web app deployed | Claude Sonnet 4.5 |
| 2026-01-02 | v1.0.1 | Added books.oooefam.net CORS support | Claude Sonnet 4.5 |

---

## Quick Reference

### Essential Commands

```bash
# Check deployment status
npx wrangler pages project list

# View deployment details
npx wrangler pages deployment list --project-name=bookstrack-web

# Deploy latest build
npx wrangler pages deploy build/web --project-name=bookstrack-web

# Verify CORS
curl -H "Origin: https://books.oooefam.net" -I https://api.oooefam.net/v1/health

# Check DNS
dig books.oooefam.net CNAME +short
```

### Important Links

- **Cloudflare Dashboard:** https://dash.cloudflare.com/d03bed0be6d976acd8a1707b55052f79
- **Pages Project:** https://dash.cloudflare.com/d03bed0be6d976acd8a1707b55052f79/pages/view/bookstrack-web
- **Domain Settings:** https://dash.cloudflare.com/d03bed0be6d976acd8a1707b55052f79/pages/view/bookstrack-web/domains
- **GitHub Repository:** https://github.com/jukasdrj/bookstrack-web
- **bendv3 Repository:** https://github.com/jukasdrj/bendv3

---

**Last Updated:** January 2, 2026
**Status:** ✅ Production Ready (Minimal Version)
**Next Step:** Configure custom domain via Cloudflare Dashboard
