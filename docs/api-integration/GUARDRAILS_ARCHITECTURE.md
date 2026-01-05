# DTO Guardrails Architecture

**Visual reference for the 5-layer guardrail system**

---

## 🏗️ System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        BendV3 Backend                            │
│                                                                   │
│  ┌──────────────────┐        ┌──────────────────┐               │
│  │ TypeScript Types │        │  Zod Schemas     │               │
│  │                  │        │                  │               │
│  │ canonical.ts     │        │ book.ts          │               │
│  │ - WorkDTO        │        │ - BookSchema     │               │
│  │ - EditionDTO     │        │ - ErrorSchema    │               │
│  │ - AuthorDTO      │        │ - SearchSchema   │               │
│  └──────────────────┘        └──────────────────┘               │
│           │                           │                          │
└───────────┼───────────────────────────┼──────────────────────────┘
            │                           │
            │                           │
            ▼                           ▼
   ┌────────────────┐          ┌────────────────┐
   │ Type Sync      │          │ JSON Schema    │
   │ Script         │          │ Generator      │
   │                │          │                │
   │ sync_types_    │          │ generate_dto_  │
   │ from_bendv3.sh │          │ schema.ts      │
   └────────────────┘          └────────────────┘
            │                           │
            │                           │
            ▼                           ▼
   ┌────────────────┐          ┌────────────────┐
   │ TS Reference   │          │ JSON Schema    │
   │ Copies         │          │ Output         │
   │                │          │                │
   │ test/fixtures/ │          │ bendv3_        │
   │ bendv3_types/  │          │ schemas.json   │
   └────────────────┘          └────────────────┘
            │                           │
            │                           │
            ▼                           ▼
   ┌────────────────────────────────────────────┐
   │         Flutter DTOs (Source of Truth)      │
   │                                             │
   │  lib/core/data/models/dtos/                │
   │  ├── work_dto.dart                         │
   │  ├── edition_dto.dart                      │
   │  └── author_dto.dart                       │
   │                                             │
   │  (Freezed + JSON serialization)            │
   └────────────────────────────────────────────┘
                       │
                       │
         ┌─────────────┼─────────────┐
         │             │             │
         ▼             ▼             ▼
┌────────────┐ ┌────────────┐ ┌────────────┐
│ Schema     │ │ Contract   │ │ Type       │
│ Compliance │ │ Tests      │ │ Mapping    │
│ Tests      │ │            │ │ Reference  │
│            │ │ API calls  │ │            │
│ Validate   │ │ against    │ │ Human-     │
│ against    │ │ staging/   │ │ readable   │
│ JSON       │ │ production │ │ docs       │
│ schemas    │ │            │ │            │
└────────────┘ └────────────┘ └────────────┘
         │             │             │
         └─────────────┼─────────────┘
                       │
                       ▼
              ┌────────────────┐
              │ CI/CD Pipeline │
              │                │
              │ GitHub Actions │
              │ - PR checks    │
              │ - Daily cron   │
              │ - Slack alerts │
              └────────────────┘
```

---

## 🔄 Data Flow

### 1. Schema Generation Flow

```
BendV3 Zod Schema (book.ts)
    │
    │ [pnpm tsx generate_dto_schema.ts]
    │
    ▼
JSON Schema (bendv3_schemas.json)
    │
    │ [flutter test dto_schema_compliance_test.dart]
    │
    ▼
✅ Validation Pass/Fail
```

### 2. Type Sync Flow

```
BendV3 TypeScript (canonical.ts)
    │
    │ [./scripts/sync_types_from_bendv3.sh]
    │
    ▼
Reference Copy (test/fixtures/bendv3_types/)
    │
    │ [Manual review + documentation]
    │
    ▼
📚 Developer Reference
```

### 3. Contract Testing Flow

```
BendV3 API (staging/production)
    │
    │ [HTTP GET /v3/books/:isbn]
    │
    ▼
JSON Response
    │
    │ [DTO.fromJson()]
    │
    ▼
✅ Deserialization Pass/Fail
```

### 4. CI/CD Flow

```
PR Created (DTO changes)
    │
    ▼
GitHub Actions Triggered
    │
    ├── Checkout repos (Flutter + BendV3)
    ├── Generate JSON schemas
    ├── Sync TypeScript types
    ├── Run schema compliance tests
    └── Run contract tests (staging)
    │
    ▼
