# npm Package vs OpenAPI Specification Analysis

**Date:** January 4, 2026
**Package:** @jukasdrj/bookstrack-api-client@2.1.0
**Status:** Published to npm successfully

---

## Executive Summary

The npm package @jukasdrj/bookstrack-api-client@2.1.0 claims **100% API coverage** with **14 new endpoints**, but our local `openapi-v3.json` specification is **significantly outdated** and only documents **3 endpoints** (26% coverage).

### Critical Findings

**Missing from OpenAPI Spec:**
- ❌ Job management endpoints (imports, scans, enrichment)
- ❌ Job status endpoints (GET /v3/jobs/{type}/:id)
- ❌ SSE streaming endpoints (GET /v3/jobs/{type}/:id/stream)
- ❌ Webhook endpoints (POST /v3/webhooks/alexandria/enrichment)
- ❌ Discovery endpoints (GET /v3/capabilities, GET /v3/recommendations/weekly)
- ❌ Documentation endpoints (GET /v3/docs, GET /v3/openapi.json)

**API Coverage Comparison:**

| Component | OpenAPI v3.json | npm Package 2.1.0 | BENDV3 Guide | Gap |
|-----------|----------------|-------------------|--------------|-----|
| Book Search | ✅ 1 endpoint | ✅ 1 endpoint | ✅ 1 endpoint | None |
| ISBN Lookup | ✅ 1 endpoint | ✅ 1 endpoint | ✅ 1 endpoint | None |
| Enrichment | ✅ 1 endpoint | ✅ 1 endpoint | ✅ 1 endpoint | None |
| Job Imports | ❌ Missing | ✅ 3 endpoints | ✅ 3 endpoints | **3 endpoints** |
| Job Scans | ❌ Missing | ✅ 3 endpoints | ✅ 3 endpoints | **3 endpoints** |
| Job Enrichment | ❌ Missing | ✅ 3 endpoints | ✅ 3 endpoints | **3 endpoints** |
| Webhooks | ❌ Missing | ✅ 1 endpoint | ✅ 1 endpoint | **1 endpoint** |
| Discovery | ❌ Missing | ✅ 2 endpoints | ✅ 2 endpoints | **2 endpoints** |
| Documentation | ❌ Missing | ✅ 2 endpoints | ✅ 2 endpoints | **2 endpoints** |
| **TOTAL** | **3 endpoints** | **17 endpoints** | **17 endpoints** | **14 endpoints** |

---

## Detailed Endpoint Comparison

### ✅ Documented in OpenAPI Spec (3 endpoints)

```typescript
GET  /v3/books/search      // Unified search
GET  /v3/books/:isbn       // Direct ISBN lookup
POST /v3/books/enrich      // Batch enrichment (1-50 ISBNs)
```

### ❌ Missing from OpenAPI Spec (14 endpoints)

#### Job Management - CSV Imports (3 endpoints)
```typescript
POST /v3/jobs/imports           // Create CSV import job
GET  /v3/jobs/imports/:id       // Check import status
GET  /v3/jobs/imports/:id/stream // SSE stream for progress
```

**Request Schema:**
```typescript
POST /v3/jobs/imports
Content-Type: multipart/form-data

{
  file: File           // CSV file with ISBNs
  format: 'csv'        // File format
}
```

**Response Schema:**
```typescript
{
  success: true,
  data: {
    jobId: string,           // Job UUID
    streamUrl: string,       // SSE endpoint URL
    token: string,           // Auth token for SSE
    status: 'queued'         // Initial status
  }
}
```

#### Job Management - Bookshelf Scans (3 endpoints)
```typescript
POST /v3/jobs/scans             // Create bookshelf scan job
GET  /v3/jobs/scans/:id         // Check scan status
GET  /v3/jobs/scans/:id/stream  // SSE stream for progress
```

**Request Schema:**
```typescript
POST /v3/jobs/scans
Content-Type: multipart/form-data

{
  file: File           // Bookshelf photo
  model: 'gemini-2.0-flash'  // AI model
}
```

