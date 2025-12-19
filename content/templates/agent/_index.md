---
title: "Agent Template"
weight: 20
description: "Build production-ready AI agents using LangGraph with enterprise security, observability, and Kubernetes deployment configurations."
github_repo: "https://github.com/redhat-data-and-ai/template-agent"
---

The AI Agent Template provides a production-ready foundation for building LangGraph-based AI agents that can orchestrate complex workflows, integrate with MCP servers, and deploy to Kubernetes.

## Overview

This template gives you everything you need to build sophisticated AI agents:

- **LangGraph Workflows** - State machines for complex agent behaviors
- **MCP Integration** - Connect to MCP servers for extended capabilities
- **Enterprise Security** - Authentication, authorization, and audit trails
- **Observability** - Logging, metrics, and tracing built-in
- **Kubernetes-Ready** - Production deployment configurations included

## Key Features

**Workflow Orchestration**
Build complex multi-step agent workflows with LangGraph's state machine patterns. Handle branching logic, error recovery, and human-in-the-loop interactions.

**MCP Client Integration**
Seamlessly connect to any MCP server to extend your agent's capabilities. Use tools for database queries, API calls, file operations, and more.

**Production Deployment**
Includes complete Kubernetes manifests, container configurations, and CI/CD pipeline templates for deploying to any Kubernetes cluster.

**Developer Experience**
Modern Python tooling with UV package manager, comprehensive testing, pre-commit hooks, and extensive documentation.

## Architecture

{{< mermaid >}}
graph TD
    A[User Request] --> B[Agent Workflow]
    B --> C{Task Planning}
    C --> D[Tool Selection]
    D --> E[MCP Client]
    E --> F[MCP Server Tools]
    F --> G[External Systems]
    G --> E
    E --> H[Response Formatting]
    H --> I[User Response]

    style B fill:#e3f2fd,stroke:#2196f3,stroke-width:2px
    style E fill:#f3e5f5,stroke:#9c27b0,stroke-width:2px
    style F fill:#fff3e0,stroke:#ff9800,stroke-width:2px
{{< /mermaid >}}

## Getting Started

{{< info >}}
**Repository**: [template-agent on GitHub](https://github.com/redhat-data-and-ai/template-agent)

Clone the repository and follow the README for complete setup instructions.
{{< /info >}}

### Quick Start

```bash
# Clone the template
git clone https://github.com/redhat-data-and-ai/template-agent.git
cd template-agent

# Set up environment
uv venv --python 3.12
source .venv/bin/activate

# Install dependencies
uv pip install -e ".[dev]"

# Run the agent
python -m agent_template.src.main
```

## Use Cases

**Data Analysis Agents**
Build agents that can query databases, analyze data, and generate insights using MCP servers for data access.

**DevOps Automation**
Create agents that automate deployment workflows, monitor systems, and respond to incidents.

**Document Processing**
Build agents that can read, summarize, and extract information from documents using specialized MCP tools.

**Multi-Step Workflows**
Orchestrate complex workflows that require multiple tools, decision points, and error handling.

## Technology Stack

- **LangGraph** - Workflow orchestration and state management
- **Python 3.12+** - Modern Python with type hints
- **MCP Client** - Integration with Model Context Protocol servers
- **FastAPI** - Optional REST API for agent interactions
- **Pydantic** - Configuration and data validation
- **pytest** - Comprehensive testing framework

## Next Steps

1. **Explore the repository** - [View on GitHub](https://github.com/redhat-data-and-ai/template-agent)
2. **Build an MCP server first** - [MCP Server Template](/templates/mcp-server/)
3. **Join the community** - [GitHub Discussions](https://github.com/redhat-data-and-ai/website/discussions)

{{< tip >}}
**Prerequisites**: Before building agents, we recommend setting up at least one MCP server to provide tools and capabilities for your agent to use.
{{< /tip >}}

## Documentation Status

This template is under active development. Complete documentation will be added as the template matures. For now, refer to the [GitHub repository](https://github.com/redhat-data-and-ai/template-agent) for the latest information.

