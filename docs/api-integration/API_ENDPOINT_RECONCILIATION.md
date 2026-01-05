# API Endpoint Reconciliation Report

**Date:** January 5, 2026
**Analysis:** Live OpenAPI Spec vs Documentation vs npm Package Claims

---

## Critical Discovery

The **live OpenAPI spec** at `https://api.oooefam.net/v3/openapi.json` contains **ONLY 5 endpoints**, not the 17 claimed by the npm package or documented in BENDV3_API_INTEGRATION_GUIDE.md.

### Endpoint Count Summary

| Source | Endpoint Count | Status |
|--------|---------------|--------|
| **Live OpenAPI Spec** | **5 endpoints** | ✅ Source of Truth |
| Local openapi-v3.json | 3 endpoints | ❌ Outdated (60% complete) |
| BENDV3_API_INTEGRATION_GUIDE.md | 17 endpoints | ❌ Incorrect (includes non-existent endpoints) |
| npm Package @2.1.0 Claim | 17 endpoints (100%) | ❌ Misleading |

---

## Live API Endpoints (From Production)

### ✅ Actually Available (5 endpoints)

```
GET  /v3/capabilities             # API capabilities
GET  /v3/recommendations/weekly   # Weekly book recommendations
GET  /v3/books/search             # Search books
GET  /v3/books/{isbn}             # Get book by ISBN
POST /v3/books/enrich             # Batch enrichment (1-50 ISBNs)
```

### ❌ NOT in Live Spec (12 endpoints from BENDV3 guide)

```
# Job Management - CSV Imports (NOT AVAILABLE)
POST /v3/jobs/imports
GET  /v3/jobs/imports/:id
GET  /v3/jobs/imports/:id/stream

# Job Management - Bookshelf Scans (NOT AVAILABLE)
POST /v3/jobs/scans
GET  /v3/jobs/scans/:id
GET  /v3/jobs/scans/:id/stream

# Job Management - Background Enrichment (NOT AVAILABLE)
POST /v3/jobs/enrichment
GET  /v3/jobs/enrichment/:id
GET  /v3/jobs/enrichment/:id/stream

# Webhooks (NOT AVAILABLE)
POST /v3/webhooks/alexandria/enrichment

# Documentation (NOT in OpenAPI spec, but may exist)
GET  /v3/docs
GET  /v3/openapi.json  # This exists (we just fetched it!)
```

---

## Analysis of Discrepancies

### Why the Confusion?

**Hypothesis 1: Job Endpoints Not Yet Deployed**
- npm package generated from OpenAPI spec that includes planned endpoints
- Backend code exists but endpoints not yet deployed to production
- BENDV3_API_INTEGRATION_GUIDE.md documents intended API, not actual API

**Hypothesis 2: Private/Internal Endpoints**
- Job endpoints exist but not exposed in public OpenAPI spec
- May require authentication or special access
- Possibly v4 endpoints not yet in v3 spec

**Hypothesis 3: Documentation Drift**
- BENDV3_API_INTEGRATION_GUIDE.md based on backend code, not deployed API
- npm package published prematurely before deployment
- Live OpenAPI spec is the actual production state

**Most Likely:** Hypothesis 3 - Documentation reflects planned features, live API has subset

---

## Impact on Flutter Implementation Plan

### CRITICAL REVISION REQUIRED

Our **Phase 2 Implementation Plan** assumed job endpoints exist. **They don't.**

### What We CAN Implement Immediately

**Phase 1: DTO Updates** (1-2 days) - **STILL VALID**
- Add 9 new fields to DTOs
- Database migration v4 → v5
- Update DTOMapper

**Phase 2: BendV3Service** (3-5 days) - **UPDATE REQUIRED**
- ✅ Implement search endpoint
- ✅ Implement ISBN lookup
- ✅ Implement batch enrichment
- ✅ **NEW:** Implement capabilities endpoint
- ✅ **NEW:** Implement weekly recommendations

**Phase 3: Async Jobs** (1-2 weeks) - **BLOCKED**
- ❌ **CANNOT IMPLEMENT** - Job endpoints don't exist in production
- ❌ CSV import not available
- ❌ Bookshelf scan not available
- ❌ Background enrichment job not available
- ❌ SSE streaming not available

### Revised Implementation Plan

**Phase 1: DTO Updates** (1-2 days)
- No changes from original plan

