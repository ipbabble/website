---
title: "UI Template"
weight: 30
description: "Deploy modern chat interfaces built with React and FastAPI that work seamlessly with AI agents for production-ready user experiences."
github_repo: "https://github.com/redhat-data-and-ai/template-ui"
---

The UI Template provides a production-ready chat interface that connects users to your AI agents. Built with React and FastAPI, it delivers a modern, responsive user experience with enterprise features.

## Overview

This template gives you a complete chat UI for your AI applications:

- **Modern React Frontend** - Responsive, accessible chat interface
- **FastAPI Backend** - High-performance API gateway to your agents
- **Real-time Communication** - WebSocket support for streaming responses
- **Authentication** - Built-in user authentication and session management
- **Kubernetes-Ready** - Production deployment configurations included

## Key Features

**React Chat Interface**
Beautiful, responsive chat UI with support for markdown rendering, code highlighting, and rich media. Mobile-friendly and accessible.

**Agent Integration**
Seamlessly connects to AI agents built with the Agent Template. Supports streaming responses, multi-turn conversations, and context management.

**Production Features**
Includes authentication, rate limiting, error handling, logging, and monitoring. Deploy with confidence.

**Customizable**
Easy to theme and customize. Add your branding, adjust colors, and modify the layout to match your needs.

## Architecture

{{< mermaid >}}
graph TD
    A[Web Browser] --> B[React Frontend]
    B --> C[FastAPI Backend]
    C --> D[AI Agent]
    D --> E[MCP Servers]
    
    B -->|WebSocket| C
    C -->|Streaming| D

    style B fill:#e8f5e9,stroke:#4caf50,stroke-width:2px
    style C fill:#fff3e0,stroke:#ff9800,stroke-width:2px
    style D fill:#e3f2fd,stroke:#2196f3,stroke-width:2px
    style E fill:#f3e5f5,stroke:#9c27b0,stroke-width:2px
{{< /mermaid >}}

## Getting Started

{{< info >}}
**Repository**: [template-ui on GitHub](https://github.com/redhat-data-and-ai/template-ui)

Clone the repository and follow the README for complete setup instructions.
{{< /info >}}

### Quick Start

```bash
# Clone the template
git clone https://github.com/redhat-data-and-ai/template-ui.git
cd template-ui

# Install frontend dependencies
cd frontend
npm install
npm run dev

# In another terminal, start backend
cd ../backend
uv venv --python 3.12
source .venv/bin/activate
uv pip install -e ".[dev]"
python -m backend.main
```

## Technology Stack

**Frontend:**
- **React 18** - Modern React with hooks
- **TypeScript** - Type-safe development
- **Vite** - Fast build tooling
- **TailwindCSS** - Utility-first styling
- **React Markdown** - Rich text rendering

**Backend:**
- **FastAPI** - High-performance Python framework
- **WebSockets** - Real-time communication
- **Pydantic** - Data validation
- **JWT Authentication** - Secure user sessions

## Use Cases

**Customer Support Chat**
Deploy a chat interface for customer support powered by AI agents with access to your knowledge base via MCP servers.

**Internal Tools**
Create chat interfaces for internal teams to interact with company data, systems, and workflows.

**Developer Documentation**
Build interactive documentation where users can ask questions and get code examples from your AI agent.

**Data Exploration**
Provide a chat interface for non-technical users to query and explore data using natural language.

## Features

### User Experience

- **Streaming Responses** - See AI responses as they're generated
- **Markdown Support** - Rich formatting with code highlighting
- **Conversation History** - Save and resume conversations
- **Multi-turn Context** - Agents remember conversation history
- **Copy/Share** - Easy sharing of conversations and responses

### Enterprise Features

- **Authentication** - User login and session management
- **Rate Limiting** - Prevent abuse and manage costs
- **Audit Logging** - Track all interactions
- **Error Handling** - Graceful degradation and error messages
- **Mobile Responsive** - Works on all devices

## Next Steps

1. **Explore the repository** - [View on GitHub](https://github.com/redhat-data-and-ai/template-ui)
2. **Build an agent first** - [Agent Template](/templates/agent/)
3. **Set up MCP servers** - [MCP Server Template](/templates/mcp-server/)
4. **Join the community** - [GitHub Discussions](https://github.com/redhat-data-and-ai/website/discussions)

{{< tip >}}
**Full Stack**: For a complete AI application, combine this UI template with the Agent Template and MCP Server Template for a full stack solution.
{{< /tip >}}

## Documentation Status

This template is under active development. Complete documentation will be added as the template matures. For now, refer to the [GitHub repository](https://github.com/redhat-data-and-ai/template-ui) for the latest information.

