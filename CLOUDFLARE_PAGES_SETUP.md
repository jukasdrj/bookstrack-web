# Cloudflare Pages Deployment Guide

**Project:** BooksTrack Web
**Repository:** https://github.com/jukasdrj/bookstrack-web
**Backend API:** https://api.oooefam.net (BendV3)
**Target URL:** https://books.oooefam.net

---

## Prerequisites

✅ GitHub repository pushed (commit: 125be07)
✅ Cloudflare account with `oooefam.net` domain
✅ BendV3 API running at `api.oooefam.net`

---

## Step-by-Step Deployment

### 1. Create Cloudflare Pages Project

**Via Cloudflare Dashboard:**

1. **Go to Cloudflare Pages**
   ```
   https://dash.cloudflare.com/
   → Pages
   → Create a project
   → Connect to Git
   ```

2. **Connect GitHub Repository**
   - Select: `jukasdrj/bookstrack-web`
   - Grant Cloudflare Pages access to the repository
   - Click "Begin setup"

3. **Configure Build Settings**
   ```
   Project name:          bookstrack-web
   Production branch:     main
   Framework preset:      None (custom Flutter build)

   Build command:         flutter build web --release
   Build output directory: build/web
   Root directory:        (leave empty)
   ```

4. **Environment Variables** (Optional)
   ```
   FLUTTER_VERSION = 3.38.7
   ```

   Note: Cloudflare Pages has Flutter pre-installed, so this is optional.

5. **Save and Deploy**
   - Click "Save and Deploy"
   - First build will take ~2-3 minutes
   - Cloudflare Pages will automatically detect Flutter

---

### 2. Configure Custom Domain

**After first successful build:**

1. **Go to Custom Domains**
   ```
   Cloudflare Pages Dashboard
   → bookstrack-web project
   → Custom domains
   → Set up a custom domain
   ```

2. **Add Domain**
   ```
   Domain:  books.oooefam.net
   ```

3. **DNS Configuration**
   Cloudflare will automatically create a CNAME record:
   ```
   Type:  CNAME
   Name:  books
   Target: bookstrack-web.pages.dev
   Proxy: Enabled (orange cloud)
   ```

4. **SSL/TLS Settings**
   ```
   Encryption mode: Full (strict)

   This is already configured for oooefam.net domain.
   ```

---

### 3. Configure CORS on BendV3 API

**Important:** BendV3 API needs to allow requests from `books.oooefam.net`

**Location:** `/Users/juju/dev_repos/bendv3/src/middleware/cors.ts`

**Add to allowed origins:**
```typescript
const allowedOrigins = [
  'https://books.oooefam.net',      // Production web app
  'https://bookstrack-web.pages.dev', // Cloudflare Pages preview
  'http://localhost:8080',            // Local testing
  // ... existing origins
];
```

**Deploy updated CORS:**
```bash
cd /Users/juju/dev_repos/bendv3
git add src/middleware/cors.ts
git commit -m "feat: Add CORS for books.oooefam.net web app"
git push origin main

# Cloudflare Workers will auto-deploy via GitHub Actions
```

---

### 4. Verify Deployment

**Automatic Checks:**

1. **Build Success**
   ```
   Cloudflare Pages Dashboard
   → Deployments
   → Check latest deployment status

   Expected: ✅ Success (2-3 minutes)
   ```

2. **Preview URL**
   ```
   https://bookstrack-web.pages.dev

   Test immediately while custom domain DNS propagates
   ```

3. **Custom Domain**
   ```
   https://books.oooefam.net

   May take 1-5 minutes for DNS propagation
   ```

**Manual Testing:**

```bash
# 1. Check DNS
dig books.oooefam.net

# 2. Check SSL
curl -I https://books.oooefam.net

# 3. Test API connectivity
# Open https://books.oooefam.net in browser
# Try searching for "Harry Potter"
# Check browser console for CORS errors
```

---

## Alternative: Deploy via Wrangler CLI

**If you prefer command-line deployment:**

### Install Wrangler

```bash
npm install -g wrangler

# Authenticate
wrangler login
```

