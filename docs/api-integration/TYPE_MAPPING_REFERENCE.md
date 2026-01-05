# Type Mapping Reference: BendV3 ↔ Flutter

**Last Updated:** 2026-01-05
**BendV3 Version:** v3.0.0
**Flutter Version:** 3.x

This document maintains the canonical mapping between BendV3 TypeScript types and Flutter Dart types.

---

## 🎯 Quick Reference

| BendV3 Schema | Flutter DTO | Source Files |
|---------------|-------------|--------------|
| `BookSchema` (Zod) | `EditionDTO` + `WorkDTO` | `bendv3/src/api-v3/schemas/book.ts` → `lib/core/data/models/dtos/` |
| `WorkDTO` (canonical.ts) | `WorkDTO` | `bendv3/src/types/canonical.ts:26-70` |
| `EditionDTO` (canonical.ts) | `EditionDTO` | `bendv3/src/types/canonical.ts:76-113` |
| `AuthorDTO` (canonical.ts) | `AuthorDTO` | `bendv3/src/types/canonical.ts:119-145` |

---

## 📦 Book Schema (V3 API)

**Source:** `bendv3/src/api-v3/schemas/book.ts`
**Destination:** `EditionDTO` + `WorkDTO` (requires mapping)

### Field Mapping

| BendV3 Field | Type | Flutter Field | DTO | Notes |
|--------------|------|---------------|-----|-------|
| `isbn` | `string` (13 chars) | `isbn` | `EditionDTO` | Primary identifier |
| `isbn10` | `string?` (10 chars) | `isbn10` | `EditionDTO` | Optional 10-digit ISBN |
| `title` | `string` | `title` | `WorkDTO` | **Maps to Work, not Edition** |
| `subtitle` | `string?` | `subtitle` | Both | Exists on both DTOs |
| `authors` | `string[]` | `author` (denorm) | `WorkDTO` | Join with `, ` |
| `authors` | `string[]` | `authorIds` | `WorkDTO` | **Requires lookup** |
| `publisher` | `string?` | `publisher` | `EditionDTO` | |
| `publishedDate` | `string?` | `publishedYear` | `EditionDTO` | **Parse year only** |
| `description` | `string?` | `description` | Both | Exists on both DTOs |
| `pageCount` | `number?` | `pageCount` | `EditionDTO` | |
| `categories` | `string[]?` | `categories` | Both | Defaults to `[]` |
| `language` | `string?` | `language` | `EditionDTO` | ISO 639-1 code |
| `coverUrl` | `string?` (URL) | `coverImageURL` | Both | Exists on both DTOs |
| `thumbnailUrl` | `string?` (URL) | `thumbnailURL` | `EditionDTO` | ⚠️ Note camelCase |
| `workKey` | `string?` | `workKey` | `WorkDTO` | OpenLibrary work key |
| `editionKey` | `string?` | `editionKey` | `EditionDTO` | OpenLibrary edition key |
| `provider` | `DataProvider` | `provider` | `WorkDTO` | Enum: alexandria, google_books, etc. |
| `quality` | `number` (0-100) | `qualityScore` | `WorkDTO` | ⚠️ Renamed in Flutter |

### Data Provider Enum

**BendV3:** `src/api-v3/schemas/book.ts:44-45`
```typescript
provider: z.enum(['alexandria', 'google_books', 'open_library', 'isbndb'])
```

**Flutter:** `lib/core/data/models/enums/data_provider.dart`
```dart
enum DataProvider {
  alexandria,
  googleBooks,  // ⚠️ Camel case in Dart
  openLibrary,
  isbndb,
}
```

**Mapping:** Use `@JsonValue` to map snake_case → camelCase:
```dart
@JsonEnum(fieldRename: FieldRename.snake)
enum DataProvider {
  alexandria,
  @JsonValue('google_books') googleBooks,
  @JsonValue('open_library') openLibrary,
  isbndb,
}
```

---

## 📚 Canonical DTOs

### WorkDTO Mapping

**Source:** `bendv3/src/types/canonical.ts:26-70`
**Destination:** `lib/core/data/models/dtos/work_dto.dart`

