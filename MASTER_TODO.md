# Master TODO List

**Last Updated:** January 5, 2026
**Project Status:** Phase 2 (Search Feature) - 100% UI Complete, API Integration Pending

---

## Summary

The project is at a critical juncture between Phase 1 (Foundation) and Phase 2 (Search). While the UI for Search is complete, the data layer is currently using placeholders and requires significant updates to integrate with the BendV3 API. This master todo list prioritizes API integration, data model updates, and critical architectural fixes.

---

## Critical/Blockers (P0)

### 1. Create BendV3Service Implementation
- **Effort:** M (4-8 hours)
- **Dependencies:** None
- **Related Files:**
  - `lib/core/services/api/bendv3_service.dart` (to be created)
  - `BENDV3_API_INTEGRATION_GUIDE.md`
- **Description:** Implement the service layer for BendV3 API integration with endpoints:
  - `GET /v3/books/search` - Unified search
  - `POST /v3/books/enrich` - Batch ISBN enrichment
  - `GET /v3/books/:isbn` - Direct ISBN lookup
  - `POST /v3/jobs/scans` - Bookshelf scan

### 2. Update WorkDTO with Missing Fields
- **Effort:** S (2-4 hours)
- **Dependencies:** None
- **Related Files:**
  - `lib/core/data/models/dtos/work_dto.dart`
  - `BENDV3_API_INTEGRATION_GUIDE.md`
- **Description:** Add 9 new fields from BendV3 API:
  - `subtitle` (String?)
  - `description` (String?)
  - `workKey` (String?)
  - `provider` (String?)
  - `qualityScore` (int?)
  - `thumbnailUrl` (String?)
  - `categories` (List<String>?)

### 3. Update EditionDTO with Missing Fields
- **Effort:** S (2-4 hours)
- **Dependencies:** None
- **Related Files:**
  - `lib/core/data/models/dtos/edition_dto.dart`
  - `BENDV3_API_INTEGRATION_GUIDE.md`
- **Description:** Add missing fields:
  - `subtitle` (String?)
  - `editionKey` (String?)
  - `thumbnailURL` (String?)
  - `description` (String?)

### 4. Update Database Schema to v5
- **Effort:** M (4-8 hours)
- **Dependencies:** DTO updates
- **Related Files:**
  - `lib/core/data/database/database.dart`
- **Description:**
  - Add new columns to `Works` and `Editions` tables
  - Write migration logic from schema v4 → v5
  - Run `dart run build_runner build`
  - Test with fresh database install

### 5. Connect Search UI to Real API
- **Effort:** M (4-8 hours)
- **Dependencies:** BendV3Service
- **Related Files:**
  - `lib/features/search/providers/search_providers.dart`
  - `lib/core/services/api/search_service.dart`
- **Description:**
  - Remove placeholder data in SearchNotifier
  - Integrate BendV3Service for all search modes
  - Handle API exceptions properly
  - Test all search modes (title, author, ISBN, advanced)

---

## High Priority (P1)

### 6. Implement ScanSessions and DetectedItems Tables
- **Effort:** L (1-2 days)
- **Dependencies:** None
- **Related Files:**
  - `lib/core/data/database/database.dart`
  - `TODO_REFINED.md`
- **Description:**
  - Create database schema for Review Queue feature
  - Add indexes: `(sessionId, reviewStatus)`, `confidence`
  - Implement cascade delete behavior
  - Add Drift queries for session management

### 7. Agent Optimization Phase 1: Memory & Safety
- **Effort:** XL (3-5 days)
- **Dependencies:** None
- **Related Files:**
  - `docs/agent-optimization/CLAUDE_OPTIMIZATION_ANALYSIS.md`
  - `docs/agent-optimization/OPTIMIZATION_RECOMMENDATIONS.md`
- **Description:**
  - Implement agent memory system (.claude/memory/)
  - Add safety guardrails and autonomy controls
  - Create proactive agent routing logic
  - Standardize structured output formats

### 8. Fix "Navigate to Book Detail Screen" TODOs
- **Effort:** S (2-4 hours)
- **Dependencies:** Search UI
- **Related Files:**
  - `lib/features/library/screens/library_screen.dart`
  - `lib/features/search/screens/search_screen.dart`
- **Description:**
  - Create book detail screen route
  - Implement navigation on book card tap
  - Display full book details with all DTO fields

### 9. Implement "Add to Library" Functionality in Search
- **Effort:** M (4-8 hours)
- **Dependencies:** Database Schema v5
- **Related Files:**
  - `lib/features/search/screens/search_screen.dart`
  - `lib/core/data/database/database.dart`
- **Description:**
  - Add button/action to search results
  - Insert Work + Edition + Authors into database
  - Create UserLibraryEntry with status selection
  - Show success feedback