✅ Pass → Merge allowed
❌ Fail → PR comment + block merge
```

---

## 🎯 Guardrail Layers (Detail)

### Layer 1: JSON Schema (Compile-Time)

**Purpose:** Validate Flutter DTOs match Zod schemas at compile-time

**Process:**
1. Read BendV3 Zod schemas (`src/api-v3/schemas/book.ts`)
2. Convert to JSON Schema using `zod-to-json-schema`
3. Save to `test/fixtures/bendv3_schemas.json`
4. Dart tests validate DTO fields against JSON schema

**Catches:**
- Missing required fields
- Type mismatches (string → int)
- Enum value differences

**Example:**
```typescript
// BendV3: book.ts
export const BookSchema = z.object({
  isbn: z.string().length(13),
  quality: z.number().min(0).max(100),
})
```
↓ converts to ↓
```json
{
  "type": "object",
  "properties": {
    "isbn": { "type": "string", "minLength": 13, "maxLength": 13 },
    "quality": { "type": "number", "minimum": 0, "maximum": 100 }
  },
  "required": ["isbn", "quality"]
}
```
↓ validated against ↓
```dart
class EditionDTO {
  final String isbn;
  final int? qualityScore; // ❌ MISMATCH: 'quality' vs 'qualityScore'
}
```

---

### Layer 2: Type Sync (Documentation)

**Purpose:** Keep reference copy of TypeScript types for human review

**Process:**
1. Copy `src/types/canonical.ts` → `test/fixtures/bendv3_types/`
2. Copy `src/types/enums.ts` → `test/fixtures/bendv3_types/`
3. Copy `src/api-v3/schemas/book.ts` → `test/fixtures/bendv3_types/`
4. Add warning headers with sync timestamp

**Catches:**
- API documentation changes
- Field renames
- New optional fields

**Example:**
```typescript
// test/fixtures/bendv3_types/canonical.ts
/**
 * SYNCED FROM BENDV3 - DO NOT EDIT
 * Synced: 2026-01-05T12:00:00Z
 */

export interface WorkDTO {
  title: string
  subjectTags: string[]
  coverUrls?: { large: string; medium: string; small: string } // NEW!
}
```

---

### Layer 3: Contract Tests (Runtime)

**Purpose:** Validate real API responses match DTO expectations

**Process:**
1. Make HTTP request to BendV3 API
2. Parse JSON response
3. Attempt `DTO.fromJson()` deserialization
4. Assert response shape matches schema

**Catches:**
- Real API changes (production drift)
- Edge cases in real data
- Serialization errors

**Example:**
```dart
test('GET /v3/books/:isbn returns valid Book', () async {
  final response = await dio.get('/v3/books/9780439708180');

  expect(response.statusCode, 200);
  expect(response.data['success'], true);

  final bookData = response.data['data'];
  expect(bookData['isbn'], isA<String>());
  expect(bookData['quality'], inInclusiveRange(0, 100));
});
```

---

### Layer 4: CI/CD (Automation)

**Purpose:** Run all validations automatically on every PR + daily

**Process:**
1. **PR Trigger:** Validate DTO changes before merge
2. **Daily Cron:** Catch API drift within 24 hours
3. **Manual Dispatch:** On-demand validation

**Catches:**
- All of Layer 1 + 2 + 3
- Prevents breaking changes from merging
- Alerts on production drift

**Example Workflow:**
```yaml
on:
  pull_request:
    paths: ['lib/core/data/models/dtos/**']
  schedule:
    - cron: '0 2 * * *' # Daily at 2 AM UTC
  workflow_dispatch:

jobs:
  validate:
    steps:
      - Generate JSON schemas
      - Sync TypeScript types
      - Run schema tests
      - Run contract tests (staging)
      - Comment on PR if fail
```

---

### Layer 5: Documentation (Human Reference)

**Purpose:** Maintain human-readable mapping reference

**Process:**
1. Document field-by-field TypeScript → Dart mappings
2. Track known gaps and TODOs
3. Provide code examples
4. Update on every DTO change

**Catches:**
- Design decisions ("why did we rename this?")
- Coverage gaps (missing fields)
- Migration path for new fields

**Example:**
```markdown
| BendV3 Field | Type | Flutter Field | Status | Notes |
|--------------|------|---------------|--------|-------|
| `quality` | `number` (0-100) | `qualityScore` | ✅ | ⚠️ Renamed in Flutter |
| `coverUrls` | `MultiSizeCovers?` | ❌ Missing | 🔴 | **TODO: Add** |
```

---

## 📊 Coverage Matrix

| Entity | BendV3 Fields | Flutter Fields | Coverage | Status |
|--------|---------------|----------------|----------|--------|
| **WorkDTO** | 25 | 10 | 40% | 🟡 Partial |
| **EditionDTO** | 22 | 8 | 36% | 🟡 Partial |
| **AuthorDTO** | 14 | 5 | 36% | 🟡 Partial |
| **Overall** | 61 | 23 | 38% | 🟡 Partial |

**Target:** 80%+ coverage by Q2 2026

---

## 🚀 Future Enhancements

### Phase 1: Automation (Q1 2026)
- [ ] Auto-generate Dart DTOs from TypeScript interfaces
- [ ] Pre-commit hook for local validation
- [ ] VS Code extension for real-time schema hints

### Phase 2: Intelligence (Q2 2026)
- [ ] ML-based schema drift prediction
- [ ] Auto-suggest DTO updates based on API changes
- [ ] Breaking change impact analysis

### Phase 3: Scale (Q3 2026)
- [ ] Multi-repo sync (iOS, Android, Web)
- [ ] Centralized schema registry
- [ ] Version compatibility matrix

---

## 📚 See Also

- [DTO Sync Guardrails](./DTO_SYNC_GUARDRAILS.md) - Complete implementation guide
- [Guardrails Quick Reference](./GUARDRAILS_QUICK_REFERENCE.md) - Command cheat sheet
- [Type Mapping Reference](./TYPE_MAPPING_REFERENCE.md) - Field mappings
