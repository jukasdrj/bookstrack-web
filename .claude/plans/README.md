# Unified Plans Directory

This directory stores planning artifacts for complex Flutter development tasks using **native Claude Code plan mode** (no plugin required).

## What Goes Here

### Planning Files (Task-Specific)
- `task_plan.md` - High-level task breakdown and strategy
- `findings.md` - Technical discoveries, architecture notes, API insights
- `progress.md` - Current status, blockers, next steps

### When to Use Plans

**REQUIRED for:**
- Feature development (new screens, widgets, state management)
- Architecture changes (provider patterns, navigation, database schema)
- API integration (REST clients, WebSocket, Firebase)
- Performance optimization (build times, rendering, memory)
- Complex refactoring (state migration, widget restructuring)

**SKIP for:**
- Bug fixes (single file, obvious root cause)
- Documentation updates
- Code formatting/linting
- Dependency version bumps

## Flutter-Specific Planning Patterns

### Component Hierarchy Planning
```markdown
# Component Tree
- LibraryScreen (StatefulWidget)
  ├── AppBar (custom)
  ├── SearchBar (Consumer)
  ├── BookGrid (Riverpod Provider)
  │   └── BookCard (StatelessWidget)
  └── FloatingActionButton
```

### State Flow Planning
```markdown
# State Management (Riverpod)
1. Provider: bookListProvider (AsyncNotifierProvider)
2. Triggers: onSearch, onFilter, onRefresh
3. Dependencies: bookRepository, cacheService
4. Consumers: BookGrid, BookCard, SearchBar
```

### API Integration Planning
```markdown
# Endpoint: GET /v3/books/search
- Request: SearchRequest (dio interceptor)
- Response: SearchResponse<Book>
- Cache: dio_cache_interceptor (1h TTL)
- Error: DioException → ErrorState → SnackBar
```

### Database Schema Planning
```markdown
# Drift Table: Books
- id (INTEGER, PRIMARY KEY)
- isbn (TEXT, UNIQUE, NOT NULL)
- title (TEXT, NOT NULL)
- coverUrl (TEXT, NULLABLE)
- createdAt (DATETIME, DEFAULT NOW)
```

### Navigation Planning
```markdown
# go_router Routes
/library → LibraryScreen (StatefulShellRoute)
/library/:bookId → BookDetailScreen (nested)
/search → SearchScreen (sibling)
```

## File Lifecycle

### Creation
Plans are created when:
- You start a complex task (>5 tool calls expected)
- Architecture decisions need documentation
- Multiple files/features are affected

### Maintenance
Update plans as you:
- Discover new technical constraints
- Change architectural approach
- Hit blockers or pivot strategy
- Complete milestones

### Cleanup
Delete plans when:
- Task is 100% complete and merged
- Changes are abandoned/cancelled
- Findings are moved to permanent docs

**Retention:** Keep plans for active work only. Archive to `docs/planning/` if historical context is valuable.

## Git Integration

**Planning files are git-ignored** (see root `.gitignore`):
- `task_plan.md`
- `findings.md`
- `progress.md`
- `.claude/plans/*`

**Why:** Plans are ephemeral AI collaboration artifacts, not project documentation.

**Exception:** Manually commit `findings.md` to `docs/architecture/` if it contains permanent architectural decisions.

## Common Flutter Planning Scenarios

### Scenario 1: New Feature Screen
```markdown
# task_plan.md
1. Define screen requirements (PRD, Figma)
2. Design widget tree (StatefulWidget vs StatelessWidget)
3. Identify state providers (Riverpod)
4. Plan API calls (dio, error handling)
5. Design navigation (go_router routes)
6. Implement UI (Material 3 components)
7. Add tests (widget tests, integration tests)
8. Update documentation
```

### Scenario 2: State Migration (Provider → Riverpod)
```markdown
# task_plan.md
1. Audit current Provider usage (files affected)
2. Map Provider → Riverpod equivalents
3. Create Riverpod providers (code generation)
4. Migrate consumers (Consumer → ConsumerWidget)
5. Update tests (ProviderScope)
6. Remove Provider dependencies
7. Run build_runner
```

### Scenario 3: API Client Refactor
```markdown
# task_plan.md
1. Analyze current API client (dio config)
2. Design new structure (base client, interceptors)
3. Plan error handling (DioException → AppException)
4. Implement caching strategy (dio_cache_interceptor)
5. Update repository layer (DI via Riverpod)
6. Migrate endpoints (one feature at a time)
7. Add integration tests
```

## Best Practices

### 1. Start with Widget Tree
Always map out component hierarchy before coding:
- Identify StatefulWidget vs StatelessWidget
- Plan Riverpod provider locations
- Design data flow (top-down vs event-driven)

### 2. Plan Code Generation
Document what needs generated code:
- Riverpod providers (@riverpod annotation)
- Drift tables (@DriftDatabase annotation)
- Freezed models (@freezed annotation)
- JSON serialization (@JsonSerializable)

### 3. Consider Build Runner Impact
Large refactors may require multiple build_runner cycles:
- Plan incremental changes
- Test after each generation
- Commit generated files separately

### 4. Plan Hot Reload Boundaries
Some changes break hot reload:
- Constructor signature changes
- New StatefulWidget → StatelessWidget
- Provider type changes
- Route definition changes

**Strategy:** Plan these changes together to minimize restarts.

### 5. Mobile-First Considerations
Always plan for:
- Screen size variations (portrait/landscape)
- Platform differences (iOS/Android Material)
- Gesture handling (swipe, long-press)
- Offline-first (cache strategy)
- Background state (lifecycle)

## Tools & Commands

### Planning Tools
- `mcp__pal__planner` - Multi-step interactive planning
- `mcp__pal__thinkdeep` - Architecture analysis
- `mcp__pal__debug` - Deep debugging (Gemini/Grok)

### Flutter Commands
```bash
# Code generation (use during planning)
dart run build_runner build --delete-conflicting-outputs

# Widget tree inspection
flutter widget tree

# Analyze (check plan feasibility)
flutter analyze

# Test plan changes
flutter test
```

## Examples

### Example 1: Search Feature Implementation
**Duration:** 3 days
**Files:** `task_plan.md`, `findings.md`, `progress.md`
**Key Decisions:**
- Use Riverpod AsyncNotifierProvider for state
- dio_cache_interceptor for 1h cache TTL
- go_router nested route for search results
- Material 3 SearchBar widget

**Outcome:** Archived to `docs/planning/search-feature.md`

### Example 2: Drift Database Migration
**Duration:** 2 days
**Files:** `task_plan.md`, `findings.md`
**Key Decisions:**
- Schema version bump (v1 → v2)
- Migration strategy (ALTER TABLE vs recreate)
- Foreign key constraints
- Index optimization

**Outcome:** Deleted (routine migration, no architectural impact)

---

**Last Updated:** January 16, 2026
**Maintained By:** AI Team (Claude Code, Jules, PAL MCP)
**Human Owner:** @jukasdrj
