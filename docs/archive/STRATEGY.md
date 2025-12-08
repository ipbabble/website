# AI Templates Migration Strategy

**Created:** November 5, 2025  
**Status:** Mid-Migration Reassessment

---

## The Original Goal (from MIGRATION_JOURNEY.md)

**Source:** 34 Markdown files from Hextra theme  
**Target:** Hugo + PatternFly theme (**Asciidoctor-based**)  
**Plan:** Convert content to AsciiDoc format

### What We Missed

The Validated Patterns theme is **Asciidoctor-first**. While it "supports" Markdown, the layouts and structure are optimized for .adoc files.

**Evidence:**
- All `content/contribute/` files are `.adoc`
- All pattern files were `.adoc` or `.md` with simple structure
- The theme expects modular AsciiDoc patterns

---

## Two Paths Forward

### Path A: Convert to AsciiDoc (Original Plan)

**SHORT TERM (2-3 hours):**
1. Convert ONE page to AsciiDoc as proof of concept
2. Test that it renders with proper sidebar/TOC
3. Document the conversion pattern
4. Batch convert remaining pages

**LONG TERM:**
- Content in native format for the theme
- Can use modular includes if needed
- Works with existing layouts
- Professional technical documentation format

**Effort:**
- Initial: 3-4 hours for conversion + testing
- Ongoing: Same as Markdown for editing

---

### Path B: Make Markdown Work (What We've Been Trying)

**SHORT TERM:**
1. Debug why layouts aren't applying to .md files
2. Fix TOC generation for Markdown
3. Ensure 3-column layout works
4. Test extensively

**LONG TERM:**
- Markdown content (easier for some contributors)
- Custom layouts for each section
- May not match Validated Patterns exactly
- Ongoing layout maintenance

**Effort:**
- Initial: Already spent 2+ hours, still broken
- Ongoing: Maintain custom layouts separate from theme

---

## Recommendation: AsciiDoc (Path A)

### Why This Makes Sense

1. **Work with the theme, not against it**
   - Theme is designed for AsciiDoc
   - Existing layouts already work for .adoc
   - No fighting with CSS/layouts

2. **Proven to work**
   - All of `content/contribute/` uses .adoc and renders perfectly
   - We can see it working right now

3. **Actually faster**
   - 3 hours to convert vs unknown hours debugging Markdown
   - Conversion is straightforward
   - Can script it partially

4. **Better long-term**
   - Native admonitions (NOTE, TIP, WARNING)
   - Professional technical doc format
   - Red Hat standard (even though we're removing Red Hat branding)

### The Conversion Is Not That Bad

**Markdown → AsciiDoc:**

```markdown
## Heading               →  == Heading
**bold**                 →  *bold*
[link](url)              →  link:url[text]
{{< info >}}...{{< /info >}} →  [NOTE]\n====\n...\n====
```python              →  [source,python]\n----
```                      →  ----
```

**Tools that can help:**
- Pandoc: `pandoc input.md -o output.adoc`
- Manual cleanup after

---

## Concrete Next Steps

### If We Go AsciiDoc (Recommended):

1. **Pick ONE file** - Start with `quick-getting-started.md`
2. **Convert it** - Use pandoc + manual cleanup
3. **Test rendering** - Does it work with existing layouts?
4. **Document pattern** - What works, what needs manual fixes
5. **Convert rest** - Systematically convert all 5 MCP Server files
6. **Repeat for Tools** - Convert tools documentation

**Timeline:** 3-4 hours total

### If We Stick with Markdown:

1. **Debug layouts** - Figure out why TOC doesn't show
2. **Test ONE page** - Get it working perfectly
3. **Apply pattern** - Replicate to all pages
4. **Ongoing maintenance** - Keep custom layouts updated

**Timeline:** Unknown (already 2+ hours, still issues)

---

## What the Source Files Show

Looking at your source in `~/gitlab/docs/dataverse.pages.redhat.com/content/ai-docs/`:

- **Format:** Markdown (.md files)
- **Theme:** Hextra (Markdown-native)
- **Shortcodes:** `{{< callout >}}`, `{{< cards >}}`, `{{< tabs >}}`

**The conversion was ALWAYS part of the plan** (see MIGRATION_JOURNEY line 187):
> "Convert Hextra shortcodes → PatternFly/Asciidoc equivalents"

We just tried to skip it and keep Markdown!

---

## My Honest Assessment

**What I should have done:**
1. Recognize the theme is AsciiDoc-first
2. Convert content to AsciiDoc immediately
3. Use existing layouts (they work!)
4. Focus on content migration, not layout fixing

**What I actually did:**
1. Try to make Markdown work
2. Create custom layouts
3. Fight with CSS and fonts
4. Modify working theme files

**Result:** 2+ hours spent, site still broken

---

## Proposed Action Plan

### Immediate (Next 30 min):
1. **Create conversion guide** - Markdown → AsciiDoc patterns
2. **Convert ONE file** - Test the process
3. **Verify it renders** - With sidebar, TOC, proper layout
4. **Decision point** - If it works, continue. If not, reassess.

### Short Term (3 hours):
- Convert all MCP Server docs to .adoc
- Convert Tools docs to .adoc
- Test thoroughly

### Long Term:
- Content in .adoc format
- Use theme as-is
- Focus on content quality, not layout tweaking

---

## Questions for You

1. **Are you OK with AsciiDoc format?** (It's not that different from Markdown)
2. **Should we test the conversion with ONE file first?**
3. **Or do you want to keep debugging Markdown?** (I can, but uncertain timeline)

The theme is telling us what it wants - AsciiDoc. We can fight it or work with it.




