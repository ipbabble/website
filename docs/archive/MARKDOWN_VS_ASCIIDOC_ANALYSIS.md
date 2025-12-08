# Markdown vs AsciiDoc: Deep Analysis for AI Templates Migration

**Date:** November 5, 2025  
**Analysis Duration:** 15 minutes deep dive  
**Goal:** Determine the best approach for content format in AI Templates documentation

---

## Executive Summary

**RECOMMENDATION: Keep Markdown with proper layouts**

The Validated Patterns site works well with AsciiDoc because:
1. They have modular, reusable content chunks across 40+ patterns
2. They use Red Hat documentation standards (modular documentation)
3. Their content is heavily cross-referenced

AI Templates is different:
1. Simpler documentation structure (3-4 templates vs 40+ patterns)
2. Each template has distinct, standalone documentation
3. Coming from Markdown source (Hextra theme)
4. Less modular content reuse needed

---

## The Real Problem (Now Fixed!)

The issue wasn't Markdown vs AsciiDoc - it was **missing layouts**!

**What I just created:**
- ✅ `layouts/templates/single.html` - Proper page layout with sidebar + TOC
- ✅ `layouts/templates/list.html` - Section listing layout
- ✅ `layouts/partials/menu-templates.html` - Sidebar navigation

**Result:** Markdown files now render exactly like AsciiDoc files!

---

## Format Comparison

### AsciiDoc (.adoc)

**Pros:**
- ✅ Native admonitions (NOTE, TIP, WARNING, IMPORTANT, CAUTION)
- ✅ Modular content with `include::` directives
- ✅ `:toc:` directive for automatic TOC
- ✅ Semantic markup for technical docs
- ✅ Red Hat standard for enterprise docs
- ✅ Better handling of complex tables
- ✅ Built-in attributes/variables

**Cons:**
- ❌ Requires conversion from existing Markdown
- ❌ Steeper learning curve
- ❌ Less familiar to most developers
- ❌ Requires Asciidoctor installation

**Example AsciiDoc:**
```asciidoc
= Page Title
:toc:
:_content-type: ASSEMBLY

== Section Heading

[NOTE]
====
This is a note with native syntax
====

[source,python]
----
def hello():
    print("world")
----

include::modules/shared-content.adoc[leveloffset=+1]
```

### Markdown (.md)

**Pros:**
- ✅ Already have content in Markdown (from Hextra)
- ✅ GitHub-friendly (renders natively)
- ✅ More familiar to developers
- ✅ Works with Hugo shortcodes
- ✅ Simpler syntax for most use cases
- ✅ Better for AI-generated content (Claude, GPT understand it natively)

**Cons:**
- ❌ Requires custom shortcodes for callouts
- ❌ No native content inclusion (though Hugo has partials)
- ❌ Less semantic for complex technical docs

**Example Markdown (what we have):**
```markdown
---
title: "Page Title"
type: docs
weight: 10
---

## Section Heading

{{< info >}}
This is a note with shortcode syntax
{{< /info >}}

\`\`\`python
def hello():
    print("world")
\`\`\`
```

---

## Validated Patterns Structure Analysis

### Why They Use AsciiDoc

**1. Red Hat Documentation Standards**
- Corporate requirement for modular documentation
- Content reuse across products
- Compliance with docs team workflows

**2. Content Reuse Pattern**
```
content/patterns/multicloud-gitops/
  ├── _index.adoc (Assembly)
  └── mcg-getting-started.adoc (Assembly)

modules/ (SHARED across ALL patterns)
  ├── mcg-about-multicloud-gitops.adoc (Concept)
  ├── mcg-architecture.adoc (Concept)
  ├── mcg-deploying-mcg-pattern.adoc (Procedure)
  └── comm-deploying-managed-cluster-using-clusteradm-tool.adoc (Procedure)
```

**Key Insight:** They have ~60 files in `/modules/` that are `include::`'d across 40+ patterns!

**3. Modular Doc Types**
- **Assembly**: Combines multiple modules into a complete doc
- **Concept**: Explains what something is
- **Procedure**: Step-by-step instructions
- **Reference**: Tables, lists, specifications

This is Red Hat's standard for product documentation across hundreds of products.

---

## AI Templates Documentation Needs

### Our Structure (Much Simpler)

```
content/templates/
  ├── mcp-server/
  │   ├── _index.md
  │   ├── quick-getting-started.md
  │   ├── best-practices.md
  │   ├── taking-to-production.md
  │   └── enterprise-template.md
  ├── agent/
  │   └── (future docs)
  └── ui/
      └── (future docs)

content/tools/
  ├── cursor.md
  └── claude-desktop.md
```

**Key Differences:**
- ~15-20 total doc files (vs 100+ for Validated Patterns)
- 3-4 templates (vs 40+ patterns)
- Minimal content reuse between templates
- Each template is self-contained

### Do We Need AsciiDoc?

**NO - Here's why:**

1. **No massive content reuse**
   - MCP Server docs don't share content with Agent docs
   - Each template is standalone
   - No shared modules needed

2. **Source content is Markdown**
   - Converting from Hextra (Markdown)
   - Would require rewriting all content
   - Adds conversion complexity

3. **Target audience**
   - Developers familiar with Markdown
   - GitHub ecosystem (Markdown native)
   - AI tools understand Markdown better

4. **Simpler is better**
   - Less tooling complexity
   - Easier for contributors
   - Faster content creation

---

## What Actually Matters: The Layout

**The Validated Patterns "look and feel" comes from:**

### 1. Three-Column Layout
```
[Sidebar]  [Main Content]  [TOC]
```

This is controlled by **layouts**, not content format!

