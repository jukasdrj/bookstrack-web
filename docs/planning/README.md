# Planning Documentation

This directory contains project planning documents, progress tracking, and implementation guides.

---

## 📋 Active Planning

### Primary Task List
- **[MASTER_TODO.md](../../MASTER_TODO.md)** (Root level) - Single source of truth
  - 21 prioritized tasks (P0-P3)
  - Updated: January 6, 2026
  - 3 completed, 18 remaining
  - Tracks GitHub issues and PRs

### Feature Implementation Guides
Located in `features/` directory - detailed phase-by-phase plans:

1. **[00-OVERVIEW.md](features/00-OVERVIEW.md)** - Project roadmap overview
2. **[01-CRITICAL-FIXES.md](features/01-CRITICAL-FIXES.md)** - Phase 1: Foundation fixes
3. **[02-SEARCH-FEATURE.md](features/02-SEARCH-FEATURE.md)** - Phase 2: Multi-mode search
4. **[03-SCANNER-FEATURE.md](features/03-SCANNER-FEATURE.md)** - Phase 3: Barcode scanner
5. **[04-BOOKSHELF-SCANNER.md](features/04-BOOKSHELF-SCANNER.md)** - Phase 4: AI scanner
6. **[05-REVIEW-QUEUE.md](features/05-REVIEW-QUEUE.md)** - Phase 5: Review queue UI
7. **[06-INSIGHTS.md](features/06-INSIGHTS.md)** - Phase 6: Reading analytics
8. **[07-SETTINGS.md](features/07-SETTINGS.md)** - Phase 7: Settings & preferences
9. **[08-BOOK-DETAIL.md](features/08-BOOK-DETAIL.md)** - Phase 8: Book detail screen

---

## 📊 Progress Tracking

### Current Project Status
- **PROJECT_STATUS_SUMMARY.md** - High-level project status (updated Dec 26, 2025)
- **PROJECT_SUMMARY.md** - Project overview and architecture
- **NEXT_STEPS.md** - Immediate next actions

---

## 📦 Archive

Historical planning documents (2025 Q4) in `archive/2025-q4/`:

- **TODO.md** - Original task list (Nov 12, 2025)
- **TODO_REFINED.md** - Refined 14-week plan (Nov 12, 2025)
- **SESSION_SUMMARY.md** - Development session notes (Dec 26, 2025)
- **PHASE_1_PROGRESS.md** - Phase 1 completion status (Dec 26, 2025)
- **WORKFLOW_SUMMARY.md** - Development workflow documentation
- **IMPLEMENTATION_LOG.md** - Detailed implementation log

**Note:** These files are archived for historical reference. Refer to [MASTER_TODO.md](../../MASTER_TODO.md) for current priorities.

---

## 🎯 How to Use This Documentation

### For Active Development
1. **Check priorities:** [MASTER_TODO.md](../../MASTER_TODO.md)
2. **Plan feature work:** Review relevant guide in `features/`
3. **Track progress:** Update MASTER_TODO.md upon completion

### For Context & Planning
1. **Understand phases:** Read `features/00-OVERVIEW.md`
2. **Deep dive:** Read specific phase guides (01-08)
3. **Check status:** Review PROJECT_STATUS_SUMMARY.md

### For Historical Reference
- See `archive/2025-q4/` for pre-December 2025 planning

---

## 📁 Directory Structure

```
docs/planning/
├── README.md                         # This file
├── PROJECT_STATUS_SUMMARY.md         # Current status
├── PROJECT_SUMMARY.md                # Project overview
├── NEXT_STEPS.md                     # Immediate actions
│
├── features/                         # Feature implementation guides
│   ├── 00-OVERVIEW.md                # Roadmap overview
│   ├── 01-CRITICAL-FIXES.md          # Phase 1
│   ├── 02-SEARCH-FEATURE.md          # Phase 2 (current)
│   ├── 03-SCANNER-FEATURE.md         # Phase 3
│   ├── 04-BOOKSHELF-SCANNER.md       # Phase 4
│   ├── 05-REVIEW-QUEUE.md            # Phase 5
│   ├── 06-INSIGHTS.md                # Phase 6
│   ├── 07-SETTINGS.md                # Phase 7
│   └── 08-BOOK-DETAIL.md             # Phase 8
│
└── archive/                          # Historical documents
    └── 2025-q4/
        ├── TODO.md
        ├── TODO_REFINED.md
        ├── SESSION_SUMMARY.md
        ├── PHASE_1_PROGRESS.md
        ├── WORKFLOW_SUMMARY.md
        └── IMPLEMENTATION_LOG.md
```

---

## 🔗 Related Documentation

- **[CLAUDE.md](../../CLAUDE.md)** - Complete project guide for AI assistants
- **[docs/README.md](../README.md)** - Main documentation index
- **[docs/api-integration/](../api-integration/)** - BendV3 API integration guides
- **[.github/LABELS.md](../../.github/LABELS.md)** - GitHub labels system

---

**Last Updated:** January 6, 2026