| BendV3 Field | Type | Flutter Field | Status | Notes |
|--------------|------|---------------|--------|-------|
| `title` | `string` | `title` | ✅ | Required |
| `subjectTags` | `string[]` | `subjectTags` | ✅ | Required |
| `originalLanguage` | `string?` | ❌ Missing | 🔴 | **TODO: Add to Flutter DTO** |
| `firstPublicationYear` | `number?` | ❌ Missing | 🔴 | **TODO: Add to Flutter DTO** |
| `description` | `string?` | `description` | ✅ | |
| `coverImageURL` | `string?` | ❌ Missing | 🟡 | **Use Edition's coverImageURL** |
| `coverUrls` | `MultiSizeCovers?` | ❌ Missing | 🔴 | **TODO: Add for Alexandria v2.2.4+** |
| `coverSource` | `CoverSource?` | ❌ Missing | 🔴 | **TODO: Add** |
| `synthetic` | `boolean?` | `synthetic` | ✅ | Defaults to `false` |
| `primaryProvider` | `DataProvider?` | `provider` | ✅ | Renamed in Flutter |
| `contributors` | `DataProvider[]?` | ❌ Missing | 🔴 | **TODO: Add** |
| `openLibraryID` | `string?` | ❌ Missing | 🔴 | **Legacy ID - add if needed** |
| `openLibraryWorkID` | `string?` | `workKey` | ✅ | Renamed in Flutter |
| `goodreadsWorkIDs` | `string[]` | ❌ Missing | 🔴 | **TODO: Add** |
| `amazonASINs` | `string[]` | ❌ Missing | 🔴 | **TODO: Add** |
| `librarythingIDs` | `string[]` | ❌ Missing | 🔴 | **TODO: Add** |
| `googleBooksVolumeIDs` | `string[]` | ❌ Missing | 🔴 | **TODO: Add** |
| `isbndbQuality` | `number` | `qualityScore` | ✅ | Renamed in Flutter |
| `lastISBNDBSync` | `string?` | ❌ Missing | 🔴 | **TODO: Add** |
| `reviewStatus` | `ReviewStatus` | `reviewStatus` | ✅ | |
| `originalImagePath` | `string?` | ❌ Missing | 🔴 | **TODO: Add for AI scans** |
| `boundingBox` | `BoundingBox?` | ❌ Missing | 🔴 | **TODO: Add for AI scans** |

**Coverage:** 10/25 fields (40%) ⚠️

### EditionDTO Mapping

**Source:** `bendv3/src/types/canonical.ts:76-113`
**Destination:** `lib/core/data/models/dtos/edition_dto.dart`

| BendV3 Field | Type | Flutter Field | Status | Notes |
|--------------|------|---------------|--------|-------|
| `isbn` | `string?` | `isbn` | ✅ | Primary ISBN |
| `isbns` | `string[]` | ❌ Missing | 🔴 | **TODO: Add array of all ISBNs** |
| `title` | `string?` | ❌ Missing | 🟡 | **Use Work's title** |
| `publisher` | `string?` | `publisher` | ✅ | |
| `publicationDate` | `string?` | ❌ Missing | 🟡 | **Use `publishedYear` instead** |
| `pageCount` | `number?` | `pageCount` | ✅ | |
| `format` | `EditionFormat` | `format` | ✅ | |
| `coverImageURL` | `string?` | `coverImageURL` | ✅ | |
| `coverUrls` | `MultiSizeCovers?` | ❌ Missing | 🔴 | **TODO: Add** |
| `coverSource` | `CoverSource?` | ❌ Missing | 🔴 | **TODO: Add** |
| `editionTitle` | `string?` | `subtitle` | ⚠️ | **Mapping unclear** |
| `editionDescription` | `string?` | `description` | ⚠️ | **Mapping unclear** |
| `language` | `string?` | `language` | ✅ | |
| `primaryProvider` | `DataProvider?` | ❌ Missing | 🔴 | **TODO: Add** |
| `contributors` | `DataProvider[]?` | ❌ Missing | 🔴 | **TODO: Add** |
| `openLibraryID` | `string?` | ❌ Missing | 🔴 | **Legacy ID** |
| `openLibraryEditionID` | `string?` | `editionKey` | ✅ | Renamed in Flutter |
| `amazonASINs` | `string[]` | ❌ Missing | 🔴 | **TODO: Add** |
| `googleBooksVolumeIDs` | `string[]` | ❌ Missing | 🔴 | **TODO: Add** |
| `librarythingIDs` | `string[]` | ❌ Missing | 🔴 | **TODO: Add** |
| `isbndbQuality` | `number` | ❌ Missing | 🔴 | **TODO: Add** |
| `lastISBNDBSync` | `string?` | ❌ Missing | 🔴 | **TODO: Add** |

**Coverage:** 8/22 fields (36%) ⚠️

### AuthorDTO Mapping

**Source:** `bendv3/src/types/canonical.ts:119-145`
**Destination:** `lib/core/data/models/dtos/author_dto.dart`

