# DTO Synchronization Guardrails

**Created:** 2026-01-05
**Status:** Production-Ready
**Maintainer:** Development Team

This document describes the 5-layer guardrail system that prevents Flutter DTOs from drifting out of sync with BendV3 TypeScript API schemas.

---

## 🎯 Overview

**Problem:** Flutter DTOs (`WorkDTO`, `EditionDTO`, `AuthorDTO`) must match BendV3's TypeScript schemas exactly. Schema drift causes runtime errors and data corruption.

**Solution:** 5 automated guardrails that catch schema mismatches at different stages:

1. **JSON Schema Generation** - Compile-time validation against Zod schemas
2. **Type Sync Script** - Reference copy of TypeScript types for documentation
3. **Runtime Contract Tests** - Integration tests against live API
4. **CI/CD Validation** - Automated checks on every PR + daily cron
5. **Type Mapping Reference** - Human-readable documentation

---

## 📊 Guardrail Comparison

| Guardrail | Scope | When It Runs | Catches | Effort |
|-----------|-------|--------------|---------|--------|
| **1. JSON Schema** | Compile-time | Local dev + CI | Missing fields, type mismatches | Low |
| **2. Type Sync** | Documentation | Manual (weekly) | API changes, field renames | Low |
| **3. Contract Tests** | Runtime | Local + CI + cron | Response shape changes | Medium |
| **4. CI/CD Pipeline** | Automation | Every PR + daily | All of the above | Low |
| **5. Type Mapping Docs** | Reference | Manual updates | Design decisions, gaps | Medium |

**Recommended Minimum:** Guardrails #1, #3, #4 (JSON Schema + Contract Tests + CI/CD)

---

## 1️⃣ JSON Schema Generation (Compile-Time)

**What:** Generate JSON Schema from BendV3's Zod schemas, validate Flutter DTOs against it.

**How:**
```bash
# Generate schemas from BendV3
cd scripts
pnpm tsx generate_dto_schema.ts

# Run validation tests
flutter test test/core/data/models/dto_schema_compliance_test.dart
```

**Files Created:**
- `scripts/generate_dto_schema.ts` - Zod → JSON Schema converter
- `test/core/data/models/dto_schema_compliance_test.dart` - Validation tests
- `test/fixtures/bendv3_schemas.json` - Generated schemas (auto-generated)

**What It Catches:**
- ✅ Missing required fields
- ✅ Incorrect field types (string → int)
- ✅ Missing optional fields
- ✅ Enum value mismatches

**Example Failure:**
```dart
// BendV3 requires 'quality' field (0-100)
// Flutter DTO has 'qualityScore' instead
Expected: bookJson contains key 'quality'
  Actual: Missing field 'quality' in WorkDTO
```

**Setup:**
```bash
# 1. Install dependencies
cd scripts
pnpm add zod-to-json-schema

# 2. Generate schemas (run after every BendV3 update)
pnpm tsx generate_dto_schema.ts

# 3. Run tests
cd ..
flutter test test/core/data/models/dto_schema_compliance_test.dart
```

**Pros:**
- ⚡ Fast (runs in seconds)
- 🎯 Catches field-level mismatches
- 🔧 No API access required (works offline)

**Cons:**
- ⚠️ Requires BendV3 repo access
- 📝 Manual schema generation step

---

## 2️⃣ Type Sync Script (Documentation Reference)

**What:** Copy TypeScript type definitions from BendV3 to Flutter repo for reference.

**How:**
```bash
# Sync types from BendV3
./scripts/sync_types_from_bendv3.sh

# Or specify custom path
BENDV3_PATH=/path/to/bendv3 ./scripts/sync_types_from_bendv3.sh
```

**Files Created:**
- `scripts/sync_types_from_bendv3.sh` - Sync script
- `test/fixtures/bendv3_types/canonical.ts` - Synced WorkDTO/EditionDTO/AuthorDTO
- `test/fixtures/bendv3_types/enums.ts` - Synced enums
- `test/fixtures/bendv3_types/book-schema.ts` - Synced Zod schemas

**What It Catches:**
- 📚 API documentation drift
- 🔄 Field renames
- 🆕 New optional fields
- 🗑️ Deprecated fields

**Example Use Case:**
```bash
# You're implementing a new feature and need to reference canonical types
./scripts/sync_types_from_bendv3.sh

# Open reference files
cat test/fixtures/bendv3_types/canonical.ts | grep -A 20 "export interface WorkDTO"
```

**Pros:**
- 📖 Always have latest TypeScript types as reference
- 🔍 Easy to diff changes over time
- 🤝 Helps onboard new developers

**Cons:**
- 🕐 Manual sync required (recommend weekly)
- 📂 Doesn't validate Flutter code (documentation only)

---

## 3️⃣ Runtime Contract Tests (Integration Tests)

**What:** Test real API responses from BendV3 staging/production.

**How:**
```bash
# Test against staging
API_BASE_URL=https://staging-api.oooefam.net flutter test test/integration/api_contract_test.dart --tags integration

# Test against production
API_BASE_URL=https://api.oooefam.net flutter test test/integration/api_contract_test.dart --tags integration
```