**Phase 2: BendV3Service + Discovery** (4-6 days)
- Task 2.1: Create BendV3 Response DTOs (1.5 hours) - SAME
- Task 2.2: Create BendV3Service (3 hours) - SAME
- Task 2.3: Create BendV3 Provider (30 mins) - SAME
- Task 2.4: Update SearchService Adapter (2 hours) - SAME
- **Task 2.5 (NEW): Implement Capabilities Endpoint (1 hour)**
- **Task 2.6 (NEW): Implement Weekly Recommendations (2 hours)**
- Task 2.7: Integration Testing (2 hours) - UPDATE to include new endpoints
- Task 2.8: Manual Testing (2 hours) - UPDATE to include new endpoints

**Phase 3: Async Jobs** - **DEFERRED**
- Wait for job endpoints to be deployed to production
- Estimated deployment timeline: Unknown
- **Action:** Request ETA from backend team

---

## Capabilities Endpoint Details

### GET /v3/capabilities

**Response Schema:**
```json
{
  "features": {
    "semantic_search": false,        // Not yet available
    "similar_books": false,          // Not yet available
    "weekly_recommendations": true,   // Available now
    "sse_streaming": false,          // Not yet available
    "batch_enrichment": true,        // Available now
    "csv_import": false              // Not yet available
  },
  "limits": {
    "semantic_search_rpm": 0,        // Rate limit: 0 = not available
    "text_search_rpm": 60,           // 60 requests per minute
    "csv_max_rows": 0,               // 0 = feature not available
    "batch_max_photos": 0            // 0 = feature not available
  },
  "version": "3.0.0"
}
```

**Usage:**
```dart
final capabilities = await bendV3Service.getCapabilities();

// Check if feature available before using
if (capabilities.features.csvImport) {
  // Show CSV import UI
} else {
  // Hide CSV import option
}
```

---

## Weekly Recommendations Endpoint Details

### GET /v3/recommendations/weekly

**Query Parameters:**
- `limit` (optional): Number of recommendations (1-20, default: 10)

**Response Schema:**
```json
{
  "success": true,
  "data": {
    "weekOf": "2026-01-05",
    "recommendations": [
      {
        "isbn": "9780439708180",
        "title": "Harry Potter and the Sorcerer's Stone",
        "author": "J.K. Rowling",
        "coverUrl": "https://covers.openlibrary.org/b/isbn/9780439708180-L.jpg",
        "reason": "Classic fantasy beloved by readers worldwide"
      }
    ],
    "count": 10,
    "totalAvailable": 50
  },
  "metadata": {
    "timestamp": "2026-01-05T08:48:45.123Z",
    "requestId": "uuid-here",
    "cached": true,
    "processingTime": 5
  }
}
```

**Usage:**
```dart
final recommendations = await bendV3Service.getWeeklyRecommendations(limit: 10);

// Display in UI
for (final rec in recommendations.data.recommendations) {
  print('${rec.title} by ${rec.author} - ${rec.reason}');
}
```

---

## Updated Implementation Tasks

### Immediate (This Week)

1. ✅ **Fetch live OpenAPI spec** - COMPLETE
2. ✅ **Identify actual available endpoints** - COMPLETE
3. ⏳ **Update BENDV3_API_INTEGRATION_GUIDE.md**
   - Remove non-existent job endpoints
   - Add capabilities endpoint documentation
   - Add weekly recommendations documentation
   - Add note: "Job endpoints planned but not yet deployed"

4. ⏳ **Update Phase 2 Implementation Plan**
   - Remove Phase 3 (async jobs) - mark as "Future"
   - Add Phase 2.5: Discovery endpoints (capabilities + recommendations)
   - Update timeline: 4-6 weeks → 2-3 weeks (no Phase 3)

5. ⏳ **Update TODO_REFINED.md**
   - Mark Phase 3 as "Blocked - awaiting backend deployment"
   - Add tasks for capabilities and recommendations endpoints
   - Add task: "Check /v3/capabilities monthly for new features"

### Short-term (Before Phase 2)

6. ⏳ **Test actual API endpoints**
   ```bash
   # Test capabilities
   curl https://api.oooefam.net/v3/capabilities

   # Test recommendations
   curl "https://api.oooefam.net/v3/recommendations/weekly?limit=5"

   # Confirm job endpoints DON'T exist
   curl -X POST https://api.oooefam.net/v3/jobs/imports \
     -F "file=@sample.csv" \
     -F "format=csv"  # Should return 404
   ```

7. ⏳ **Create feature flag system**
   - Check `/v3/capabilities` on app startup
   - Enable/disable UI features based on availability
   - Show "Coming Soon" for unavailable features

### Medium-term (Backend Coordination)

8. ⏳ **Contact backend team**
   - Ask when job endpoints will be deployed
   - Request access to staging environment with job endpoints
   - Coordinate timing for Phase 3 implementation

