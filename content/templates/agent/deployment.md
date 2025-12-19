---
title: "Deployment Guide"
weight: 10
description: "Deploy your AI agent to Kubernetes with enterprise security, monitoring, and scaling."
---

This guide covers deploying your AI agent to production on Kubernetes, including configuration, monitoring, and scaling considerations.

## Prerequisites

Before deploying to production:

- Kubernetes cluster access
- Container registry access
- MCP servers deployed and accessible
- LLM API keys configured
- Agent tested locally

## Step 1: Build Container Image

```bash
# Build the agent container
podman build -t your-registry/ai-agent:v1.0 .

# Push to registry
podman push your-registry/ai-agent:v1.0
```

## Step 2: Configure Secrets

Create Kubernetes secrets for sensitive data:

```bash
# Create secret for LLM API key
kubectl create secret generic agent-secrets \
  --from-literal=llm-api-key=your-key-here \
  --from-literal=mcp-server-token=your-token \
  -n ai-agents

# Create configmap for MCP server URLs
kubectl create configmap agent-config \
  --from-literal=mcp-servers=http://mcp-server.default.svc:3000/mcp \
  -n ai-agents
```

## Step 3: Deploy to Kubernetes

```yaml
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ai-agent
  namespace: ai-agents
spec:
  replicas: 2
  selector:
    matchLabels:
      app: ai-agent
  template:
    metadata:
      labels:
        app: ai-agent
    spec:
      containers:
      - name: agent
        image: your-registry/ai-agent:v1.0
        env:
        - name: LLM_API_KEY
          valueFrom:
            secretKeyRef:
              name: agent-secrets
              key: llm-api-key
        - name: MCP_SERVERS
          valueFrom:
            configMapKeyRef:
              name: agent-config
              key: mcp-servers
        resources:
          requests:
            memory: "512Mi"
            cpu: "250m"
          limits:
            memory: "1Gi"
            cpu: "1000m"
        livenessProbe:
          httpGet:
            path: /health
            port: 8000
          initialDelaySeconds: 30
        readinessProbe:
          httpGet:
            path: /ready
            port: 8000
```

Apply the deployment:

```bash
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
```

## Step 4: Monitoring

### Health Checks

Monitor agent health:

```bash
# Check pod status
kubectl get pods -n ai-agents

# View logs
kubectl logs -f deployment/ai-agent -n ai-agents

# Check health endpoint
kubectl port-forward svc/ai-agent 8000:8000 -n ai-agents
curl http://localhost:8000/health
```

### Metrics

The template includes Prometheus metrics:

- Request count and latency
- MCP tool usage
- LLM token consumption
- Error rates

## Step 5: Scaling

### Horizontal Scaling

```bash
# Scale manually
kubectl scale deployment ai-agent --replicas=5 -n ai-agents

# Or use HPA (Horizontal Pod Autoscaler)
kubectl autoscale deployment ai-agent \
  --cpu-percent=70 \
  --min=2 \
  --max=10 \
  -n ai-agents
```

### Performance Tuning

Adjust based on load:

- **Memory**: Increase for large context windows
- **CPU**: Increase for CPU-intensive processing
- **Replicas**: Scale based on request volume

## Security Considerations

- **API Keys**: Always use Kubernetes secrets
- **Network Policies**: Restrict agent-to-MCP communication
- **RBAC**: Limit service account permissions
- **Audit Logging**: Enable for compliance

## Next Steps

- **Monitor performance**: Set up dashboards
- **Configure alerts**: Get notified of issues
- **Scale as needed**: Adjust resources based on usage
- **Update regularly**: Deploy new versions safely

For deployment questions, visit [GitHub Discussions](https://github.com/redhat-data-and-ai/website/discussions).