### 10. Web Support: Drift Wasm & Scanner Fallback
- **Effort:** L (1-2 days)
- **Dependencies:** None
- **Related Files:**
  - `lib/core/data/database/database.dart`
  - `lib/features/scanner/` (to be created)
- **Description:**
  - Configure Drift with `sqlite3_web` for WASM
  - Add `kIsWeb` conditional logic
  - Implement file upload fallback for scanner
  - Test web build thoroughly

---

## Medium Priority (P2)

### 11. Implement Mobile Barcode Scanner
- **Effort:** L (1-2 days)
- **Dependencies:** None
- **Related Files:**
  - `lib/features/scanner/` (to be created)
  - Package: `mobile_scanner ^4.0.0`
- **Description:**
  - Create scanner UI with camera preview
  - Implement barcode detection
  - Call BendV3Service ISBN lookup on scan
  - Add to library or show error

### 12. Implement Bookshelf AI Scanner (Gemini)
- **Effort:** XL (3-5 days)
- **Dependencies:** BendV3Service
- **Related Files:**
  - `lib/features/bookshelf_scanner/` (to be created)
- **Description:**
  - Camera integration for bookshelf photos
  - Call `POST /v3/jobs/scans` endpoint
  - Poll job status and retrieve results
  - Display detected books in review queue

### 13. Implement Combined Title + Author Search
- **Effort:** S (2-4 hours)
- **Dependencies:** BendV3Service
- **Related Files:**
  - `lib/features/search/providers/search_providers.dart`
- **Description:**
  - Add new search scope "Combined"
  - Parse query for title and author hints
  - Call BendV3 search with both parameters
  - Display combined results

---

## Low Priority/Future (P3)

### 14. Multi-Size Cover URL Support
- **Effort:** M (4-8 hours)
- **Dependencies:** BendV3 API Update
- **Related Files:**
  - `.github/BENDV3_FEATURE_REQUESTS.md`
- **Description:**
  - Request BendV3 API enhancement
  - Update DTOs when API ready
  - Optimize image loading with appropriate sizes

### 15. Author Diversity Data Integration
- **Effort:** L (1-2 days)
- **Dependencies:** Alexandria Update
- **Related Files:**
  - `.github/BENDV3_FEATURE_REQUESTS.md`
- **Description:**
  - Request Alexandria API enhancement
  - Add author diversity fields (gender, nationality, bio, photo)
  - Update AuthorDTO and database schema
  - Build diversity insights UI

---

## Code TODOs to Address

**From Codebase Scan:**
1. `lib/features/library/screens/library_screen.dart:xyz` - Navigate to book detail screen
2. `lib/features/search/screens/search_screen.dart:xyz` - Navigate to book detail screen
3. `lib/features/search/screens/search_screen.dart:xyz` - Implement "Add to Library" action
4. `.claude/agents/` - Complete Flutter-specific agent configurations

---

## Open Issues & PRs

**Git Status Analysis:**
- **Modified:** `CLAUDE.md` - Update and commit changes
- **Untracked:**
  - `.github/BENDV3_FEATURE_REQUESTS.md`
  - `API_DATA_COMPARISON.md`
  - `API_ENDPOINT_RECONCILIATION.md`
  - `API_INTEGRATION_QUICK_REFERENCE.md`
  - `BENDV3_API_INTEGRATION_GUIDE.md`
  - `NPM_PACKAGE_VS_OPENAPI_ANALYSIS.md`
  - `PR242_FRONTEND_INTEGRATION_GUIDE.md`
  - `PRD/docs/openapi-v3-live-formatted.json`
  - `PRD/docs/openapi-v3-live.json`

**Action Required:** Organize all untracked markdown files into `docs/` directory.

---

## Effort Summary

| Priority | Count | Total Effort Estimate |
|----------|-------|----------------------|
| P0       | 5     | 20-32 hours          |
| P1       | 5     | 7-13 days            |
| P2       | 3     | 5-9 days             |
| P3       | 2     | 2-3 days             |

**Critical Path:** P0 items must be completed sequentially (DTOs → Schema → Service → UI Integration).

---

## Next Steps

1. **Immediate (This Week):** Complete all P0 tasks to unblock Search feature
2. **Short Term (Next 2 Weeks):** Address P1 tasks for book detail screens and library integration
3. **Medium Term (Next Month):** Implement P2 scanner features
4. **Long Term (Next Quarter):** P3 API enhancements and diversity insights

---

## Notes

- All P0 tasks are on the critical path for Search feature completion
- Agent optimization (P1 #7) can run in parallel with other development
- Web support (P1 #10) is important for broader user reach
- P3 items require external API changes and can be deferred
