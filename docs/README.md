# Documentation Index

**Last Updated:** January 5, 2026

This directory contains all project documentation organized by category.

---

## Quick Access

- **[Master TODO List](../MASTER_TODO.md)** - Prioritized list of all open tasks
- **[CLAUDE.md](../CLAUDE.md)** - AI assistant project guide (primary reference)
- **[README.md](../README.md)** - Main project README

---

## Documentation Structure

### API Integration (`api-integration/`)
Documentation related to BendV3 API integration and data models.

| Document | Description |
|----------|-------------|
| `BENDV3_API_INTEGRATION_GUIDE.md` | ⭐ Primary guide for BendV3 API integration |
| `DTO_SYNC_GUARDRAILS.md` | 🛡️ **NEW:** 5-layer system to prevent DTO schema drift |
| `GUARDRAILS_QUICK_REFERENCE.md` | 📋 Quick reference for guardrail commands |
| `TYPE_MAPPING_REFERENCE.md` | 📊 TypeScript → Dart field mapping reference |
| `API_DATA_COMPARISON.md` | Alexandria vs BendV3 comparison (reference) |
| `API_INTEGRATION_QUICK_REFERENCE.md` | Quick reference guide |
| `API_ENDPOINT_RECONCILIATION.md` | Endpoint mapping and reconciliation |
| `NPM_PACKAGE_VS_OPENAPI_ANALYSIS.md` | Package vs OpenAPI schema analysis |
| `PR242_FRONTEND_INTEGRATION_GUIDE.md` | Frontend integration guide |
| `API_CLIENT_AUDIT_REPORT.md` | API client implementation audit |
| `API_CONTRACT_VERIFICATION_REPORT.md` | Contract verification results |
| `API_REFERENCE_TABLE.md` | API reference table |
| `DTO_AUDIT_REPORT.md` | DTO compliance analysis (100% compliant) |

### Agent Optimization (`agent-optimization/`)
Claude Code agent optimization and enhancement documentation.

| Document | Description |
|----------|-------------|
| `CLAUDE_OPTIMIZATION_ANALYSIS.md` | Complete agent optimization assessment |
| `OPTIMIZATION_RECOMMENDATIONS.md` | Step-by-step implementation guide |
| `PHASE_IMPLEMENTATION_PLAN.md` | 6-week optimization roadmap |

### Planning (`planning/`)
Project planning, progress tracking, and roadmap documents.

| Document | Description |
|----------|-------------|
| `TODO_REFINED.md` | Production roadmap (14-week plan) |
| `TODO.md` | Original TODO list |
| `IMPLEMENTATION_LOG.md` | Development progress log |
| `SESSION_SUMMARY.md` | Latest session completion summary |
| `PHASE_1_PROGRESS.md` | Phase 1 progress tracking |
| `PROJECT_STATUS_SUMMARY.md` | Current project status |
| `PROJECT_SUMMARY.md` | Project overview |
| `NEXT_STEPS.md` | Next steps and priorities |
| `WORKFLOW_SUMMARY.md` | Development workflow guide |

### Setup (`setup/`)
Installation, configuration, and deployment guides.

| Document | Description |
|----------|-------------|
| `QUICKSTART.md` | Quick start guide |
| `SETUP_CHECKLIST.md` | Setup checklist |
| `LINTING_SETUP.md` | Complete linting and code quality guide |
| `DEPLOYMENT.md` | Deployment instructions |
| `GITHUB_ZEN_SETUP.md` | GitHub configuration guide |

### Firebase (`firebase/`)
Firebase integration, setup, and migration documentation.

| Document | Description |
|----------|-------------|
| `FIREBASE_SETUP.md` | Firebase setup guide |
| `FIREBASE_CLOUDFLARE_INTEGRATION.md` | Firebase + Cloudflare integration |
| `FIREBASE_ROADMAP.md` | Firebase migration roadmap |
| `FIREBASE_CLEANUP_PLAN.md` | Cleanup plan |
| `FIREBASE_DELETE_STEPS.md` | Deletion steps |

### Reference (`reference/`)
Reference materials and legacy documentation.

| Document | Description |
|----------|-------------|
| `FRONTEND_HANDOFF.md` | Frontend handoff documentation |
| `EXPORT_TO_SWIFT.md` | Swift export guide (iOS legacy) |
| `README_FLUTTER.md` | Flutter README |
| `SECURITY_INCIDENT.md` | Security incident notes |
| `STRUCTURE_SUMMARY.md` | Architecture structure summary |

---

## GitHub Documentation (`.github/`)

### Infrastructure
- **`LABELS.md`** - Label system reference (48 labels)
- **`BENDV3_FEATURE_REQUESTS.md`** - BendV3 API feature requests
- **`REORGANIZATION_COMPLETE.md`** - Nov 13 reorganization summary
- **`FLUTTER_ORGANIZATION_PLAN.md`** - Architecture plan
- **`AI_COLLABORATION.md`** - AI collaboration guide

### Workflows
- **`ci.yml`** - Continuous Integration
- **`copilot-review.yml`** - GitHub Copilot PR reviews
- **`deploy-cloudflare.yml`** - Backend deployment

### Issue Templates
- **`bug.yml`** - Bug report template
- **`feature.yml`** - Feature request template

---

## Product Requirements (`product/`)

- **`PRD-Template.md`** - Template for new PRDs
- **`CONVERSION_SUMMARY.md`** - iOS → Flutter conversion guide
- **`QUICK_REFERENCE.md`** - Quick product reference
- **`*-PRD-Flutter.md`** - Converted Flutter PRDs
- **`*-PRD.md`** - Original iOS PRDs

---

## Claude Code Agents (`.claude/`)

### Agent Configuration
- **`README.md`** - Agent setup guide
- **`ROBIT_OPTIMIZATION.md`** - Complete agent architecture
- **`ROBIT_SHARING_FRAMEWORK.md`** - Cross-repo agent sharing

### Directories
- **`agents/`** - Agent configurations (JSON)
- **`hooks/`** - Git-like hooks (pre-commit, post-tool-use)
- **`prompts/`** - Reusable prompts
- **`skills/`** - Skill definitions (project-manager, flutter-agent, pal-master)

---

## Document Maintenance

### Adding New Documentation

1. **Choose the appropriate directory** based on document type
2. **Update this README.md** with the new document entry
3. **Link from CLAUDE.md** if it's a primary reference
4. **Update MASTER_TODO.md** if it creates new tasks

### Document Lifecycle

- **Active:** Documents actively used in development
- **Reference:** Historical or legacy documents for reference
- **Archived:** Obsolete documents (move to `docs/archive/`)

### Documentation Standards

- Use **Markdown** format (.md)
- Include **last updated date** at the top
- Use **clear section headers** (##, ###)
- Add **table of contents** for long documents
- Include **code examples** where applicable
- Link to **related documents**

---

## Contributing

When creating or updating documentation:

1. Follow the existing structure and format
2. Keep documents focused and concise
3. Update the relevant index (this file)
4. Run pre-commit hook to validate formatting
5. Link from CLAUDE.md for AI assistant discoverability

---

**Questions?** Check CLAUDE.md or open an issue.