**Files Created:**
- `test/integration/api_contract_test.dart` - Live API tests

**What It Catches:**
- 🌐 Real API response shape changes
- 🔢 Type mismatches in production data
- 🆕 New fields added to API
- 🗑️ Removed fields (breaking changes)
- 🐛 DTO deserialization errors

**Example Failure:**
```dart
// API added new field 'coverUrls' but Flutter DTO doesn't handle it
Expected: EditionDTO.fromJson(apiResponse) to succeed
  Actual: FormatException: Unexpected key 'coverUrls'
```

**Pros:**
- 🎯 Tests against REAL production data
- 🔍 Catches edge cases that unit tests miss
- 🌐 Validates API + DTO integration

**Cons:**
- ⏱️ Slower than unit tests (network latency)
- 🌐 Requires internet access
- 🔑 May require API authentication

**Best Practices:**
- Run against **staging** in CI (fast feedback)
- Run against **production** weekly (catch real drift)
- Use `@Tags(['integration'])` to separate from unit tests

---

## 4️⃣ CI/CD Validation Pipeline (Automation)

**What:** Automated checks on every PR + daily cron job.

**How:**
- Triggered on PR: Validates DTO changes before merge
- Triggered daily at 2 AM UTC: Catches API drift
- Manual trigger: `workflow_dispatch` for on-demand validation

**Files Created:**
- `.github/workflows/dto-validation.yml` - GitHub Actions workflow

**What It Runs:**
1. ✅ Checkout Flutter + BendV3 repos
2. ✅ Generate JSON schemas from BendV3 Zod
3. ✅ Sync TypeScript types
4. ✅ Run schema compliance tests
5. ✅ Run API contract tests (staging)
6. ✅ Comment on PR if validation fails

**Example PR Comment:**
```markdown
❌ **DTO Schema Validation Failed**

Your DTO changes are incompatible with BendV3 API schemas.

Please review:
- `test/fixtures/bendv3_schemas.json` for expected schema
- `test/core/data/models/dto_schema_compliance_test.dart` for failures

See [workflow logs](https://github.com/.../actions/runs/123) for details.
```

**Setup:**
```bash
# 1. Add BendV3 access token to GitHub Secrets
# Settings → Secrets → Actions → New secret
# Name: BENDV3_ACCESS_TOKEN
# Value: ghp_xxxxxxxxxxxxxxxxxxxxx

# 2. Optional: Add Slack webhook for production alerts
# Name: SLACK_WEBHOOK_URL
# Value: https://hooks.slack.com/services/xxxxx

# 3. Workflow is auto-triggered (no manual action needed)
```

**Pros:**
- 🤖 Fully automated (no manual intervention)
- 🚨 Catches drift within 24 hours (daily cron)
- 📝 PR comments guide developers to fix issues
- ⚡ Prevents breaking changes from merging

**Cons:**
- 🔑 Requires GitHub Actions + BendV3 repo access
- 💰 Consumes CI minutes (minimal - ~5 min/day)

---

## 5️⃣ Type Mapping Reference (Documentation)

**What:** Human-readable documentation of TypeScript → Dart mappings.

**How:**
- Read: `docs/api-integration/TYPE_MAPPING_REFERENCE.md`
- Update: Manually when adding new DTOs or fields

**What It Documents:**
- 📊 Field-by-field mapping tables
- 🔄 Type conversion rules (string → String, number → int)
- ⚠️ Known gaps and TODOs
- ✅ Validation checklists
- 📝 Code examples

**Example Entry:**
```markdown
| BendV3 Field | Type | Flutter Field | Status | Notes |
|--------------|------|---------------|--------|-------|
| `quality` | `number` (0-100) | `qualityScore` | ✅ | ⚠️ Renamed in Flutter |
| `coverUrls` | `MultiSizeCovers?` | ❌ Missing | 🔴 | **TODO: Add** |
```

**Pros:**
- 📖 Easy to review during code reviews
- 🎯 Documents design decisions ("why did we rename this?")
- ✅ Tracks gaps and TODOs
- 🤝 Helps onboard new developers

**Cons:**
- 📝 Manual updates required
- 🕐 Can go stale if not maintained

**Maintenance Schedule:**
- ✅ Update when adding new DTOs
- ✅ Update when modifying existing DTOs
- ✅ Review quarterly for accuracy

---

## 🚀 Quick Start Guide

### Initial Setup (One-Time)

```bash
# 1. Install dependencies
cd scripts
pnpm install

# 2. Generate JSON schemas
pnpm tsx generate_dto_schema.ts

# 3. Sync TypeScript types
cd ..
./scripts/sync_types_from_bendv3.sh

# 4. Run validation tests
flutter test test/core/data/models/dto_schema_compliance_test.dart
flutter test test/integration/api_contract_test.dart --tags integration

# 5. Configure GitHub Actions (one-time)
# - Add BENDV3_ACCESS_TOKEN secret
# - Add SLACK_WEBHOOK_URL secret (optional)
```

### Daily Workflow