### Create Pages Project

```bash
cd /Users/juju/dev_repos/bookstrack-web

# Build Flutter web
flutter build web --release

# Deploy to Cloudflare Pages
npx wrangler pages deploy build/web \
  --project-name=bookstrack-web \
  --branch=main
```

### Configure Custom Domain (CLI)

```bash
npx wrangler pages deployment create \
  --project-name=bookstrack-web \
  --branch=main \
  --commit-hash=$(git rev-parse HEAD)
```

**Note:** Custom domain setup still requires dashboard configuration.

---

## Expected Build Output

**Cloudflare Pages will run:**

```bash
# 1. Install Flutter (if not cached)
flutter doctor

# 2. Install dependencies
flutter pub get

# 3. Build web version
flutter build web --release

# 4. Output to build/web
```

**Build Output:**
```
build/web/
├── main.dart.js (2.9 MB)
├── index.html
├── flutter.js
├── assets/
├── canvaskit/
└── icons/
```

**Expected Build Time:** 1-3 minutes
**Cache:** Subsequent builds ~30-60 seconds (cached dependencies)

---

## Continuous Deployment

**Automatic Deploys:**

Once connected, Cloudflare Pages will automatically deploy on:
- ✅ Push to `main` branch (production)
- ✅ Pull requests (preview deployments)
- ✅ Any branch push (preview deployments)

**Preview Deployments:**
```
https://[commit-hash].bookstrack-web.pages.dev
```

**Rollback:**
```
Cloudflare Pages Dashboard
→ Deployments
→ Select previous deployment
→ "Rollback to this deployment"
```

---

## Linking to BendV3 Worker

**Architecture:**

```
┌─────────────────────────────────────────┐
│   books.oooefam.net                     │
│   (Cloudflare Pages)                    │
│   - Flutter Web App                     │
│   - IndexedDB storage                   │
│   - Static files (2.9 MB)               │
└────────────────┬────────────────────────┘
                 │
                 │ HTTPS Requests
                 │
┌────────────────▼────────────────────────┐
│   api.oooefam.net                       │
│   (Cloudflare Worker)                   │
│   - BendV3 API                          │
│   - Route: api.oooefam.net/*            │
│   - Worker: api-worker                  │
└────────────────┬────────────────────────┘
                 │
                 │ RPC Calls
                 │
┌────────────────▼────────────────────────┐
│   Alexandria                            │
│   (D1 Database)                         │
│   - 49M+ ISBNs                          │
│   - Book metadata                       │
│   - Author enrichment                   │
└─────────────────────────────────────────┘
```

**Same Cloudflare Account Benefits:**
- ✅ Same billing
- ✅ Shared analytics
- ✅ Unified dashboard
- ✅ No cross-origin issues (same zone: oooefam.net)
- ✅ Global CDN for both Pages and Workers
- ✅ Automatic SSL

**Route Configuration:**
```
Zone: oooefam.net

Routes:
  - books.oooefam.net/*  → Cloudflare Pages (bookstrack-web)
  - api.oooefam.net/*    → Cloudflare Worker (api-worker)
```

---

## Monitoring & Analytics

**Cloudflare Pages Analytics:**
```
Dashboard → Pages → bookstrack-web → Analytics

Metrics:
- Page views
- Unique visitors
- Bandwidth
- Requests
- Top pages
- Geo distribution
```

**BendV3 API Monitoring:**
```
Dashboard → Workers → api-worker → Metrics

Metrics:
- Requests per second
- Success rate
- Errors
- CPU time
- Duration
```

**Combined Monitoring:**
- Link Pages deployment to Worker via custom headers
- Track end-to-end request flow
- Monitor API success/failure rates from web app

---

## Troubleshooting

### Build Fails

**Error: "Flutter not found"**
```
Solution: Cloudflare Pages should auto-detect Flutter.
If not, add environment variable:
  FLUTTER_VERSION = 3.38.7
```

**Error: "pub get failed"**
```
Solution: Check pubspec.yaml for invalid dependencies.
Our build: ✅ All packages valid (tested locally)
```