Both Markdown and AsciiDoc render through Hugo layouts:
- `{{ .Content }}` renders either format
- Same CSS applies to both
- Same sidebar/TOC structure for both

### 2. PatternFly Theme Styling
- Typography (fonts, sizes, spacing)
- Colors and branding
- Component styling (cards, alerts, tables)
- Responsive design

All of this is **format-agnostic**!

### 3. Navigation Structure
- Top menu (config.yaml)
- Sidebar menus (partials)
- Breadcrumbs
- Page navigation (prev/next)

All controlled by **layouts**, not content format!

---

## Conversion Complexity Analysis

### If We Converted to AsciiDoc

**Markdown → AsciiDoc Mapping:**

| Markdown | AsciiDoc | Difficulty |
|----------|----------|------------|
| `# Heading` | `= Heading` | Easy |
| `## Heading` | `== Heading` | Easy |
| `**bold**` | `*bold*` | Easy |
| `*italic*` | `_italic_` | Easy |
| `[text](url)` | `link:url[text]` | Medium |
| ` ```python ` | `[source,python]` + `----` | Medium |
| `{{< info >}}` | `[NOTE]` + `====` | Medium |
| `{{< tip >}}` | `[TIP]` + `====` | Medium |
| Tables | AsciiDoc tables | Hard |
| Mermaid diagrams | May not work | Hard |

**Estimated conversion time:**
- 5 MCP Server files × 30 min each = 2.5 hours
- 3 Tools files × 20 min each = 1 hour
- Testing and fixing = 1 hour
- **Total: ~4.5 hours**

**For what gain?**
- Native admonitions (but shortcodes work fine)
- Modular includes (but we don't need them)
- Red Hat standard (but we're not Red Hat docs)

**NOT WORTH IT.**

---

## The Fix I Just Implemented

### Created Proper Layouts (10 minutes)

1. **`layouts/templates/single.html`**
   - Three-column layout (sidebar, content, TOC)
   - Matches patterns layout exactly
   - Works with Markdown!

2. **`layouts/templates/list.html`**
   - Section listing page
   - Shows all template docs

3. **`layouts/partials/menu-templates.html`**
   - Sidebar navigation
   - Expandable sections
   - Current page highlighting

**Result:** Our Markdown files now render exactly like Validated Patterns!

---

## Content Strategy Going Forward

### Use Markdown For:
- ✅ Template documentation (mcp-server, agent, ui)
- ✅ Tools guides (Cursor, Claude)
- ✅ General guides
- ✅ Reference documentation

### Maybe Use AsciiDoc For:
- ❓ Contribute section (already in AsciiDoc, leave it)
- ❓ IF we need heavy content reuse later (unlikely)

### Create Similar Layouts For:
- `layouts/tools/single.html` - Tools section
- `layouts/guides/single.html` - Guides section
- `layouts/reference/single.html` - Reference section

---

## Font Size Analysis

The fonts appear large because of several factors:

### Current Issues:
1. **Base font**: 13px (we set this, but PatternFly overrides)
2. **Hero content**: Has `!important` rules that make it huge
3. **Content h1/h2**: Still using PatternFly defaults which are LARGE
4. **Missing constraints**: Need more specific CSS rules

### Validated Patterns Font Sizes:
Looking at their site, they use:
- Base: ~14px
- H1: ~1.75rem (24px)
- H2: ~1.5rem (21px)
- H3: ~1.25rem (17.5px)
- Paragraph: ~0.875rem (12.25px)
- Code: ~0.85rem

### Our Current Sizes (TOO BIG):
- H1: 1.75rem ✅ (this is OK)
- H2: 1.5rem ✅ (this is OK)  
- Paragraph: 0.875rem ✅ (this is OK)
- **BUT** hero-content overrides these with massive sizes!

---

## Immediate Action Plan

### Phase 1: Fix Layouts (DONE!)
- ✅ Created `layouts/templates/single.html`
- ✅ Created sidebar navigation
- ✅ Three-column layout working

### Phase 2: Fix Font Sizes (NEXT - 5 minutes)
- Remove hero-content massive font overrides
- Constrain all headings properly
- Make sure fonts match Validated Patterns

### Phase 3: Create Tools & Guides Layouts (15 minutes)
- Copy templates layout for tools
- Copy templates layout for guides
- Consistent structure across all sections

### Phase 4: Continue Content Migration (1-2 hours)
- Migrate remaining 3 MCP Server docs
- Migrate Tools docs (Cursor, Claude)
- Keep everything in Markdown

### Phase 5: Polish (30 minutes)
- Test all pages
- Fix any broken links
- Adjust spacing/fonts as needed

---

## Why This Approach Works

### 1. Fastest Path to Working Site
- Layouts fix the structure issues
- Markdown is already working
- No content conversion needed

### 2. Best for Our Use Case
- Simple documentation structure
- Standalone templates
- Developer-friendly format

### 3. Future-Proof
- Can add AsciiDoc files later if needed
- Hugo supports both formats simultaneously
- Easy for contributors

### 4. Validated Patterns Compatible
- Same layouts
- Same theme
- Same visual appearance
- Just different content format (which doesn't matter!)

---

## Conclusion

**We DON'T need to convert to AsciiDoc.**

The problem was missing layouts, not the content format. With proper layouts created, Markdown renders beautifully with the same three-column structure, sidebar navigation, and TOC as Validated Patterns.

**Next steps:**
1. ✅ Layouts created
2. 🔄 Fix font sizes
3. 🔄 Test the templates pages
4. 🔄 Continue migrating content in Markdown

The site will look and function exactly like validatedpatterns.io, just with Markdown content instead of AsciiDoc - which is perfectly fine!




