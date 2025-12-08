---
title: "Quick Start"
weight: 5
description: "Deploy your chat interface in minutes with React frontend and FastAPI backend."
---

Get your AI chat interface up and running quickly! This guide walks you through cloning the template, configuring the backend, and launching your first chat UI.

## Prerequisites

Before you begin, ensure you have:

- **Node.js 18+** and **npm** installed
- **Python 3.12+** installed
- **UV package manager** ([installation guide](https://docs.astral.sh/uv/getting-started/installation/))
- **An AI agent** running (see [Agent Template](/templates/agent/))

## Step 1: Clone the Template

```bash
# Clone the UI template
git clone https://github.com/redhat-data-and-ai/template-ui.git
cd template-ui
```

## Step 2: Start the Backend

The backend connects your UI to your AI agent:

```bash
# Navigate to backend
cd backend

# Set up Python environment
uv venv --python 3.12
source .venv/bin/activate

# Install dependencies
uv pip install -e ".[dev]"

# Configure agent connection
cat > .env << EOF
AGENT_URL=http://localhost:8000
PORT=8001
EOF

# Start the backend
python -m backend.main
```

The backend will be available at `http://localhost:8001`

## Step 3: Start the Frontend

In a new terminal:

```bash
# Navigate to frontend
cd frontend

# Install dependencies
npm install

# Configure backend connection
cat > .env.local << EOF
VITE_API_URL=http://localhost:8001
EOF

# Start the development server
npm run dev
```

The UI will be available at `http://localhost:5173`

## Step 4: Test Your Chat Interface

1. Open your browser to `http://localhost:5173`
2. You should see the chat interface
3. Type a message and send it
4. The UI will communicate with your agent through the backend

{{< info >}}
**Agent Required**: The UI needs an AI agent backend to function. Make sure you have an agent running (see [Agent Template](/templates/agent/)) before testing the UI.
{{< /info >}}

## Step 5: Customize the UI

Now that it's working, customize it:

### Branding

Edit `frontend/src/config.ts`:

```typescript
export const config = {
  appName: "Your App Name",
  welcomeMessage: "Hello! How can I help you today?",
  theme: {
    primaryColor: "#667eea",
    // ... more theme options
  }
}
```

### Features

Enable/disable features in `frontend/src/features.ts`:

```typescript
export const features = {
  markdown: true,
  codeHighlight: true,
  fileUpload: false,
  voiceInput: false,
}
```

## Step 6: Deploy to Production

When ready for production:

```bash
# Build frontend
cd frontend
npm run build

# Build backend container
cd ../backend
podman build -t your-registry/chat-backend:v1.0 .

# Deploy to Kubernetes (manifests included in /kubernetes/)
kubectl apply -f kubernetes/
```

## Next Steps

- **Customize styling**: Update TailwindCSS theme in `frontend/tailwind.config.js`
- **Add authentication**: Enable user login (templates included)
- **Connect to your agent**: Point to your production agent URL
- **Monitor usage**: Set up logging and analytics

{{< tip >}}
**Development Tip**: Use the included Podman Compose file (`compose.yaml`) to run the entire stack (frontend + backend + agent) together during development. Works with both Podman and Docker.
{{< /tip >}}

## Troubleshooting

**UI can't connect to backend**
- Check that backend is running on port 8001
- Verify CORS settings in backend allow frontend origin
- Check browser console for connection errors

**Chat not responding**
- Ensure your AI agent is running and accessible
- Check backend logs for agent connection errors
- Verify agent URL in backend configuration

**Styling issues**
- Run `npm run build` to rebuild after theme changes
- Clear browser cache (Cmd+Shift+R)
- Check TailwindCSS configuration

For more help, visit [GitHub Issues](https://github.com/redhat-data-and-ai/template-ui/issues).