**Response Schema:**
```typescript
{
  success: true,
  data: {
    jobId: string,
    streamUrl: string,
    token: string,
    status: 'queued',
    totalDetected?: number    // Books detected by AI
  }
}
```

#### Job Management - Background Enrichment (3 endpoints)
```typescript
POST /v3/jobs/enrichment           // Create enrichment job
GET  /v3/jobs/enrichment/:id       // Check enrichment status
GET  /v3/jobs/enrichment/:id/stream // SSE stream for progress
```

**Request Schema:**
```typescript
POST /v3/jobs/enrichment
Content-Type: application/json

{
  isbns: string[],         // Array of ISBNs (1-500)
  includeEmbedding: boolean // Generate vector embeddings
}
```

**Response Schema:**
```typescript
{
  success: true,
  data: {
    jobId: string,
    streamUrl: string,
    token: string,
    status: 'queued',
    totalItems: number       // Number of ISBNs to enrich
  }
}
```

#### SSE Progress Events (shared schema)
```typescript
// Server-Sent Events stream format
event: progress
data: {
  jobId: string,
  status: 'queued' | 'processing' | 'completed' | 'failed',
  progress: number,         // 0-100
  totalItems?: number,
  processedItems?: number,
  errorMessage?: string,
  result?: {                // Only on completion
    books: Book[],
    found: number,
    notFound: string[]
  }
}
```

#### Webhooks (1 endpoint)
```typescript
POST /v3/webhooks/alexandria/enrichment  // Alexandria callback
```

**Note:** This is internal-only and not directly callable by Flutter app.

#### Discovery (2 endpoints)
```typescript
GET /v3/capabilities          // API capabilities
GET /v3/recommendations/weekly // Weekly book recommendations
```

#### Documentation (2 endpoints)
```typescript
GET /v3/docs                  // Swagger UI
GET /v3/openapi.json          // Live OpenAPI spec
```

---

## Impact on Flutter Implementation Plan

### Current Plan Status

Our **Phase 2 Implementation Plan** (created today) is **partially accurate** but missing critical details:

**✅ What We Got Right:**
- Phase 1: DTO updates (9 fields) - CORRECT
- Phase 2: BendV3Service with 3 endpoints - CORRECT for synchronous operations
- Phase 3: Async jobs concept - CORRECT direction

**❌ What Needs Updating:**
- **Job endpoint paths** - We assumed `/v3/jobs/imports` but didn't know about status/stream endpoints
- **SSE authentication** - npm package reveals `token` field in job responses (we missed this)
- **multipart/form-data** - CSV import and scan jobs use file uploads (we assumed JSON)
- **Job response schema** - `streamUrl` and `token` fields not in our plan
- **Discovery endpoints** - We didn't know about `/v3/capabilities` and `/v3/recommendations/weekly`

### Required Plan Updates

#### Phase 3 Corrections

**OLD (our assumption):**
```dart
Future<String> createImportJob(List<String> isbns) async {
  final response = await _dio.post(
    '$_baseUrl/v3/jobs/imports',
    data: {'isbns': isbns, 'format': 'csv'},
  );
}
```

**NEW (actual API):**
```dart
Future<BendV3JobResponse> createImportJob(File csvFile) async {
  final formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(csvFile.path),
    'format': 'csv',
  });

  final response = await _dio.post(
    '$_baseUrl/v3/jobs/imports',
    data: formData,
  );

  final jobResponse = BendV3JobResponse.fromJson(response.data.data);

  // CRITICAL: Save token for SSE authentication
  await _connectToSSE(jobResponse.streamUrl, jobResponse.token);
}
```

**NEW: SSE Authentication Required**
```dart
void _connectToSSE(String streamUrl, String token) {
  final client = SseClient(
    streamUrl,
    headers: {
      'Authorization': 'Bearer $token',  // CRITICAL: Token required
    },
  );
  // ... rest of SSE logic
}
```

### New Endpoints to Add

**Phase 2.5: Discovery Endpoints (1 day)**
```dart
// Add to BendV3Service
Future<CapabilitiesResponse> getCapabilities() async {
  final response = await _dio.get('$_baseUrl/v3/capabilities');
  return CapabilitiesResponse.fromJson(response.data);
}

Future<RecommendationsResponse> getWeeklyRecommendations() async {
  final response = await _dio.get('$_baseUrl/v3/recommendations/weekly');
  return RecommendationsResponse.fromJson(response.data);
}
```

