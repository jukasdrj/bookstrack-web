# Cloudflare Configuration

This directory contains Cloudflare Pages and Workers configuration for the BooksTrack web application.

## Wrangler Version

**Current Version:** 4.59.2 (latest as of Jan 17, 2026)
**Installation:** Globally installed via npm

### Checking Version

```bash
wrangler --version
# Output: 4.59.2
```

### Updating Wrangler

```bash
npm install -g wrangler@latest
```

## Files

### `pages-config.json`
Reference configuration for Cloudflare Pages dashboard settings. This file documents the configuration but is not used directly by Cloudflare.

**Key Settings:**
- Project name: `bookstrack-web`
- Build command: `flutter build web --release`
- Output directory: `build/web`
- Production branch: `main`

### `wrangler-wrapper.sh`
Shell script wrapper that ensures using the latest wrangler version.

**Usage:**
```bash
./.cloudflare/wrangler-wrapper.sh pages deploy build/web --project-name=bookstrack-web
```

**Behavior:**
- Uses global `wrangler` if installed (preferred)
- Falls back to `npx wrangler@latest` if not found
- Always ensures latest version

## Deployment

### Automatic (Recommended)
Push to GitHub `main` branch triggers automatic deployment via Cloudflare Pages GitHub integration.

```bash
git push origin main
# Cloudflare Pages auto-deploys in 2-3 minutes
```

### Manual Deploy
Use when you need to deploy without committing to Git:

```bash
# Build
flutter build web --release

# Deploy
wrangler pages deploy build/web --project-name=bookstrack-web --branch=main
```

### Deployment Management

```bash
# List all deployments
wrangler pages deployment list --project-name=bookstrack-web

# View specific deployment
wrangler pages deployment get <deployment-id>

# View logs
wrangler pages deployment logs <deployment-id>

# List projects
wrangler pages project list
```

## Integration with BendV3 API

The web app integrates with the BendV3 API worker:

```
┌─────────────────────────────────────┐
│  books.oooefam.net                  │
│  (Cloudflare Pages)                 │
│  Project: bookstrack-web            │
└─────────────┬───────────────────────┘
              │ HTTPS
┌─────────────▼───────────────────────┐
│  api.oooefam.net                    │
│  (Cloudflare Worker)                │
│  Worker: api-worker                 │
│  Repo: /bendv3                      │
└─────────────────────────────────────┘
```

**Benefits:**
- Same Cloudflare account (no CORS configuration needed)
- Same zone (oooefam.net)
- Unified dashboard
- Single billing

## Environment Variables

Currently no environment variables are needed for the web build. All API configuration is in the code:

- API URL: `https://api.oooefam.net` (hardcoded in `api_client_provider.dart`)
- Database: IndexedDB (browser storage, no config needed)

Future environment variables can be set in Cloudflare Pages dashboard:
```
Settings → Environment variables → Production
```

## Custom Domain

**Production:** books.oooefam.net
**DNS Record:**
```
Type:   CNAME
Name:   books
Target: bookstrack-web.pages.dev
Proxy:  Enabled (orange cloud)
```

**SSL/TLS:** Full (strict) - Auto-configured by Cloudflare

## Monitoring

### Cloudflare Dashboard
```
https://dash.cloudflare.com/d03bed0be6d976acd8a1707b55052f79/pages/view/bookstrack-web
```

### Analytics
- Page views
- Bandwidth usage
- Requests per second
- Geographic distribution

### Logs
```bash
# Real-time logs (if available)
wrangler pages deployment tail

# Historical logs
wrangler pages deployment logs <deployment-id>
```

## Troubleshooting

### Build Fails
Check Flutter version and dependencies:
```bash
flutter doctor
flutter pub get
flutter build web --release
```

### Deploy Fails
Check wrangler authentication:
```bash
wrangler whoami
# If not logged in:
wrangler login
```

### CORS Issues
Ensure BendV3 API allows `books.oooefam.net` origin:
```typescript
// In bendv3/src/middleware/cors.ts
const allowedOrigins = [
  'https://books.oooefam.net',
  'https://bookstrack-web.pages.dev',
];
```

## Documentation

- **CLOUDFLARE_PAGES_SETUP.md** - Complete setup guide
- **DEPLOYMENT_SUMMARY.md** - Production deployment details
- **API_INTEGRATION_VERIFICATION.md** - API integration guide

## Support

**Cloudflare Pages Docs:** https://developers.cloudflare.com/pages
**Wrangler Docs:** https://developers.cloudflare.com/workers/wrangler/
**Flutter Web Docs:** https://docs.flutter.dev/platform-integration/web

---

**Last Updated:** January 17, 2026
**Wrangler Version:** 4.59.2
**Project Status:** Production Live ✅
