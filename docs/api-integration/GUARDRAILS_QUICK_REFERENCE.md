# DTO Guardrails Quick Reference

**One-page cheat sheet for preventing DTO schema drift**

---

## 🚀 Quick Commands

```bash
# 1. Generate JSON schemas from BendV3 Zod
cd scripts && pnpm tsx generate_dto_schema.ts

# 2. Sync TypeScript type references
./scripts/sync_types_from_bendv3.sh

# 3. Validate schema compliance
flutter test test/core/data/models/dto_schema_compliance_test.dart

# 4. Test against live API
flutter test test/integration/api_contract_test.dart --tags integration

# 5. Check CI status
# → GitHub Actions auto-validates on every PR
```

---

## 📊 Guardrail Layers

| # | Guardrail | Catches | Speed | Manual? |
|---|-----------|---------|-------|---------|
| 1 | **JSON Schema** | Field mismatches | ⚡ Fast | Yes |
| 2 | **Type Sync** | API changes | ⚡ Fast | Yes |
| 3 | **Contract Tests** | Real API drift | 🐢 Slow | Optional |
| 4 | **CI/CD** | All of above | ⚡ Auto | No |
| 5 | **Docs** | Design gaps | 📝 Docs | Yes |

**Recommended:** Run #1 + #3 locally, rely on #4 for automation

---

## ✅ PR Checklist

Before merging DTO changes:

- [ ] Schema tests pass: `flutter test test/core/data/models/dto_schema_compliance_test.dart`
- [ ] Contract tests pass: `flutter test test/integration/api_contract_test.dart --tags integration`
- [ ] Code generation succeeds: `dart run build_runner build --delete-conflicting-outputs`
- [ ] Updated `TYPE_MAPPING_REFERENCE.md`
- [ ] CI pipeline passes (auto-checked)

---

## 🔍 Common Issues

### Missing BendV3 Repo
```bash
export BENDV3_PATH=/path/to/bendv3
./scripts/sync_types_from_bendv3.sh
```

### Schema Mismatch
```dart
// BendV3 added new field 'coverUrls'
// Add to EditionDTO:
@JsonKey(name: 'coverUrls')
Map<String, String>? coverUrls,
```

### Contract Test Fails
```bash
# Test against staging instead
API_BASE_URL=https://staging-api.oooefam.net flutter test test/integration/api_contract_test.dart --tags integration
```

---

## 📅 Weekly Maintenance

**Every Sunday:**
```bash
# 1. Sync latest types
./scripts/sync_types_from_bendv3.sh

# 2. Check for new fields
git diff test/fixtures/bendv3_types/canonical.ts

# 3. Update DTOs if needed
# 4. Update TYPE_MAPPING_REFERENCE.md
```

---

## 📚 Full Docs

- [DTO Sync Guardrails](./DTO_SYNC_GUARDRAILS.md) - Complete guide
- [Type Mapping Reference](./TYPE_MAPPING_REFERENCE.md) - Field mappings
- [BendV3 Integration](./BENDV3_API_INTEGRATION_GUIDE.md) - API guide