**Phase 3 Update: Job Status Polling**
```dart
// Add status endpoint for each job type
Future<BendV3JobResponse> getJobStatus(String jobId, JobType type) async {
  final endpoint = type == JobType.import
      ? '/v3/jobs/imports/$jobId'
      : type == JobType.scan
      ? '/v3/jobs/scans/$jobId'
      : '/v3/jobs/enrichment/$jobId';

  final response = await _dio.get('$_baseUrl$endpoint');
  return BendV3JobResponse.fromJson(response.data.data);
}
```

---

## Updated DTO Schemas

### BendV3JobResponse (CORRECTED)

```dart
@freezed
class BendV3JobResponse with _$BendV3JobResponse {
  const factory BendV3JobResponse({
    required String jobId,
    required String status,  // 'queued' | 'processing' | 'completed' | 'failed'
    required int progress,   // 0-100

    // NEW FIELDS (from npm package)
    required String streamUrl,  // SSE endpoint URL
    required String token,      // SSE authentication token

    int? totalItems,
    int? processedItems,
    int? totalDetected,  // For scan jobs only
    String? errorMessage,
  }) = _BendV3JobResponse;

  factory BendV3JobResponse.fromJson(Map<String, dynamic> json) =>
      _$BendV3JobResponseFromJson(json);
}
```

### CapabilitiesResponse (NEW)

```dart
@freezed
class CapabilitiesResponse with _$CapabilitiesResponse {
  const factory CapabilitiesResponse({
    required bool success,
    required CapabilitiesData data,
  }) = _CapabilitiesResponse;

  factory CapabilitiesResponse.fromJson(Map<String, dynamic> json) =>
      _$CapabilitiesResponseFromJson(json);
}

@freezed
class CapabilitiesData with _$CapabilitiesData {
  const factory CapabilitiesData({
    required List<String> searchModes,     // ['text', 'semantic', 'similar']
    required List<String> providers,       // ['alexandria', 'google_books', ...]
    required int maxBatchSize,             // 50
    required bool jobsSupported,           // true
    required bool webhooksSupported,       // true
  }) = _CapabilitiesData;

  factory CapabilitiesData.fromJson(Map<String, dynamic> json) =>
      _$CapabilitiesDataFromJson(json);
}
```

---

## Action Items

### Immediate (Today)

1. ✅ **Update openapi-v3.json** - Add 14 missing endpoints
   - File: `PRD/docs/openapi-v3.json`
   - Add: Job management endpoints (9)
   - Add: Webhook endpoint (1)
   - Add: Discovery endpoints (2)
   - Add: Documentation endpoints (2)

2. ⏳ **Update BENDV3_API_INTEGRATION_GUIDE.md**
   - Add SSE authentication section
   - Add multipart/form-data examples
   - Add `streamUrl` and `token` fields to job schemas

3. ⏳ **Update Phase 2 Implementation Plan**
   - Add Phase 2.5: Discovery endpoints (1 day)
   - Update Phase 3: Job endpoints with correct schemas
   - Add SSE authentication step
   - Add file upload handling for CSV/images

### Short-term (This Week)

4. ⏳ **Fetch live OpenAPI spec from production**
   ```bash
   curl https://api.oooefam.net/v3/openapi.json > PRD/docs/openapi-v3-live.json
   ```

5. ⏳ **Compare local spec with live spec**
   - Identify any additional discrepancies
   - Update our implementation plan accordingly

6. ⏳ **Update TODO_REFINED.md**
   - Add task: Implement Discovery endpoints
   - Add task: Update SSE authentication
   - Add task: Handle multipart/form-data uploads

### Medium-term (Before Phase 3)

7. ⏳ **Test job endpoints with curl**
   ```bash
   # Test CSV import
   curl -X POST https://api.oooefam.net/v3/jobs/imports \
     -F "file=@sample.csv" \
     -F "format=csv"

   # Test bookshelf scan
   curl -X POST https://api.oooefam.net/v3/jobs/scans \
     -F "file=@bookshelf.jpg" \
     -F "model=gemini-2.0-flash"
   ```

