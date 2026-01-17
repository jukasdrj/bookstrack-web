# Search Issues Debug Plan

**Status:** Planning
**Created:** 2026-01-17 23:59 UTC

## Context
- Search API calls are working (CORS fixed)
- Results are being returned from BendV3
- User reports "results display but issues exist"
- Need specific details to diagnose

## Investigation Approach

### Phase 1: Identify Specific Issues
**Objective:** Get clear description of what's broken

**Questions:**
- [ ] What exactly looks wrong in the UI?
- [ ] Are there console errors in browser DevTools?
- [ ] Do all search modes have issues or just some?
- [ ] Are book covers loading?
- [ ] Is book data (title, author, etc.) displaying correctly?

### Phase 2: Reproduce Locally
**Objective:** Reproduce issues in local development

**Actions:**
- [ ] Run `flutter run -d chrome --target=lib/main_web.dart`
- [ ] Test search with same query as user
- [ ] Check browser console for errors
- [ ] Inspect network tab for API responses
- [ ] Verify BookDTO parsing is correct

### Phase 3: Root Cause Analysis
**Objective:** Identify exact cause of issues

**Possible Causes:**
1. **API Response Parsing**
   - BookDTO.fromJson() might fail on certain fields
   - Union type handling (authors as string[] vs AuthorReference[])
   - Missing or null fields causing crashes

2. **UI Rendering**
   - Cover URLs might be broken/missing
   - Widget layout issues
   - Missing null checks

3. **State Management**
   - Search state not updating correctly
   - Provider issues on web platform
   - Race conditions

4. **Data Quality**
   - BendV3 returning unexpected format
   - API schema mismatch
   - Missing required fields

### Phase 4: Fix & Test
**Objective:** Implement fixes and verify

**Process:**
1. Fix identified issues
2. Test locally first
3. Rebuild web: `flutter build web --target=lib/main_web.dart`
4. Deploy to Cloudflare Pages
5. Verify on production

### Phase 5: Validation
**Objective:** Ensure all search modes work

**Test Cases:**
- [ ] Search by title: "Harry Potter"
- [ ] Search by author: "J.K. Rowling"
- [ ] Search by ISBN: "9780439708180"
- [ ] Verify covers load
- [ ] Verify all book data displays
- [ ] Test on mobile browser
- [ ] Test error states

## Tools & Commands

### Local Testing
```bash
# Run web app locally
flutter run -d chrome --target=lib/main_web.dart

# Build web version
flutter build web --release --target=lib/main_web.dart

# Deploy to Cloudflare
npx wrangler pages deploy build/web --project-name=bookstrack-web
```

### Debugging
```bash
# Check API response
curl 'https://api.oooefam.net/v3/books/search?q=Harry%20Potter&mode=text&limit=20'

# Analyze build
flutter analyze

# Check for errors
flutter run -d chrome --verbose
```

## Expected Deliverables
1. List of specific issues identified
2. Root cause analysis for each issue
3. Code fixes implemented
4. Verified working on production
5. Updated findings.md with lessons learned

---

## Notes
- Use browser DevTools heavily
- Check both Chrome and Safari if possible
- Test with slow network to catch loading issues
- Verify API responses match expectations

