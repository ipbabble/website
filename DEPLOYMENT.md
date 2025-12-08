# Deploying AI Templates Documentation

## Quick Deploy to GitHub Pages

### Step 1: Verify Git Remote

Check that your remote is correctly configured:

```bash
cd /Users/whenry/github/aipatterns

# Check current remote
git remote -v

# Should show one of:
# Staging:    git@github.com:ipbabble/aitemplates-site.git
# Production: git@github.com:redhat-data-and-ai/website.git
```

### Step 2: Commit Your Changes

```bash
# Stage all changes
git add .

# Commit
git commit -m "feat: complete AI Templates documentation site migration

- Migrated all template documentation (MCP Server, Agent, UI)
- Added Tools guides (Cursor, Claude Desktop)
- Created Contribute section
- Updated branding and colors
- All content sanitized for public use
- 41 pages, 0 errors, production ready"

# Push to main
git push origin main
```

### Step 3: Enable GitHub Pages

1. Go to your GitHub repo settings → Pages
   - Staging: https://github.com/ipbabble/aitemplates-site/settings/pages
   - Production: https://github.com/redhat-data-and-ai/website/settings/pages
2. Under "Build and deployment":
   - Source: **GitHub Actions**
   - Custom domain: `aitemplates.io` (production only)
   - Enforce HTTPS: Check (after DNS propagates)
3. Save

The GitHub Actions workflow (`.github/workflows/deploy.yml`) will automatically:
- Build the Hugo site
- Deploy to GitHub Pages
- Make it available at your configured domain

### Step 4: Wait for Deployment

- Go to **Actions** tab in GitHub
- Watch the "Deploy Hugo site to GitHub Pages" workflow
- Takes about 2-3 minutes
- When green checkmark appears, site is live!

## Manual Build (Testing)

To test the production build locally:

```bash
cd /Users/whenry/github/aipatterns

# Build static site
export PATH="/opt/homebrew/bin:$PATH"
hugo --cleanDestinationDir --minify

# Output is in public/ directory
# You can preview with: python3 -m http.server 8000 -d public
```

## Troubleshooting

**Build fails on GitHub Actions:**
- Check the Actions log for specific errors
- Verify all files are committed
- Ensure .gitignore doesn't exclude necessary files

**Site shows but looks broken:**
- Check baseURL in config.yaml matches your GitHub Pages URL
- Verify all static assets are included
- Check browser console for 404 errors

**Changes don't appear:**
- Wait 1-2 minutes for GitHub Pages to update
- Hard refresh browser (Cmd+Shift+R)
- Check Actions tab to ensure deploy succeeded

## Site is Live!

Once deployed, your site will be at:

**Staging:** https://ipbabble.github.io/aitemplates-site/  
**Production:** https://aitemplates.io/

Share it with the world! 🚀

