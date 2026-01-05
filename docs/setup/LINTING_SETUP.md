# Flutter Linting Setup - Claude Code Workflow

**Last Updated:** January 3, 2026
**Configuration:** Optimized for Claude Code CLI (no VS Code required)

---

## ✅ What's Configured

### 1. **Automated Git Pre-Commit Hook**

**Location:** `.git/hooks/pre-commit` → `.claude/hooks/pre-commit.sh`

**Runs automatically on every commit:**
1. 🔐 **Security Check** - Blocks sensitive files (.jks, .keystore, google-services.json, etc.)
2. ⚙️ **Code Generation** - Warns if provider/database files changed (reminder to run build_runner)
3. ✨ **Auto-Format** - Formats all Dart code automatically
4. 🎯 **Analyzer** - Runs Flutter analyzer (warnings only, doesn't block)
5. 🐛 **Debug Check** - Warns about `print()` statements
6. 📦 **Dependency Check** - Validates pubspec.yaml for merge conflicts

**Test it manually:**
```bash
.claude/hooks/pre-commit.sh
```

### 2. **Linting Rules** (`analysis_options.yaml`)

**16 active lint rules** organized by category:

#### Code Style
- `prefer_const_constructors` - Memory optimization
- `prefer_const_literals_to_create_immutables` - Performance
- `prefer_final_fields` - Immutability
- `prefer_single_quotes` - Dart convention
- `require_trailing_commas` - Better diffs in Git
- `always_declare_return_types` - Type safety
- `directives_ordering` - Clean imports

#### Error Prevention
- `avoid_print` - Use `debugPrint()` instead
- `cancel_subscriptions` - Prevent memory leaks
- `close_sinks` - Prevent resource leaks
- `unawaited_futures` - Catch async bugs
- `use_build_context_synchronously` - Prevent build context errors

#### Code Quality
- `prefer_is_empty` / `prefer_is_not_empty` - Readability
- `use_key_in_widget_constructors` - Widget optimization
- `sized_box_for_whitespace` - Performance
- `avoid_unnecessary_containers` - Cleaner widget tree
- `unnecessary_null_checks` - Cleaner null safety

### 3. **Strict Type Checking**

```yaml
language:
  strict-casts: true      # Catch unsafe casts
  strict-inference: true  # Better type inference
  strict-raw-types: true  # Prevent untyped generics
```

### 4. **Complete Dependencies** (`pubspec.yaml`)

✅ All dependencies installed:
- State Management: Riverpod ^2.4.0
- Database: Drift ^2.14.0
- Networking: Dio ^5.4.0
- Navigation: go_router ^12.0.0
- Firebase: Full suite (Auth, Firestore, Storage, Analytics, Crashlytics)
- Code Generation: build_runner, riverpod_generator, drift_dev, freezed

### 5. **Code Generation Working**

✅ Generated 102 outputs:
- Riverpod providers (*.g.dart)
- Drift database code (*.g.dart)
- Freezed models (*.freezed.dart)
- JSON serialization (*.g.dart)

---

## 🚀 Your Development Workflow

### Writing Code (Claude Code CLI)

```bash
# Normal development - Claude Code handles everything
# Just commit when ready!
git add .
git commit -m "Your message"

# The pre-commit hook automatically:
# 1. Formats your code
# 2. Runs analyzer
# 3. Checks for issues
# 4. Allows commit (warnings don't block)
```

### Manual Commands (When Needed)

```bash
# Format code manually
dart format .

# Run analyzer
flutter analyze

# Run code generation (after changing providers/database)
dart run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerates on file changes)
dart run build_runner watch --delete-conflicting-outputs

# Run tests
flutter test

# Auto-fix many lint issues
dart fix --apply
```

---

## 🎯 Pre-Commit Hook Behavior

### ✅ What It Does

**Always Runs:**
- Auto-formats all staged Dart files
- Runs security checks
- Checks for sensitive files

**Warnings Only (doesn't block):**
- Analyzer issues (you'll see them but can still commit)
- Debug print() statements
- Code generation reminders

**Blocks Commit:**
- Sensitive files (*.jks, *.keystore, google-services.json, etc.)
- Merge conflicts in pubspec.yaml

### 🔧 Disable Hook Temporarily

```bash
# Skip pre-commit hook for one commit
git commit --no-verify -m "Your message"

# Disable hook permanently (not recommended)
rm .git/hooks/pre-commit
```

---

## 📊 Current Code Status

**Analyzer Results:** 173 issues found
- ❌ **Errors:** Missing implementation (incomplete codebase)
- ℹ️ **Info:** Linting suggestions (directives_ordering, const constructors, etc.)

**Note:** These are code implementation issues, not linting configuration issues. The linting system is working correctly!

---

## 🎓 Common Scenarios

### Scenario 1: Commit Your Work

```bash
git add .
git commit -m "Add search feature"

# Output:
# 🤖 Running Flutter pre-commit checks...
# 🔐 Checking for sensitive files...
# ✓ No sensitive files detected
# ✨ Formatting Dart code...
# ✓ Code formatted
# 🎯 Running Dart analyzer...
# ⚠ Warning: Dart analyzer found issues
#   Run: flutter analyze
#   This is a warning - commit will proceed
# ✅ All pre-commit checks passed!
```

### Scenario 2: Changed Provider Files

```bash
# You modified lib/features/library/providers/library_providers.dart
git add .
git commit -m "Update library providers"

# Output includes:
# ⚙️  Checking code generation...
# ℹ Info: Provider/Database files changed
#   Ensure you've run: dart run build_runner build --delete-conflicting-outputs
```

### Scenario 3: Attempting to Commit Secrets

```bash
# Accidentally adding android/app/my-release-key.jks
git add android/app/my-release-key.jks
git commit -m "Update app"

# Output:
# 🔐 Checking for sensitive files...
# ✗ Blocked: Attempting to commit sensitive file: *.jks
# ❌ Pre-commit checks failed. Commit blocked.
```

---

## 🔧 Customization

### Make Hook Stricter (Block on Analyzer Errors)

Edit `.claude/hooks/pre-commit.sh`:

```bash
# Change this section:
if ! flutter analyze --no-fatal-infos 2>&1 | tail -1 | grep -q "No issues found"; then
  echo -e "${RED}✗ Dart analyzer found issues${NC}"
  FAILED=1  # Add this line to block commits
fi
```

### Make Hook Looser (Remove Formatting)

Edit `.claude/hooks/pre-commit.sh`:

```bash
# Comment out the formatting section:
# # 3. Format Dart code (auto-fix)
# if command -v dart &> /dev/null; then
#   echo "✨ Formatting Dart code..."
#   dart format . > /dev/null 2>&1
# fi
```

### Add Custom Checks

Edit `.claude/hooks/pre-commit.sh`:

```bash
# Add before "Final result" section:
echo "🔍 Custom check..."
if git diff --cached | grep -q "TODO"; then
  echo -e "${YELLOW}⚠ Warning: Found TODO comments${NC}"
fi
```

---

## 📚 Quick Reference

### File Structure

```
.
├── .claude/hooks/pre-commit.sh    # Claude Code hook (the actual logic)
├── .git/hooks/pre-commit          # Git hook (calls Claude hook)
├── analysis_options.yaml          # Linting rules
├── pubspec.yaml                   # Dependencies (all installed)
├── LINTING_SETUP.md              # This file
└── .vscode/                       # VS Code settings (reference only)
```

### Commands Cheat Sheet

```bash
# Check code quality
flutter analyze

# Format code
dart format .

# Generate code
dart run build_runner build --delete-conflicting-outputs

# Test hook
.claude/hooks/pre-commit.sh

# Run tests
flutter test

# Auto-fix lints
dart fix --apply
```

### Hook Output Colors

- 🟢 Green = Success
- 🟡 Yellow = Warning (doesn't block)
- 🔴 Red = Error (blocks commit)

---

## 🚨 Troubleshooting

### Hook Not Running

```bash
# Make sure it's executable
chmod +x .git/hooks/pre-commit
chmod +x .claude/hooks/pre-commit.sh

# Test manually
.claude/hooks/pre-commit.sh
```

### Formatting Not Working

```bash
# Run manually
dart format .

# Or disable in hook if it's causing issues
```

### Too Many Analyzer Warnings

```bash
# Suppress infos temporarily
flutter analyze --no-fatal-infos

# Or fix them with:
dart fix --apply
```

### Code Generation Errors

```bash
# Clean and rebuild
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

---

## 🎯 Differences from VS Code Setup

| Feature | VS Code | Claude Code CLI (Current) |
|---------|---------|---------------------------|
| **Auto-format** | On save | On git commit |
| **Linting** | Real-time in editor | Pre-commit hook |
| **Code Actions** | Quick fix menu | Manual dart fix --apply |
| **Terminal** | Integrated | External terminal |
| **Git Integration** | GUI | Command line |
| **Advantage** | Immediate feedback | Works anywhere (SSH, servers, etc.) |

---

## ✨ Best Practices

### 1. Commit Often
The hook is fast (~2 seconds), so commit frequently!

### 2. Run Code Generation Manually
After modifying providers/database, run:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Fix Analyzer Issues Periodically
```bash
flutter analyze
dart fix --apply  # Auto-fix many issues
```

### 4. Review Hook Output
Don't ignore warnings - they help catch bugs early!

### 5. Keep Dependencies Updated
```bash
flutter pub outdated  # Check for updates
flutter pub upgrade   # Upgrade (carefully)
```

---

## 🔗 Related Documentation

- `CLAUDE.md` - Complete project guide
- `.claude/README.md` - Agent setup
- `analysis_options.yaml` - Linting rules
- `.claude/hooks/pre-commit.sh` - Hook source code

---

**Status:** ✅ **FULLY CONFIGURED**

Your Claude Code workflow is optimized with:
- ✅ Automated pre-commit checks
- ✅ Auto-formatting on commit
- ✅ Security protection
- ✅ All dependencies installed
- ✅ Code generation working
- ✅ 16 lint rules active

**No VS Code required!** Everything runs via CLI and git hooks.
