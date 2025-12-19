---
title: "Contributing Documentation"
weight: 10
description: "Help improve the AI Templates documentation. Fork the repo, make changes, and submit pull requests."
---

# Contributing to Documentation

Help improve the AI Templates documentation! This guide shows you how to contribute to this site.

## Quick Start

1. **Fork the repository**: [AI Templates website on GitHub](https://github.com/redhat-data-and-ai/website)
2. **Make your changes**: Edit markdown files in `content/`
3. **Test locally**: Run `./serve.sh` to preview
4. **Submit a pull request**: Include description of changes

## Documentation Structure

```
content/
├── templates/          # Template documentation
│   ├── mcp-server/    # MCP Server guides
│   ├── agent/         # Agent guides
│   └── ui/            # UI guides
├── tools/             # Tool setup guides
├── guides/            # Tutorials (placeholder)
└── reference/         # Technical reference (placeholder)
```

## Writing Guidelines

### Style

- **Clear and concise**: Get to the point quickly
- **Code examples**: Include working code samples
- **Test instructions**: Verify all steps work
- **No emojis**: Keep it professional

### Markdown Format

We use Markdown with custom shortcodes:

```markdown
{{< info >}}
Important information here
{{< /info >}}

{{< tip >}}
Helpful tip here
{{< /tip >}}

{{< warning >}}
Warning message here
{{< /warning >}}
```

### Diagrams

Use Mermaid for diagrams:

```markdown
{{< mermaid >}}
graph TD
    A[Start] --> B[End]
{{< /mermaid >}}
```

## Testing Changes

Before submitting:

```bash
# Run local server
./serve.sh

# Check for broken links
# Verify formatting
# Test on multiple screen sizes
```

## Submitting Changes

1. **Create a branch**: `git checkout -b fix/improve-docs`
2. **Make changes**: Edit files, test locally
3. **Commit**: `git commit -m "docs: improve MCP server guide"`
4. **Push**: `git push origin fix/improve-docs`
5. **Open PR**: Create pull request on GitHub

## Need Help?

- **Questions**: [GitHub Discussions](https://github.com/redhat-data-and-ai/website/discussions)
- **Issues**: File in the [website repository](https://github.com/redhat-data-and-ai/website/issues)

Thank you for contributing! 🙏

