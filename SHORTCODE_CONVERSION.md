# Shortcode Conversion Guide

## Hextra → PatternFly Shortcodes

This document tracks how we're converting Hextra shortcodes to PatternFly equivalents during the migration.

### Callouts / Alerts

**Hextra format:**
```
{{< callout type="info" >}}
Content here
{{< /callout >}}
```

**PatternFly format:**
```
{{< info >}}
Content here
{{< /info >}}
```

**Available types:**
- `{{< info >}}` - Blue info box (replaces `callout type="info"`)
- `{{< tip >}}` - Green/success tip box (replaces `callout type="tip"` or `callout type="success"`)
- `{{< warning >}}` - Orange warning box (replaces `callout type="warning"`)
- `{{< danger >}}` - Red danger box (replaces `callout type="danger"` or `callout type="error"`)
- `{{< note >}}` - Standard note box

### Cards

**Hextra format:**
```
{{< cards >}}
  {{< card link="/path" title="Title" icon="icon-name" subtitle="Subtitle" >}}
{{< /cards >}}
```

**PatternFly format:**
Use standard markdown links in a list or custom HTML if needed:
```markdown
- **[Title](/path)** - Subtitle description
```

Or use raw HTML with PatternFly card classes for more complex layouts.

### Tabs

**Hextra format:**
```
{{< tabs items="Tab1,Tab2,Tab3" >}}
{{< tab >}}Content 1{{< /tab >}}
{{< tab >}}Content 2{{< /tab >}}
{{< /tabs >}}
```

**PatternFly format:**
Not directly available - convert to sections with headers or accordion if needed.

## Content Sanitization Checklist

When migrating content:
- [x] Remove `# FOUO: Red Hat Internal` comments
- [x] Replace `dataverse.pages.redhat.com` → GitHub references
- [x] Replace `gitlab.cee.redhat.com` → `github.com/redhat-data-and-ai`
- [x] Replace "Dataverse platform" → "Red Hat AI Templates" (where appropriate)
- [x] Remove internal Red Hat references (Snowflake, Atlan, etc.) → generic alternatives
- [x] Replace `#forum-dataverse` Slack → GitHub Discussions
- [x] Convert shortcodes using above mappings
- [x] Update image paths if needed
- [x] Remove OpenShift-specific references → generic Kubernetes where appropriate




