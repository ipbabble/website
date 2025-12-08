# GO LIVE - Step by Step

**Current Status:** Code pushed to staging repo  
**Goal:** Make site publicly accessible at aitemplates.io

---

## ✅ Step 1: Enable GitHub Pages (Staging First)

### 1.1: Go to GitHub Pages Settings

Open: https://github.com/ipbabble/aitemplates-site/settings/pages

### 1.2: Configure Build Source

Under "Build and deployment":
- **Source:** Select "GitHub Actions"
- Click **Save**

### 1.3: Wait for First Deploy

1. Go to: https://github.com/ipbabble/aitemplates-site/actions
2. You should see "Deploy Hugo site to GitHub Pages" workflow running
3. Wait ~2-3 minutes
4. When you see green checkmark ✅, deployment succeeded

### 1.4: Test Staging Site

Visit: **https://ipbabble.github.io/aitemplates-site/**

Verify:
- [ ] Site loads
- [ ] Homepage shows AI Templates branding
- [ ] Navigation works
- [ ] All templates accessible
- [ ] No broken links

---

## 🌐 Step 2: Configure DNS for Custom Domain

### 2.1: Log into Your Domain Registrar

Go to wherever you purchased `aitemplates.io` (GoDaddy, Namecheap, Cloudflare, etc.)

### 2.2: Add DNS Records

Add these **A records** (for apex domain):

| Type | Name | Value | TTL |
|------|------|-------|-----|
| A | @ | 185.199.108.153 | 3600 |
| A | @ | 185.199.109.153 | 3600 |
| A | @ | 185.199.110.153 | 3600 |
| A | @ | 185.199.111.153 | 3600 |

Add this **CNAME record** (for www subdomain):

| Type | Name | Value | TTL |
|------|------|-------|-----|
| CNAME | www | redhat-data-and-ai.github.io. | 3600 |

**Important:** Note the trailing `.` in the CNAME value!

### 2.3: Wait for DNS Propagation

DNS changes take time:
- **Minimum:** 5-10 minutes
- **Typical:** 30-60 minutes  
- **Maximum:** 24-48 hours

**Test DNS:**
```bash
# Check if DNS is updated
dig aitemplates.io +short

# Should show one of the GitHub IPs:
# 185.199.108.153
# 185.199.109.153
# 185.199.110.153
# 185.199.111.153
```

---

## 🚀 Step 3: Push to Production Repo

### 3.1: Verify Upstream Remote

```bash
cd /Users/whenry/github/aipatterns
git remote -v

# Should show:
# origin    git@github.com:ipbabble/aitemplates-site.git
# upstream  git@github.com:redhat-data-and-ai/website.git
```

### 3.2: Push to Production

```bash
# Push all commits to upstream (production)
git push upstream main
```

### 3.3: Enable GitHub Pages on Production

1. Go to: https://github.com/redhat-data-and-ai/website/settings/pages
2. Under "Build and deployment":
   - **Source:** GitHub Actions
   - **Custom domain:** `aitemplates.io`
   - Click Save
3. Wait for "DNS check" - may take a few minutes
4. Once DNS verified, check **"Enforce HTTPS"**

### 3.4: Wait for SSL Certificate

- GitHub automatically provisions SSL via Let's Encrypt
- Takes 5-15 minutes after DNS verification
- You'll see "HTTPS enforced" when ready

---

## 🎉 Step 4: Verify Live Site

### 4.1: Test Production URL

Visit: **https://aitemplates.io/**

Check:
- [ ] Site loads with HTTPS (🔒 in browser)
- [ ] All pages work
- [ ] No certificate warnings
- [ ] Mobile responsive

### 4.2: Test www Subdomain

Visit: **https://www.aitemplates.io/**

Should redirect to: **https://aitemplates.io/**

---

## 📊 Current Status Checklist

Where are you now? Check what's complete:

- [ ] **Code pushed to staging** (ipbabble/aitemplates-site)
- [ ] **GitHub Pages enabled on staging**
- [ ] **Staging site accessible** (ipbabble.github.io/aitemplates-site)
- [ ] **DNS records added** at domain registrar
- [ ] **DNS propagated** (dig shows GitHub IPs)
- [ ] **Code pushed to production** (redhat-data-and-ai/website)
- [ ] **GitHub Pages enabled on production**
- [ ] **Custom domain configured** (aitemplates.io)
- [ ] **HTTPS enforced**
- [ ] **Production site live** (https://aitemplates.io/)

---

## 🔧 Troubleshooting

### GitHub Actions Failing

- Check Actions tab for error logs
- Verify Hugo version in workflow
- Check for missing dependencies

### DNS Not Resolving

```bash
# Check current DNS
dig aitemplates.io

# Check www subdomain
dig www.aitemplates.io

# If not showing GitHub IPs, wait longer or check registrar settings
```

### SSL Certificate Not Provisioning

- Ensure DNS is fully propagated first
- Wait 15 minutes after DNS verification
- Try unchecking and re-checking "Enforce HTTPS"

### Site Shows 404

- Verify CNAME file contains: `aitemplates.io`
- Check baseURL in config.yaml: `https://aitemplates.io/`
- Wait a few minutes, GitHub Pages caches aggressively

---

## 🎯 Summary

**Staging → Production Flow:**

1. **Test on staging** (ipbabble.github.io/aitemplates-site)
2. **Configure DNS** (point aitemplates.io to GitHub)
3. **Push to production** (redhat-data-and-ai/website)
4. **Enable custom domain** in GitHub Pages settings
5. **Wait for HTTPS** certificate provisioning
6. **Live!** (https://aitemplates.io/)

**You're currently at:** Step 1 (code is pushed, now enable GitHub Pages)

**Next action:** Go to https://github.com/ipbabble/aitemplates-site/settings/pages