9. ⏳ **Monitor capabilities endpoint**
   - Check `/v3/capabilities` weekly
   - Watch for `csv_import: true`, `sse_streaming: true`
   - Begin Phase 3 when features go live

---

## Corrected API Coverage

### Current Production API (5 endpoints)

| Endpoint | Method | Purpose | Status |
|----------|--------|---------|--------|
| /v3/capabilities | GET | API feature flags | ✅ Available |
| /v3/recommendations/weekly | GET | Weekly book picks | ✅ Available |
| /v3/books/search | GET | Search books | ✅ Available |
| /v3/books/{isbn} | GET | ISBN lookup | ✅ Available |
| /v3/books/enrich | POST | Batch enrichment | ✅ Available |

### Planned But Not Deployed (12 endpoints)

| Endpoint | Method | Purpose | Status |
|----------|--------|---------|--------|
| /v3/jobs/imports | POST | CSV import job | ⏳ Planned |
| /v3/jobs/imports/:id | GET | Import status | ⏳ Planned |
| /v3/jobs/imports/:id/stream | GET | Import SSE | ⏳ Planned |
| /v3/jobs/scans | POST | Bookshelf scan job | ⏳ Planned |
| /v3/jobs/scans/:id | GET | Scan status | ⏳ Planned |
| /v3/jobs/scans/:id/stream | GET | Scan SSE | ⏳ Planned |
| /v3/jobs/enrichment | POST | Enrichment job | ⏳ Planned |
| /v3/jobs/enrichment/:id | GET | Enrichment status | ⏳ Planned |
| /v3/jobs/enrichment/:id/stream | GET | Enrichment SSE | ⏳ Planned |
| /v3/webhooks/alexandria/enrichment | POST | Internal webhook | ⏳ Planned |
| /v3/docs | GET | Swagger UI | ❓ May exist |
| /v3/openapi.json | GET | OpenAPI spec | ✅ Exists (confirmed) |

---

## Recommendations

### 1. Update All Documentation Immediately
- Mark job endpoints as "Planned - Not Yet Available"
- Remove misleading "100% API coverage" claims
- Document actual 5 endpoints as production-ready

### 2. Implement Capabilities-Based Feature Flags
```dart
class FeatureFlags {
  final BendV3Capabilities capabilities;

  bool get canImportCSV => capabilities.features.csvImport;
  bool get canScanBookshelf => capabilities.features.batchMaxPhotos > 0;
  bool get canUseSemanticSearch => capabilities.features.semanticSearch;

  // Check on app startup
  static Future<FeatureFlags> fetch(BendV3Service service) async {
    final caps = await service.getCapabilities();
    return FeatureFlags(caps);
  }
}
```

### 3. Defer Phase 3 Until Backend Ready
- Don't implement job-related code until endpoints exist
- Focus on completing Phase 1 and 2 first
- Estimated savings: 1-2 weeks of wasted effort

### 4. Add Weekly Recommendations Feature
- Easy win - endpoint exists and works
- Good user engagement feature
- Can implement in Phase 2

---

## Revised Timeline

### Original Timeline (Incorrect)
- Phase 1: 1-2 days (DTO updates)
- Phase 2: 3-5 days (BendV3Service)
- Phase 3: 1-2 weeks (Async jobs)
- **Total:** 4-6 weeks

### Corrected Timeline (Based on Live API)
- Phase 1: 1-2 days (DTO updates) - NO CHANGE
- Phase 2: 4-6 days (BendV3Service + Discovery) - +1 day for new endpoints
- Phase 3: **DEFERRED** - Waiting for backend deployment
- **Total:** 1.5-2 weeks (67% reduction!)

**Time Saved:** 2.5-4 weeks by not implementing non-existent endpoints

---

## Conclusion

**Key Findings:**

1. **Live API has 5 endpoints**, not 17 as documented
2. **Job endpoints don't exist** in production yet
3. **Phase 3 implementation blocked** until backend deployment
4. **2 new endpoints available** (capabilities, recommendations)
5. **Timeline reduced by 67%** (2.5-4 weeks saved)

**Critical Action Items:**

1. Update all documentation to reflect actual API
2. Implement capabilities endpoint for feature flags
3. Add weekly recommendations feature (quick win)
4. Coordinate with backend team on job endpoint ETA
5. Monitor `/v3/capabilities` for feature availability

**Next Steps:**

1. Update BENDV3_API_INTEGRATION_GUIDE.md
2. Update Phase 2 Implementation Plan
3. Test capabilities and recommendations endpoints
4. Begin Phase 1 implementation with correct expectations

---

**Last Updated:** January 5, 2026
**Status:** Reconciliation complete - ready for corrected implementation