| BendV3 Field | Type | Flutter Field | Status | Notes |
|--------------|------|---------------|--------|-------|
| `name` | `string` | `name` | ✅ | Required |
| `gender` | `AuthorGender` | `gender` | ✅ | |
| `culturalRegion` | `CulturalRegion?` | `culturalRegion` | ✅ | |
| `nationality` | `string?` | ❌ Missing | 🔴 | **TODO: Add** |
| `birthYear` | `number?` | ❌ Missing | 🔴 | **Use `birthDate` year** |
| `deathYear` | `number?` | ❌ Missing | 🔴 | **Use `deathDate` year** |
| `bio` | `string?` | ❌ Missing | 🔴 | **TODO: Add (Alexandria v2.2.3+)** |
| `wikidata_id` | `string?` | ❌ Missing | 🔴 | **TODO: Add** |
| `image` | `string?` | ❌ Missing | 🔴 | **TODO: Add (author photo)** |
| `key` | `string?` | ❌ Missing | 🔴 | **TODO: Add (OpenLibrary key)** |
| `openlibrary` | `string?` | ❌ Missing | 🔴 | **TODO: Add (OpenLibrary URL)** |
| `openLibraryID` | `string?` | `openLibraryId` | ✅ | |
| `goodreadsID` | `string?` | `goodreadsId` | ✅ | |
| `bookCount` | `number?` | ❌ Missing | 🔴 | **TODO: Add** |

**Coverage:** 5/14 fields (36%) ⚠️

---

## 🔧 Type Conversion Rules

### TypeScript → Dart

| TypeScript Type | Dart Type | Notes |
|-----------------|-----------|-------|
| `string` | `String` | |
| `string?` | `String?` | |
| `number` | `int` or `double` | Use `int` for counts, `double` for decimals |
| `boolean` | `bool` | |
| `string[]` | `List<String>` | Default to `@Default([])` |
| `Date` | `DateTime` | Parse ISO 8601 strings |
| `enum` | `enum` | Use `@JsonEnum(fieldRename: FieldRename.snake)` |
| `interface` | `@freezed class` | Use Freezed for immutability |
| `Record<string, any>` | `Map<String, dynamic>` | |

### Date Handling

**BendV3:**
```typescript
lastISBNDBSync?: string // ISO 8601: "2024-01-01T12:00:00Z"
publicationDate?: string // Partial: "1998" or "1998-09-01"
```

**Flutter:**
```dart
@JsonKey(name: 'lastISBNDBSync')
DateTime? lastIsbndbSync;

// For partial dates, use custom converter
@JsonKey(fromJson: _parsePartialDate)
DateTime? publicationDate;

static DateTime? _parsePartialDate(dynamic value) {
  if (value == null) return null;
  if (value is! String) return null;
  // Parse "YYYY", "YYYY-MM", or "YYYY-MM-DD"
  return DateTime.tryParse(value);
}
```

### Enum Handling

**BendV3:** `src/types/enums.ts`
```typescript
export type DataProvider = 'alexandria' | 'google_books' | 'open_library' | 'isbndb'
```

**Flutter:** `lib/core/data/models/enums/data_provider.dart`
```dart
@JsonEnum(fieldRename: FieldRename.snake)
enum DataProvider {
  alexandria,
  @JsonValue('google_books') googleBooks,
  @JsonValue('open_library') openLibrary,
  isbndb,
}
```

---

## ✅ Validation Checklist

When adding/modifying DTOs, verify:

- [ ] All required fields from BendV3 schema are present
- [ ] Field names match (accounting for camelCase/snake_case)
- [ ] Types are correctly mapped (string → String, number → int/double)
- [ ] Enums use `@JsonValue` for snake_case mapping
- [ ] Date fields use `DateTime` type
- [ ] Arrays default to empty lists with `@Default([])`
- [ ] Nullable fields use `?` operator
- [ ] `fromJson` factory method exists
- [ ] Code generation runs without errors: `dart run build_runner build`
- [ ] Schema compliance tests pass: `flutter test test/core/data/models/dto_schema_compliance_test.dart`
- [ ] API contract tests pass: `flutter test test/integration/api_contract_test.dart`

---

## 🚨 Known Gaps & TODOs

### High Priority (Blocking Features)
1. ❌ **Multi-size cover URLs** - Required for responsive images (Alexandria v2.2.4+)
2. ❌ **Author enrichment fields** - Required for diversity insights (bio, photo, wikidata_id)
3. ❌ **External ID arrays** - Required for cross-platform sync (amazonASINs, goodreadsWorkIDs, etc.)

### Medium Priority (Nice to Have)
4. ❌ **Cover source tracking** - Useful for cache debugging
5. ❌ **Contributor tracking** - Nice for provenance display
6. ❌ **ISBNDB quality/sync** - Useful for data quality monitoring

### Low Priority (Future)
7. ❌ **Bounding box & image paths** - Only needed for AI scan review queue
8. ❌ **Book count on authors** - Only needed for author pages

---

## 📚 See Also

- [BendV3 API Integration Guide](./BENDV3_API_INTEGRATION_GUIDE.md)
- [DTO Schema Compliance Tests](../../test/core/data/models/dto_schema_compliance_test.dart)
- [API Contract Tests](../../test/integration/api_contract_test.dart)
- [BendV3 Canonical Types](../../test/fixtures/bendv3_types/canonical.ts) (synced reference)

---

**Maintenance:** Run `./scripts/sync_types_from_bendv3.sh` weekly to update reference types.