**When modifying DTOs:**
```bash
# 1. Make changes to lib/core/data/models/dtos/*.dart

# 2. Run code generation
dart run build_runner build --delete-conflicting-outputs

# 3. Run schema validation
flutter test test/core/data/models/dto_schema_compliance_test.dart

# 4. Run contract tests (optional - CI will run)
flutter test test/integration/api_contract_test.dart --tags integration

# 5. Update TYPE_MAPPING_REFERENCE.md with changes

# 6. Commit (CI will validate on PR)
git add .
git commit -m "feat: Add coverUrls field to EditionDTO"
git push
```

**Weekly Maintenance:**
```bash
# Sync types from BendV3 (Sunday mornings)
./scripts/sync_types_from_bendv3.sh

# Check for new fields in canonical.ts
git diff test/fixtures/bendv3_types/canonical.ts

# Update DTOs if needed
# ... make changes ...

# Update TYPE_MAPPING_REFERENCE.md
```

---

## 📋 Validation Checklist (For PRs)

When adding/modifying DTOs, verify:

- [ ] **Guardrail #1:** Schema compliance tests pass
  ```bash
  flutter test test/core/data/models/dto_schema_compliance_test.dart
  ```

- [ ] **Guardrail #2:** TypeScript types synced (if BendV3 changed)
  ```bash
  ./scripts/sync_types_from_bendv3.sh
  ```

- [ ] **Guardrail #3:** Contract tests pass
  ```bash
  flutter test test/integration/api_contract_test.dart --tags integration
  ```

- [ ] **Guardrail #4:** CI pipeline passes (auto-checked on PR)

- [ ] **Guardrail #5:** TYPE_MAPPING_REFERENCE.md updated
  - [ ] Field mappings table updated
  - [ ] Known gaps documented
  - [ ] Code examples added (if needed)

- [ ] **Code Generation:** Runs without errors
  ```bash
  dart run build_runner build --delete-conflicting-outputs
  ```

- [ ] **Lint Checks:** Pass without warnings
  ```bash
  flutter analyze
  ```

---

## 🔍 Troubleshooting

### "BendV3 not found" Error

```bash
❌ BendV3 not found at: ../bendv3
Set BENDV3_PATH environment variable or clone bendv3 to ../bendv3
```

**Solution:**
```bash
# Option 1: Clone BendV3 to ../bendv3
cd ..
git clone https://github.com/your-org/bendv3.git
cd bookstrack-web

# Option 2: Set custom path
export BENDV3_PATH=/path/to/your/bendv3
./scripts/sync_types_from_bendv3.sh
```

### Schema Validation Fails

```dart
Expected: bookJson contains key 'quality'
  Actual: Missing field 'quality' in WorkDTO
```

**Solution:**
1. Check if BendV3 added a new required field
2. Add field to Flutter DTO
3. Re-run code generation
4. Update TYPE_MAPPING_REFERENCE.md

### Contract Tests Fail

```dart
Expected: response.statusCode = 200
  Actual: 404 - NOT_FOUND
```

**Solution:**
1. Check if API endpoint changed
2. Check if test ISBN is still valid
3. Update test data
4. Report to BendV3 team if breaking change

### CI Workflow Fails

**Solution:**
1. Check workflow logs on GitHub Actions
2. Verify `BENDV3_ACCESS_TOKEN` secret is set
3. Check if BendV3 API is accessible from CI
4. Re-run workflow manually if transient failure

---

## 📈 Metrics & Monitoring

### Success Metrics

- ✅ **Schema Coverage:** 40% → 80%+ (target: all canonical fields)
- ✅ **CI Pass Rate:** >95% (indicates stable schemas)
- ✅ **API Drift Detection:** <24 hours (daily cron catches changes)

### Alerts

**GitHub Actions:**
- 🚨 PR comment when validation fails
- 🚨 Daily cron failure (email notification)

**Slack (Optional):**
- ⚠️ Production contract test failure (weekly check)

---

## 🎯 Roadmap

### Phase 1: Foundation (Complete ✅)
- [x] JSON Schema generation script
- [x] Type sync script
- [x] Contract tests
- [x] CI/CD workflow
- [x] Type mapping reference

### Phase 2: Coverage (In Progress)
- [ ] Increase DTO coverage from 40% → 80%
- [ ] Add missing fields (coverUrls, bio, wikidata_id, etc.)
- [ ] Add external ID arrays (amazonASINs, goodreadsWorkIDs)

### Phase 3: Automation (Future)
- [ ] Auto-generate Dart DTOs from TypeScript interfaces
- [ ] Pre-commit hook to validate schemas locally
- [ ] Slack alerts for production drift

---

## 📚 See Also

- [BendV3 API Integration Guide](./BENDV3_API_INTEGRATION_GUIDE.md)
- [Type Mapping Reference](./TYPE_MAPPING_REFERENCE.md)
- [GitHub Workflow: DTO Validation](../../.github/workflows/dto-validation.yml)
- [BendV3 Canonical Types](https://github.com/your-org/bendv3/blob/main/src/types/canonical.ts)

---

**Last Updated:** 2026-01-05
**Maintainer:** Development Team