**Error: "Build timeout"**
```
Solution: Flutter web builds can take 2-3 minutes.
This is normal. Wait for completion.
```

### CORS Errors

**Error: "Access-Control-Allow-Origin"**
```
Check: BendV3 API CORS middleware
File: /Users/juju/dev_repos/bendv3/src/middleware/cors.ts

Add: 'https://books.oooefam.net' to allowedOrigins
Deploy: git push to update api-worker
```

### DNS Issues

**Error: "books.oooefam.net not found"**
```
Check: CNAME record exists
  dig books.oooefam.net

Fix: Add CNAME in Cloudflare DNS
  Type: CNAME
  Name: books
  Target: bookstrack-web.pages.dev
```

### API Connection Fails

**Error: "Network error" in browser console**
```
Check:
1. BendV3 API health: curl https://api.oooefam.net/health
2. CORS headers: Check browser Network tab
3. Firewall rules: Cloudflare Firewall dashboard

Test:
curl -H "Origin: https://books.oooefam.net" \
  https://api.oooefam.net/v3/books/search?q=test
```

---

## Post-Deployment Checklist

**After successful deployment:**

- [ ] ✅ Build successful (green checkmark in Pages dashboard)
- [ ] ✅ Preview URL works (bookstrack-web.pages.dev)
- [ ] ✅ Custom domain works (books.oooefam.net)
- [ ] ✅ SSL certificate active (HTTPS)
- [ ] ✅ Search functionality works
- [ ] ✅ API connectivity verified
- [ ] ✅ No CORS errors in console
- [ ] ✅ Cover images loading
- [ ] ✅ Mobile responsive
- [ ] ✅ Analytics tracking enabled

---

## Future Enhancements

**Optional Configurations:**

1. **Headers & Security**
   ```
   _headers file for custom HTTP headers:
   - Content-Security-Policy
   - X-Frame-Options
   - Permissions-Policy
   ```

2. **Redirects**
   ```
   _redirects file for URL rewrites:
   /old-path  /new-path  301
   ```

3. **Functions (Edge Functions)**
   ```
   functions/ directory for serverless edge functions
   - Server-side rendering (SSR)
   - API proxying
   - Custom middleware
   ```

4. **Branch Deployments**
   ```
   develop branch → https://develop.bookstrack-web.pages.dev
   feature/* → https://feature-*.bookstrack-web.pages.dev
   ```

---

## Quick Reference

**Repository:** https://github.com/jukasdrj/bookstrack-web
**Latest Commit:** 125be07 (feat: Production-ready web build)

**Cloudflare Pages:**
- Project: bookstrack-web
- Branch: main
- Build: `flutter build web --release`
- Output: `build/web`
- Domain: https://books.oooefam.net

**BendV3 API:**
- Worker: api-worker
- Route: api.oooefam.net/*
- Repository: /Users/juju/dev_repos/bendv3
- Zone: oooefam.net

**Local Testing:**
```bash
# Build
flutter build web --release

# Serve
cd build/web && python3 -m http.server 8080

# Test
open http://localhost:8080
```

**Wrangler Deploy:**
```bash
# One-time deploy
npx wrangler pages deploy build/web --project-name=bookstrack-web

# Watch deployments
npx wrangler pages deployment list --project-name=bookstrack-web
```

---

## Support

**Documentation:**
- API Integration: [API_INTEGRATION_VERIFICATION.md](API_INTEGRATION_VERIFICATION.md)
- Deployment: [DEPLOYMENT_READY.md](DEPLOYMENT_READY.md)
- Cloudflare Pages: https://developers.cloudflare.com/pages
- Flutter Web: https://docs.flutter.dev/platform-integration/web

**Monitoring:**
- Pages Dashboard: https://dash.cloudflare.com → Pages
- Worker Dashboard: https://dash.cloudflare.com → Workers
- Harvest Dashboard: https://harvest.oooefam.net (API monitoring)

---

**Created:** January 17, 2026
**Last Updated:** January 17, 2026
**Status:** Ready to Deploy 🚀
