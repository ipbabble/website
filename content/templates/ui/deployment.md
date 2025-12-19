---
title: "Deployment Guide"
weight: 10
description: "Deploy your chat UI to production with frontend, backend, and CDN configuration."
---

This guide covers deploying your chat UI to production, including frontend deployment, backend API setup, and CDN configuration.

## Prerequisites

Before deploying:

- Kubernetes cluster or hosting platform
- Container registry access
- Domain name (optional but recommended)
- SSL certificate (Let's Encrypt or other)
- Backend agent deployed and accessible

## Step 1: Build Production Assets

### Build Frontend

```bash
cd frontend

# Install dependencies
npm install

# Build for production
npm run build

# Output will be in frontend/dist/
```

### Build Backend Container

```bash
cd backend

# Build container
podman build -t your-registry/chat-backend:v1.0 .

# Push to registry
podman push your-registry/chat-backend:v1.0
```

## Step 2: Deploy Backend to Kubernetes

```yaml
# backend-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: chat-backend
spec:
  replicas: 3
  template:
    spec:
      containers:
      - name: backend
        image: your-registry/chat-backend:v1.0
        env:
        - name: AGENT_URL
          value: "http://ai-agent.ai-agents.svc:8000"
        - name: CORS_ORIGINS
          value: "https://your-domain.com"
        ports:
        - containerPort: 8001
        resources:
          requests:
            memory: "256Mi"
            cpu: "100m"
          limits:
            memory: "512Mi"
            cpu: "500m"
```

```bash
kubectl apply -f kubernetes/backend/
```

## Step 3: Deploy Frontend

### Option A: Static Hosting (Recommended)

Deploy frontend to CDN or static hosting:

**GitHub Pages:**
```bash
# Build
npm run build

# Deploy to gh-pages branch
npm run deploy
```

**Netlify/Vercel:**
```bash
# Connect your repo
# Set build command: npm run build
# Set publish directory: dist
```

### Option B: Kubernetes Deployment

```yaml
# frontend-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: chat-frontend
spec:
  replicas: 2
  template:
    spec:
      containers:
      - name: frontend
        image: nginx:alpine
        volumeMounts:
        - name: frontend-files
          mountPath: /usr/share/nginx/html
      volumes:
      - name: frontend-files
        configMap:
          name: frontend-dist
```

## Step 4: Configure Domain & SSL

### Set up Ingress

```yaml
# ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: chat-ui
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
spec:
  tls:
  - hosts:
    - chat.your-domain.com
    secretName: chat-tls
  rules:
  - host: chat.your-domain.com
    http:
      paths:
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: chat-backend
            port:
              number: 8001
      - path: /
        pathType: Prefix
        backend:
          service:
            name: chat-frontend
            port:
              number: 80
```

## Step 5: Environment Configuration

### Frontend Environment Variables

Create `.env.production`:

```bash
VITE_API_URL=https://chat.your-domain.com/api
VITE_APP_NAME=Your Chat App
VITE_ENABLE_AUTH=true
```

### Backend Environment Variables

```bash
# In Kubernetes deployment
env:
- name: AGENT_URL
  value: "http://ai-agent:8000"
- name: CORS_ORIGINS
  value: "https://chat.your-domain.com"
- name: JWT_SECRET
  valueFrom:
    secretKeyRef:
      name: backend-secrets
      key: jwt-secret
```

## Step 6: Monitoring & Logging

### Health Checks

```bash
# Check backend health
curl https://chat.your-domain.com/api/health

# Check frontend
curl https://chat.your-domain.com/

# View logs
kubectl logs -f deployment/chat-backend
```

### Metrics

Monitor key metrics:

- Response times
- Error rates
- Active users
- Message throughput
- Agent call success rate

## Step 7: Security Checklist

- [ ] **HTTPS enabled** with valid SSL certificate
- [ ] **CORS configured** properly for your domain
- [ ] **API keys** stored in Kubernetes secrets
- [ ] **Rate limiting** enabled on backend
- [ ] **Authentication** configured if needed
- [ ] **Input validation** on all endpoints
- [ ] **Security headers** configured

## Scaling Considerations

### Frontend

- **CDN**: Use CloudFlare, Cloudfront, or similar
- **Caching**: Set appropriate cache headers
- **Compression**: Enable gzip/brotli

### Backend

- **Horizontal scaling**: Add more replicas as needed
- **Connection pooling**: Optimize agent connections
- **Caching**: Cache agent responses when appropriate

## Next Steps

- **Monitor usage**: Set up analytics
- **Gather feedback**: Collect user feedback
- **Iterate**: Improve based on real usage
- **Scale**: Adjust resources as traffic grows

For deployment questions, visit [GitHub Discussions](https://github.com/redhat-data-and-ai/website/discussions).




