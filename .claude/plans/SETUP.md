# Plans Directory Setup

## Configuration

**Mode:** Native Claude Code plan mode (no plugin required)
**Directory:** `.claude/plans/`
**Settings:** `.claude/settings.json`

```json
{
  "plansDirectory": ".claude/plans"
}
```

## How It Works

### Native Plan Mode
Claude Code (v2.0+) automatically uses `.claude/plans/` when:
1. You start a complex task requiring multiple steps
2. Architecture decisions need documentation
3. The planning-with-files skill is invoked

**No plugin installation required** - this is a built-in feature.

### File Structure
```
.claude/plans/
├── README.md           # This documentation
├── SETUP.md            # Setup instructions (you are here)
├── task_plan.md        # Current task breakdown (ephemeral)
├── findings.md         # Technical discoveries (ephemeral)
└── progress.md         # Status tracking (ephemeral)
```

### Git Integration
Planning files are **automatically ignored** via root `.gitignore`:
```gitignore
# Claude Code planning files (both root and .claude/plans/)
task_plan.md
findings.md
progress.md
.claude/plans/task_plan.md
.claude/plans/findings.md
.claude/plans/progress.md
```

## Usage

### Starting a Plan
```bash
# Option 1: Invoke planning skill
/skill planning-with-files

# Option 2: Natural language
"Let's plan out the new search feature implementation"

# Option 3: Direct instruction
"Create a task_plan.md for migrating to Riverpod 2.0"
```

### During Development
Claude Code will:
- Automatically update `task_plan.md` as strategy evolves
- Record findings in `findings.md` (architecture, API quirks)
- Track progress in `progress.md` (blockers, next steps)

### Cleanup
```bash
# Delete when task is complete
rm .claude/plans/task_plan.md
rm .claude/plans/findings.md
rm .claude/plans/progress.md

# Or archive important findings
mv .claude/plans/findings.md docs/architecture/search-architecture.md
```

## Flutter-Specific Setup

### Recommended Tools
Install these for enhanced planning:
- `flutter_lints` - Enforces best practices
- `build_runner` - Code generation awareness
- `dart analyze` - Static analysis integration

### VS Code Integration (Optional)
Add to `.vscode/settings.json`:
```json
{
  "dart.lineLength": 100,
  "dart.runPubGetOnPubspecChanges": true,
  "dart.previewFlutterUiGuides": true,
  "dart.previewFlutterUiGuidesCustomTracking": true,
  "[dart]": {
    "editor.formatOnSave": true,
    "editor.rulers": [100]
  }
}
```

### Pre-Commit Hook
Ensure `.claude/hooks/pre-commit.sh` is active:
```bash
# Test the hook
.claude/hooks/pre-commit.sh

# Should auto-format Dart files during planning
```

## Planning Workflow Example

### 1. Start Planning Session
```
User: "Let's implement the book search feature with Riverpod and dio"
Claude: Creates task_plan.md with:
  - Widget tree design
  - State management plan (Riverpod providers)
  - API integration plan (dio interceptors)
  - Navigation plan (go_router routes)
```

### 2. Discover Constraints
```
Claude: Updates findings.md with:
  - Dio requires BaseOptions for auth headers
  - go_router nested routes need unique keys
  - Riverpod AsyncNotifierProvider for search state
```

### 3. Track Progress
```
Claude: Updates progress.md:
  ✅ SearchBar widget implemented
  ✅ SearchProvider created
  🔄 API integration (blocked: need API key)
  ⏳ Tests pending
```

### 4. Complete Task
```
User: "Task complete, clean up plans"
Claude:
  - Archives findings.md → docs/architecture/search.md
  - Deletes task_plan.md, progress.md
  - Updates MASTER_TODO.md
```

## Troubleshooting

### Plans Not Created
**Issue:** Claude Code doesn't create planning files
**Fix:**
1. Check `.claude/settings.json` exists with `plansDirectory` key
2. Ensure directory exists: `mkdir -p .claude/plans`
3. Try explicit instruction: "Create task_plan.md in .claude/plans/"

### Plans Committed to Git
**Issue:** Planning files appear in `git status`
**Fix:**
1. Update root `.gitignore` (see Git Integration above)
2. Remove from git: `git rm --cached .claude/plans/*.md`
3. Commit: `git commit -m "chore: ignore planning files"`

### Build Runner Conflicts
**Issue:** Code generation fails during planning
**Fix:**
1. Run: `dart run build_runner clean`
2. Retry: `dart run build_runner build --delete-conflicting-outputs`
3. Update findings.md with resolution

### Hot Reload Breaks
**Issue:** Plan changes break hot reload
**Fix:**
1. Document in progress.md: "Full restart required"
2. Restart app: `flutter run -d <device>`
3. Plan future changes to minimize restarts

## Advanced Usage

### Multi-Feature Planning
For large epics spanning multiple features:
```
.claude/plans/
├── epic-library-redesign/
│   ├── task_plan.md          # Overall epic plan
│   ├── feature-1-search.md   # Search feature sub-plan
│   ├── feature-2-filters.md  # Filters feature sub-plan
│   └── findings.md           # Shared discoveries
```

### Branching Strategy
Planning files stay on feature branches:
```bash
# Create feature branch with plans
git checkout -b feature/search
# Work with Claude Code (plans auto-created)
# Commit code only (plans ignored)
git commit -m "feat: implement search"
# Merge to main (plans not included)
git checkout main && git merge feature/search
```

### Documentation Migration
Promote valuable findings to permanent docs:
```bash
# After task completion
mv .claude/plans/findings.md docs/architecture/search-implementation.md
git add docs/architecture/search-implementation.md
git commit -m "docs: add search architecture notes"
```

## References

- **Claude Code Docs:** https://code.claude.com/docs
- **Planning Skill:** `/skill planning-with-files`
- **Flutter Docs:** https://docs.flutter.dev
- **Riverpod Docs:** https://riverpod.dev

---

**Last Updated:** January 16, 2026
**Status:** Active
**Mode:** Native Claude Code plan mode (no plugin)
