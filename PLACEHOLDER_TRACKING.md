# Placeholder Pages & Content Gaps

**Last Updated:** December 8, 2025

This document tracks pages that exist but have placeholder/"Coming Soon" content, as well as content gaps that should be filled in future iterations.

---

## 🚧 Pages with "Coming Soon" Placeholders

### 1. Guides Section
**File:** `content/guides/_index.md`  
**Status:** Placeholder page  
**Says:** "Coming Soon" with links to template quick starts  
**Needs:** Actual tutorial content, architecture guides, integration patterns

### 2. Reference Section  
**File:** `content/reference/_index.md`  
**Status:** Placeholder page  
**Says:** "Coming Soon" with note to check template docs  
**Needs:** API references, configuration specs, technical reference material

### 3. Contribute Section - Template Contribution
**File:** `content/contribute/contributing-templates.md`  
**Status:** Placeholder with draft requirements  
**Says:** "Coming Soon" with template requirements draft  
**Needs:** Full process, review criteria, examples

### 4. Contribute Section - Testing Standards
**File:** `content/contribute/testing-standards.md`  
**Status:** Placeholder with draft checklist  
**Says:** "Coming Soon" with testing checklist  
**Needs:** Complete standards, CI/CD requirements, examples

---

## 📝 Content That Could Be Expanded

### Template Documentation

**Agent Template** (2 pages - could use more):
- ✅ Has: Overview, Quick Start, Deployment
- 🔄 Could add: Best Practices, Architecture Deep Dive, Troubleshooting

**UI Template** (2 pages - could use more):
- ✅ Has: Overview, Quick Start, Deployment  
- 🔄 Could add: Customization Guide, Component Reference, Theming

### Tools Section

**Tools Overview**:
- ✅ Has: Cursor, Claude Desktop
- 🔄 Could add: VSCode setup, Other MCP clients, Comparison guide

---

## 🔗 Broken or Missing Link Destinations

### Navigation Menu Links

All top menu items now have landing pages:
- ✅ Templates → `/templates/` (has content + cards)
- ✅ Tools → `/tools/` (has content + tool list)
- ✅ Contribute → `/contribute/` (has content) ✅ JUST FIXED
- ✅ Guides → `/guides/` (placeholder)
- ✅ Reference → `/reference/` (placeholder)
- ✅ GitHub → External link (works)

### Homepage Links

- ✅ All template links work
- ✅ All "Get Started" steps link to real pages
- ✅ GitHub links are external (valid)

---

## 🏗️ Infrastructure Improvements

### Taxonomy System

**Current:** Basic taxonomies (template_type, use_case, tag)  
**Needed:** Strategic taxonomy system for growing ecosystem

**Goals:**
- Enable filtered browsing by category, use case, deployment target
- Support discovery as template count grows
- Organize governance, compliance, and monitoring templates
- Help users find templates that solve their specific problems

**Plan:**
- Define taxonomy structure (categories, use cases, complexity, integrations)
- Tag existing templates with new taxonomies
- Build filtered browse pages when we have 5+ templates per category
- Create landing pages for major categories (governance, monitoring, etc.)

---

## 📋 Priority for Next Phase

### High Priority (Breaks User Experience)

None! All navigation works, all links resolve.

### Medium Priority (Nice to Have)

1. **Guides section** - Add 2-3 real tutorial guides
2. **Reference section** - Add API/config reference
3. **Agent template** - Add 1-2 more pages for parity with MCP Server
4. **UI template** - Add 1-2 more pages for parity with MCP Server

### Low Priority (Future Enhancement)

1. Additional tool guides (VSCode, etc.)
2. More examples and use cases
3. Video tutorials
4. Architecture decision records

---

## ✅ What's Fully Complete

### MCP Server Template
- 5 complete pages
- All cross-links working
- Comprehensive documentation
- No placeholders

### Tools - Cursor & Claude
- Complete setup guides
- All configuration steps
- Troubleshooting sections
- No placeholders in these docs

### Site Infrastructure
- All layouts working
- All shortcodes functional
- Navigation complete
- No broken internal links

---

## 🎯 Recommended Actions

**For Launch (v1.0):**
- ✅ Current state is LAUNCHABLE
- Site is functional with good content
- Placeholders are clearly marked
- All navigation works

**Post-Launch (v1.1):**
- Add content to Guides section
- Add content to Reference section
- Expand Agent/UI template docs

**Future (v2.0):**
- Convert to AsciiDoc if Red Hat requires
- Add more advanced tutorials
- Video content
- Community contributions

---

**Note:** This is a living document. Update as placeholders are filled or new gaps identified.