8. ⏳ **Add file upload dependencies to pubspec.yaml**
   ```yaml
   dependencies:
     dio: ^5.4.0
     sse_client: ^1.0.0
     file_picker: ^6.0.0  # NEW: For CSV/image selection
   ```

---

## Timeline Impact

### Original Timeline
- **Phase 1:** 1-2 days (DTO updates)
- **Phase 2:** 3-5 days (BendV3Service)
- **Phase 3:** 1-2 weeks (Async jobs)
- **Total:** 4-6 weeks

### Updated Timeline (with corrections)
- **Phase 1:** 1-2 days (DTO updates) - NO CHANGE
- **Phase 2:** 3-5 days (BendV3Service) - NO CHANGE
- **Phase 2.5:** 1 day (Discovery endpoints) - **NEW**
- **Phase 3:** 1.5-2.5 weeks (Async jobs + file uploads + SSE auth) - **+0.5-1 week**
- **Total:** 4.5-7 weeks (+0.5-1 week)

**Reason for increase:**
- Multipart/form-data file uploads (not in original plan)
- SSE authentication with token management (not in original plan)
- Job status polling endpoints (not in original plan)
- Discovery endpoints (nice-to-have)

---

## Risk Assessment Update

### NEW RISKS (from npm package analysis)

**HIGH RISK: SSE Authentication**
- **Risk:** SSE streams require `Authorization: Bearer {token}` header
- **Impact:** Our Phase 3 plan assumed no authentication
- **Mitigation:** Add token storage and header management

**MEDIUM RISK: File Upload Handling**
- **Risk:** CSV import and scan jobs require `multipart/form-data`
- **Impact:** Need file picker UI and FormData handling
- **Mitigation:** Add `file_picker` package and test file uploads

**MEDIUM RISK: OpenAPI Spec Drift**
- **Risk:** Local `openapi-v3.json` is 26% complete (3 of 17 endpoints)
- **Impact:** Future development may rely on outdated spec
- **Mitigation:** Sync with live spec at https://api.oooefam.net/v3/openapi.json

---

## Recommendations

### 1. Sync OpenAPI Spec Immediately
```bash
# Fetch live spec
curl https://api.oooefam.net/v3/openapi.json -o PRD/docs/openapi-v3-live.json

# Compare with local spec
diff PRD/docs/openapi-v3.json PRD/docs/openapi-v3-live.json
```

### 2. Update Implementation Plan Before Starting Phase 3
- Don't start Phase 3 until job endpoint schemas are validated
- Test SSE authentication manually first
- Add file upload POC before full implementation

### 3. Add Pre-Phase-3 Validation Tasks
- [ ] Validate job endpoint schemas with curl
- [ ] Test SSE stream with sample token
- [ ] Test CSV file upload with sample data
- [ ] Test bookshelf image upload with sample photo

### 4. Document npm Package as Source of Truth
- Add note to CLAUDE.md: "npm package @jukasdrj/bookstrack-api-client is canonical"
- Reference npm package version in all API documentation
- Set up automatic sync between npm package and Flutter implementation

---

## Conclusion

**Key Takeaways:**

1. **OpenAPI Spec is Outdated:** 74% of endpoints missing (14 of 17)
2. **npm Package is Source of Truth:** @jukasdrj/bookstrack-api-client@2.1.0 has 100% coverage
3. **Phase 3 Needs Updates:** File uploads, SSE auth, and status polling not in original plan
4. **Timeline Impact:** +0.5-1 week for Phase 3 corrections
5. **Risk Mitigation Required:** Test job endpoints before implementation

**Next Steps:**
1. Fetch live OpenAPI spec from production
2. Update Phase 2 Implementation Plan with corrections
3. Test job endpoints with curl before Phase 3
4. Add file upload dependencies to Flutter project

---

**Last Updated:** January 4, 2026
**Status:** Analysis complete - awaiting OpenAPI spec sync
