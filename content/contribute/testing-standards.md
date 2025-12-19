---
title: "Testing Standards"
weight: 30
description: "Quality standards and testing requirements for AI Templates. Ensure your template meets our standards before submission."
---

# Template Testing Standards

**Status:** Coming Soon

Guidelines for testing AI Templates before submission.

## Testing Checklist (Draft)

Before contributing or updating a template:

### Code Quality

- [ ] **Linting passes**: No linting errors
- [ ] **Type hints**: Full type coverage
- [ ] **Pre-commit hooks**: Configured and passing
- [ ] **Code formatting**: Black, prettier, or equivalent

### Testing

- [ ] **Unit tests**: >80% coverage
- [ ] **Integration tests**: Key workflows tested
- [ ] **Container tests**: Build and run successfully
- [ ] **End-to-end tests**: Full stack works

### Documentation

- [ ] **README**: Complete setup instructions
- [ ] **Quick Start**: Working in <15 minutes
- [ ] **API docs**: All functions documented
- [ ] **Examples**: Working code samples

### Deployment

- [ ] **Kubernetes manifests**: Valid and tested
- [ ] **Environment configs**: Example .env files
- [ ] **Security**: No hardcoded secrets
- [ ] **Health checks**: Liveness and readiness probes

## Test Frameworks

Recommended testing tools:

- **Python**: pytest, pytest-asyncio, pytest-cov
- **JavaScript**: Jest, Vitest
- **Integration**: Podman Compose, Kind, Docker Compose
- **E2E**: Playwright, Cypress

## CI/CD Requirements

Templates should include:

- GitHub Actions workflow (or equivalent)
- Automated testing on PR
- Container image builds
- Security scanning

## Questions?

For testing questions, visit [GitHub Discussions](https://github.com/redhat-data-and-ai/website/discussions).

**Full testing standards coming soon!**

